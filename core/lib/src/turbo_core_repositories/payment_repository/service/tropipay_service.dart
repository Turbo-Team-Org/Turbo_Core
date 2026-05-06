import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_payment_request.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_payment_response.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_webhook.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_result.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_transaction.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_method.dart';

/// Servicio para integración con la API de Tropipay
class TropipayService {
  final Dio _dio;
  final String _clientId;
  final String _clientSecret;
  final String _baseUrl;
  final String? _webhookSecret;

  TropipayService({
    required Dio dio,
    required String clientId,
    required String clientSecret,
    String baseUrl = 'https://tropipay.com/api/v1',
    String? webhookSecret,
  }) : _dio = dio,
       _clientId = clientId,
       _clientSecret = clientSecret,
       _baseUrl = baseUrl,
       _webhookSecret = webhookSecret;

  /// Token de acceso para autenticación
  String? _accessToken;
  DateTime? _tokenExpiry;

  /// Obtiene un token de acceso válido
  Future<String> _getAccessToken() async {
    // Verificar si el token actual es válido
    if (_accessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _accessToken!;
    }

    try {
      final response = await _dio.post(
        '$_baseUrl/auth/token',
        data: {
          'grant_type': 'client_credentials',
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        _accessToken = data['access_token'] as String?;
        final expiresIn = data['expires_in'] as int? ?? 3600;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));

        return _accessToken!;
      } else {
        throw TropipayException(
          'Error obteniendo token de acceso: ${response.statusCode}',
          response.data,
        );
      }
    } catch (e) {
      throw TropipayException('Error de autenticación con Tropipay: $e');
    }
  }

  /// Crea un pago en Tropipay
  Future<PaymentResult> createPayment(TropipayPaymentRequest request) async {
    try {
      // Validar la request antes de enviar
      final validationErrors = request.validate();
      if (validationErrors.isNotEmpty) {
        return PaymentResult.error(
          errorCode: 'validation_error',
          errorDetails: validationErrors.join(', '),
        );
      }

      // Obtener token de acceso
      final token = await _getAccessToken();

      // Preparar datos para la API
      final apiData = request.toTropipayApiFormat();

      final response = await _dio.post(
        '$_baseUrl/payments',
        data: apiData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = TropipayPaymentResponse.fromApiResponse(
          response.data as Map<String, dynamic>,
        );

        return PaymentResult.success(
          payment: _convertToPayment(request, responseData),
          redirectUrl: responseData.redirectUrl,
          paymentUrl: responseData.paymentUrl,
          message: responseData.userFriendlyMessage,
          metadata: responseData.metadata,
        );
      } else {
        return PaymentResult.error(
          errorCode: 'api_error',
          errorDetails: 'Error en la API de Tropipay: ${response.statusCode}',
          metadata: {'response_data': response.data},
        );
      }
    } catch (e) {
      if (e is DioException) {
        return _handleDioError(e);
      }
      return PaymentResult.error(
        errorCode: 'unknown_error',
        errorDetails: 'Error inesperado: $e',
      );
    }
  }

  /// Obtiene el estado de un pago
  Future<PaymentResult> getPaymentStatus(String transactionId) async {
    try {
      final token = await _getAccessToken();

      final response = await _dio.get(
        '$_baseUrl/payments/$transactionId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final responseData = TropipayPaymentResponse.fromApiResponse(
          response.data as Map<String, dynamic>,
        );

        return PaymentResult.success(
          payment: _convertToPaymentFromResponse(responseData),
          message: responseData.userFriendlyMessage,
          metadata: responseData.metadata,
        );
      } else {
        return PaymentResult.error(
          errorCode: 'api_error',
          errorDetails:
              'Error obteniendo estado del pago: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        return _handleDioError(e);
      }
      return PaymentResult.error(
        errorCode: 'unknown_error',
        errorDetails: 'Error inesperado: $e',
      );
    }
  }

  /// Cancela un pago
  Future<PaymentResult> cancelPayment(String transactionId) async {
    try {
      final token = await _getAccessToken();

      final response = await _dio.post(
        '$_baseUrl/payments/$transactionId/cancel',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final responseData = TropipayPaymentResponse.fromApiResponse(
          response.data as Map<String, dynamic>,
        );

        return PaymentResult.success(
          payment: _convertToPaymentFromResponse(responseData),
          message: 'Pago cancelado exitosamente',
          metadata: responseData.metadata,
        );
      } else {
        return PaymentResult.error(
          errorCode: 'api_error',
          errorDetails: 'Error cancelando pago: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        return _handleDioError(e);
      }
      return PaymentResult.error(
        errorCode: 'unknown_error',
        errorDetails: 'Error inesperado: $e',
      );
    }
  }

  /// Procesa un reembolso
  Future<PaymentResult> processRefund(
    String transactionId, {
    double? amount,
    String? reason,
  }) async {
    try {
      final token = await _getAccessToken();

      final response = await _dio.post(
        '$_baseUrl/payments/$transactionId/refund',
        data: {
          if (amount != null) 'amount': amount,
          if (reason != null) 'reason': reason,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = TropipayPaymentResponse.fromApiResponse(
          response.data as Map<String, dynamic>,
        );

        return PaymentResult.success(
          payment: _convertToPaymentFromResponse(responseData),
          message: 'Reembolso procesado exitosamente',
          metadata: responseData.metadata,
        );
      } else {
        return PaymentResult.error(
          errorCode: 'api_error',
          errorDetails: 'Error procesando reembolso: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        return _handleDioError(e);
      }
      return PaymentResult.error(
        errorCode: 'unknown_error',
        errorDetails: 'Error inesperado: $e',
      );
    }
  }

  /// Obtiene el historial de pagos
  Future<List<PaymentTransaction>> getPaymentHistory({
    String? userId,
    String? placeId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final token = await _getAccessToken();

      final queryParams = <String, dynamic>{'limit': limit, 'offset': offset};

      if (userId != null) queryParams['user_id'] = userId;
      if (placeId != null) queryParams['place_id'] = placeId;

      final response = await _dio.get(
        '$_baseUrl/payments',
        queryParameters: queryParams,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> payments =
            data['payments'] as List<dynamic>? ??
            data['data'] as List<dynamic>? ??
            [];

        return payments
            .map(
              (payment) => PaymentTransaction.fromTropipayResponse(
                payment as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        throw TropipayException(
          'Error obteniendo historial de pagos: ${response.statusCode}',
          response.data,
        );
      }
    } catch (e) {
      throw TropipayException('Error obteniendo historial: $e');
    }
  }

  /// Verifica la configuración de Tropipay
  Future<bool> verifyConfiguration() async {
    try {
      final token = await _getAccessToken();

      final response = await _dio.get(
        '$_baseUrl/auth/verify',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Procesa un webhook de Tropipay
  Future<TropipayWebhook> processWebhook(
    Map<String, dynamic> payload,
    String signature,
  ) async {
    try {
      final webhook = TropipayWebhook.fromTropipayPayload(payload);

      // Verificar la firma del webhook si está configurada
      if (_webhookSecret != null) {
        final expectedSignature = _generateWebhookSignature(payload);
        if (signature != expectedSignature) {
          throw TropipayException('Firma de webhook inválida');
        }
      }

      return webhook;
    } catch (e) {
      throw TropipayException('Error procesando webhook: $e');
    }
  }

  /// Genera la firma del webhook
  String _generateWebhookSignature(Map<String, dynamic> payload) {
    if (_webhookSecret == null) return '';

    final payloadString = jsonEncode(payload);
    final bytes = utf8.encode('$payloadString$_webhookSecret');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Convierte una request y response a un Payment
  Payment _convertToPayment(
    TropipayPaymentRequest request,
    TropipayPaymentResponse response,
  ) {
    return Payment(
      id: response.paymentId ?? response.transactionId ?? '',
      userId: request.userId,
      placeId: request.placeId,
      reservationId: request.reservationId,
      amount: response.amount,
      currency: response.currency,
      paymentMethod: request.paymentMethod,
      status: response.status,
      description: response.description ?? request.description,
      metadata: {
        ...request.metadata,
        ...response.metadata,
        'tropipay_transaction_id': response.transactionId,
      },
      returnUrl: request.returnUrl,
      cancelUrl: request.cancelUrl,
      gatewayTransactionId: response.transactionId,
      externalReference:
          response.externalReference ?? request.externalReference,
      createdAt: response.createdAt,
      expiresAt: response.expiresAt,
      cardLastFourDigits: response.cardData?.lastFourDigits,
      cardType: response.cardData?.cardType,
      gatewayFee: response.fees?.tropipayFee,
      netAmount: response.fees?.netAmount,
    );
  }

  /// Convierte una response a un Payment
  Payment _convertToPaymentFromResponse(TropipayPaymentResponse response) {
    return Payment(
      id: response.paymentId ?? response.transactionId ?? '',
      userId: response.metadata['user_id']?.toString() ?? '',
      placeId: response.metadata['place_id']?.toString() ?? '',
      reservationId: response.metadata['reservation_id']?.toString(),
      amount: response.amount,
      currency: response.currency,
      paymentMethod: _parsePaymentMethod(
        response.metadata['payment_method']?.toString() ?? 'card',
      ),
      status: response.status,
      description: response.description,
      metadata: response.metadata,
      gatewayTransactionId: response.transactionId,
      externalReference: response.externalReference,
      createdAt: response.createdAt,
      expiresAt: response.expiresAt,
      cardLastFourDigits: response.cardData?.lastFourDigits,
      cardType: response.cardData?.cardType,
      gatewayFee: response.fees?.tropipayFee,
      netAmount: response.fees?.netAmount,
    );
  }

  /// Maneja errores de Dio
  PaymentResult _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return PaymentResult.error(
          errorCode: 'timeout',
          errorDetails: 'Tiempo de espera agotado',
        );

      case DioExceptionType.connectionError:
        return PaymentResult.error(
          errorCode: 'network_error',
          errorDetails: 'Error de conexión',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final responseData = error.response?.data;

        return PaymentResult.error(
          errorCode: 'api_error',
          errorDetails: 'Error de API: $statusCode',
          metadata: {'response_data': responseData},
        );

      case DioExceptionType.cancel:
        return PaymentResult.error(
          errorCode: 'cancelled',
          errorDetails: 'Operación cancelada',
        );

      default:
        return PaymentResult.error(
          errorCode: 'unknown_error',
          errorDetails: 'Error inesperado: ${error.message}',
        );
    }
  }

  /// Parsea un string a PaymentMethod
  PaymentMethod _parsePaymentMethod(String method) {
    switch (method.toLowerCase()) {
      case 'card':
        return PaymentMethod.card();
      case 'bank_transfer':
      case 'banktransfer':
        return PaymentMethod.bankTransfer();
      case 'mobile_transfer':
      case 'mobiletransfer':
        return PaymentMethod.mobileTransfer();
      default:
        return PaymentMethod.card();
    }
  }
}

/// Excepción específica de Tropipay
class TropipayException implements Exception {
  final String message;
  final dynamic details;

  TropipayException(this.message, [this.details]);

  @override
  String toString() {
    if (details != null) {
      return 'TropipayException: $message\nDetails: $details';
    }
    return 'TropipayException: $message';
  }
}

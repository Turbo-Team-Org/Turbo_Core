import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración para Tropipay
class TropipayConfig {
  /// ID del cliente de Tropipay
  static String get clientId {
    return dotenv.env['TROPIPAY_CLIENT_ID'] ?? '';
  }

  /// Secret del cliente de Tropipay
  static String get clientSecret {
    return dotenv.env['TROPIPAY_CLIENT_SECRET'] ?? '';
  }

  /// URL base de la API de Tropipay
  static String get baseUrl {
    return dotenv.env['TROPIPAY_BASE_URL'] ?? 'https://tropipay.com/api/v1';
  }

  /// Secret para verificar webhooks
  static String? get webhookSecret {
    return dotenv.env['TROPIPAY_WEBHOOK_SECRET'];
  }

  /// Indica si está en modo de prueba
  static bool get isTestMode {
    return dotenv.env['TROPIPAY_TEST_MODE']?.toLowerCase() == 'true';
  }

  /// URL de retorno por defecto
  static String get defaultReturnUrl {
    return dotenv.env['TROPIPAY_DEFAULT_RETURN_URL'] ?? '';
  }

  /// URL de cancelación por defecto
  static String get defaultCancelUrl {
    return dotenv.env['TROPIPAY_DEFAULT_CANCEL_URL'] ?? '';
  }

  /// URL de webhook por defecto
  static String? get defaultWebhookUrl {
    return dotenv.env['TROPIPAY_DEFAULT_WEBHOOK_URL'];
  }

  /// Tiempo de expiración por defecto en minutos
  static int get defaultExpirationMinutes {
    final minutes = int.tryParse(
      dotenv.env['TROPIPAY_DEFAULT_EXPIRATION_MINUTES'] ?? '30',
    );
    return minutes ?? 30;
  }

  /// Comisión de la plataforma por defecto (porcentaje)
  static double get defaultPlatformFeePercentage {
    final fee = double.tryParse(dotenv.env['PLATFORM_FEE_PERCENTAGE'] ?? '2.5');
    return fee ?? 2.5;
  }

  /// Verifica si la configuración es válida
  static bool get isValid {
    return clientId.isNotEmpty && clientSecret.isNotEmpty;
  }

  /// Obtiene la configuración como mapa
  static Map<String, dynamic> toMap() {
    return {
      'client_id': clientId.isNotEmpty ? '[HIDDEN]' : '[NOT_SET]',
      'client_secret': clientSecret.isNotEmpty ? '[HIDDEN]' : '[NOT_SET]',
      'base_url': baseUrl,
      'webhook_secret': webhookSecret != null ? '[HIDDEN]' : '[NOT_SET]',
      'test_mode': isTestMode,
      'default_return_url': defaultReturnUrl,
      'default_cancel_url': defaultCancelUrl,
      'default_webhook_url': defaultWebhookUrl,
      'default_expiration_minutes': defaultExpirationMinutes,
      'platform_fee_percentage': defaultPlatformFeePercentage,
      'is_valid': isValid,
    };
  }

  /// Imprime la configuración (sin datos sensibles)
  static void printConfig() {
    print('🔧 Tropipay Configuration:');
    final config = toMap();
    config.forEach((key, value) {
      print('  $key: $value');
    });
  }
}

/// Constantes para Tropipay
class TropipayConstants {
  /// URLs de la API
  static const String productionBaseUrl = 'https://tropipay.com/api/v1';
  static const String sandboxBaseUrl = 'https://sandbox.tropipay.com/api/v1';

  /// Endpoints de la API
  static const String authTokenEndpoint = '/auth/token';
  static const String paymentsEndpoint = '/payments';
  static const String webhookEndpoint = '/webhooks';

  /// Métodos de pago soportados
  static const List<String> supportedPaymentMethods = [
    'card',
    'bank_transfer',
    'mobile_transfer',
  ];

  /// Estados de pago de Tropipay
  static const Map<String, String> paymentStatusMapping = {
    'pending': 'pending',
    'processing': 'processing',
    'completed': 'completed',
    'failed': 'failed',
    'cancelled': 'cancelled',
    'refunded': 'refunded',
    'expired': 'expired',
  };

  /// Códigos de error comunes
  static const Map<String, String> errorCodeMapping = {
    'insufficient_funds': 'Fondos insuficientes',
    'card_declined': 'Tarjeta rechazada',
    'expired_card': 'Tarjeta expirada',
    'invalid_card': 'Tarjeta inválida',
    'network_error': 'Error de red',
    'timeout': 'Tiempo agotado',
    'invalid_amount': 'Monto inválido',
    'currency_not_supported': 'Moneda no soportada',
    'payment_method_not_supported': 'Método no soportado',
    'merchant_not_found': 'Comercio no encontrado',
    'duplicate_transaction': 'Transacción duplicada',
    'fraud_detected': 'Fraude detectado',
  };

  /// Límites de pago
  static const double minAmount = 1.0; // 1 CUP
  static const double maxAmount = 1000000.0; // 1M CUP

  /// Tiempos de expiración
  static const int minExpirationMinutes = 5;
  static const int maxExpirationMinutes = 1440; // 24 horas
  static const int defaultExpirationMinutes = 30;

  /// Headers requeridos
  static const Map<String, String> requiredHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// User Agent
  static const String userAgent = 'Turbo-App/1.0.0 (Flutter)';
}


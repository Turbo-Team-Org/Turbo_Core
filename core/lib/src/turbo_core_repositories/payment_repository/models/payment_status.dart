import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_status.freezed.dart';

/// Estados posibles de un pago
@freezed
sealed class PaymentStatus with _$PaymentStatus {
  /// Pago pendiente - Esperando confirmación
  const factory PaymentStatus.pending() = PaymentPending;

  /// Pago procesando - En proceso de validación
  const factory PaymentStatus.processing() = PaymentProcessing;

  /// Pago completado exitosamente
  const factory PaymentStatus.completed() = PaymentCompleted;

  /// Pago fallido - Error en el procesamiento
  const factory PaymentStatus.failed() = PaymentFailed;

  /// Pago cancelado - Cancelado por el usuario o sistema
  const factory PaymentStatus.cancelled() = PaymentCancelled;

  /// Pago reembolsado - Dinero devuelto al usuario
  const factory PaymentStatus.refunded() = PaymentRefunded;

  /// Pago expirado - Tiempo límite excedido
  const factory PaymentStatus.expired() = PaymentExpired;

  /// Estado desconocido - Para casos edge
  const factory PaymentStatus.unknown() = PaymentUnknown;
}

/// Extensión para obtener valores string del estado
extension PaymentStatusExtension on PaymentStatus {
  /// Obtiene el valor string del estado para APIs
  String get value {
    return when(
      pending: () => 'pending',
      processing: () => 'processing',
      completed: () => 'completed',
      failed: () => 'failed',
      cancelled: () => 'cancelled',
      refunded: () => 'refunded',
      expired: () => 'expired',
      unknown: () => 'unknown',
    );
  }

  /// Obtiene el estado desde un string
  static PaymentStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return const PaymentStatus.pending();
      case 'processing':
        return const PaymentStatus.processing();
      case 'completed':
        return const PaymentStatus.completed();
      case 'failed':
        return const PaymentStatus.failed();
      case 'cancelled':
        return const PaymentStatus.cancelled();
      case 'refunded':
        return const PaymentStatus.refunded();
      case 'expired':
        return const PaymentStatus.expired();
      default:
        return const PaymentStatus.unknown();
    }
  }

  /// Verifica si el pago está en un estado final (no puede cambiar)
  bool get isFinalState {
    return when(
      pending: () => false,
      processing: () => false,
      completed: () => true,
      failed: () => true,
      cancelled: () => true,
      refunded: () => true,
      expired: () => true,
      unknown: () => false,
    );
  }

  /// Verifica si el pago fue exitoso
  bool get isSuccessful {
    return when(
      pending: () => false,
      processing: () => false,
      completed: () => true,
      failed: () => false,
      cancelled: () => false,
      refunded: () => false,
      expired: () => false,
      unknown: () => false,
    );
  }

  /// Obtiene el color asociado al estado para UI
  String get colorHex {
    return when(
      pending: () => '#FFA726', // Orange
      processing: () => '#2196F3', // Blue
      completed: () => '#4CAF50', // Green
      failed: () => '#F44336', // Red
      cancelled: () => '#9E9E9E', // Grey
      refunded: () => '#FF9800', // Orange
      expired: () => '#795548', // Brown
      unknown: () => '#607D8B', // Blue Grey
    );
  }
}


# 💳 Payment Repository - Integración con Tropipay

Este repositorio implementa un sistema completo de pagos para la plataforma Turbo, integrado con **Tropipay**, la pasarela de pagos más popular en Cuba.

## 🚀 Características

- ✅ **Integración completa con Tropipay API**
- ✅ **Soporte para múltiples métodos de pago** (tarjeta, transferencia bancaria, transferencia móvil)
- ✅ **Manejo de estados de pago** (pendiente, procesando, completado, fallido, cancelado, reembolsado)
- ✅ **Sistema de webhooks** para notificaciones en tiempo real
- ✅ **Gestión de reembolsos** y cancelaciones
- ✅ **Historial de transacciones** completo
- ✅ **Estadísticas de pagos** por usuario y lugar
- ✅ **Configuración flexible** para desarrollo y producción
- ✅ **Manejo robusto de errores** con mensajes amigables
- ✅ **Validación de datos** antes del procesamiento

## 📋 Modelos de Datos

### Payment
Modelo principal que representa un pago:
```dart
final payment = Payment(
  id: 'payment_123',
  userId: 'user_456',
  placeId: 'place_789',
  amount: 1500.0,
  currency: 'CUP',
  paymentMethod: PaymentMethod.card(),
  status: PaymentStatus.pending(),
  description: 'Pago de reserva',
  // ... más campos
);
```

### PaymentStatus
Estados posibles del pago:
- `pending` - Pendiente
- `processing` - Procesando
- `completed` - Completado
- `failed` - Fallido
- `cancelled` - Cancelado
- `refunded` - Reembolsado
- `expired` - Expirado

### PaymentMethod
Métodos de pago soportados:
- `card` - Tarjeta de crédito/débito
- `bankTransfer` - Transferencia bancaria
- `mobileTransfer` - Transferencia móvil

## 🔧 Configuración

### 1. Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto con:

```env
# Credenciales de Tropipay
TROPIPAY_CLIENT_ID=tu_client_id
TROPIPAY_CLIENT_SECRET=tu_client_secret

# URL de la API
TROPIPAY_BASE_URL=https://tropipay.com/api/v1

# Modo de prueba
TROPIPAY_TEST_MODE=true

# URLs de retorno
TROPIPAY_DEFAULT_RETURN_URL=https://tu-app.com/payment/success
TROPIPAY_DEFAULT_CANCEL_URL=https://tu-app.com/payment/cancel
```

### 2. Inicialización

```dart
import 'package:core/core.dart';

// Configurar servicios
final dio = Dio();
final tropipayService = TropipayService(
  dio: dio,
  clientId: TropipayConfig.clientId,
  clientSecret: TropipayConfig.clientSecret,
  baseUrl: TropipayConfig.baseUrl,
);

final paymentService = PaymentService(
  tropipayService: tropipayService,
);

final paymentRepository = PaymentRepository(
  paymentService: paymentService,
);
```

## 💡 Uso

### Procesar un Pago

```dart
// Crear request de pago
final paymentRequest = TropipayPaymentRequest.fromPayment(
  amount: 1500.0,
  description: 'Pago de reserva',
  userId: 'user_123',
  placeId: 'place_456',
  returnUrl: 'https://app.com/success',
  cancelUrl: 'https://app.com/cancel',
);

// Procesar pago
final result = await paymentRepository.processPayment(paymentRequest);

if (result.success) {
  print('Pago creado: ${result.transactionId}');
  
  // Redirigir al usuario si es necesario
  if (result.requiresRedirect) {
    // Abrir URL de pago
    launchUrl(Uri.parse(result.preferredRedirectUrl!));
  }
} else {
  print('Error: ${result.userFriendlyMessage}');
}
```

### Verificar Estado de Pago

```dart
final result = await paymentRepository.getPaymentStatus('transaction_123');

if (result.success) {
  final payment = result.payment!;
  print('Estado: ${payment.status.value}');
  print('Monto: ${payment.amount} ${payment.currency}');
  
  if (payment.status.isSuccessful) {
    print('✅ Pago completado');
  }
}
```

### Obtener Historial de Pagos

```dart
// Historial del usuario
final userHistory = await paymentRepository.getPaymentHistory(
  'user_123',
  limit: 10,
);

// Historial del lugar
final placeHistory = await paymentRepository.getPlacePaymentHistory(
  'place_456',
  limit: 20,
);
```

### Procesar Reembolso

```dart
final result = await paymentRepository.processRefund(
  'transaction_123',
  amount: 750.0, // Reembolsar la mitad
  reason: 'Cancelación de reserva',
);

if (result.success) {
  print('✅ Reembolso procesado');
}
```

### Obtener Estadísticas

```dart
// Estadísticas del lugar
final placeStats = await paymentRepository.getPlacePaymentStats('place_456');
print('Total transacciones: ${placeStats['total_transactions']}');
print('Monto total: ${placeStats['total_amount']} CUP');
print('Tasa de éxito: ${placeStats['success_rate']}%');

// Estadísticas del usuario
final userStats = await paymentRepository.getUserPaymentStats('user_123');
print('Pagos del usuario: ${userStats['total_transactions']}');
```

## 🔗 Webhooks

### Configurar Webhook en Tropipay

1. Ve al panel de administración de Tropipay
2. Configura la URL del webhook: `https://tu-app.com/api/webhooks/tropipay`
3. Selecciona los eventos: `payment.completed`, `payment.failed`, `payment.cancelled`

### Procesar Webhook

```dart
// En tu endpoint de webhook
Future<void> handleWebhook(Map<String, dynamic> payload, String signature) async {
  try {
    final webhook = await tropipayService.processWebhook(payload, signature);
    
    // Procesar según el tipo de evento
    switch (webhook.eventType) {
      case TropipayWebhookEventType.paymentCompleted:
        await handlePaymentCompleted(webhook);
        break;
      case TropipayWebhookEventType.paymentFailed:
        await handlePaymentFailed(webhook);
        break;
      case TropipayWebhookEventType.paymentCancelled:
        await handlePaymentCancelled(webhook);
        break;
      default:
        print('Evento no manejado: ${webhook.eventType.displayName}');
    }
  } catch (e) {
    print('Error procesando webhook: $e');
  }
}
```

## 🛡️ Seguridad

### Validación de Webhooks

El sistema valida automáticamente las firmas de los webhooks para asegurar que provienen de Tropipay:

```dart
// La validación se hace automáticamente en processWebhook()
if (!webhook.isValid(expectedSignature, secretKey)) {
  throw Exception('Webhook inválido');
}
```

### Datos Sensibles

- Las credenciales se leen desde variables de entorno
- Los datos de tarjeta se manejan de forma segura
- Solo se almacenan los últimos 4 dígitos de la tarjeta

## 📊 Métricas y Monitoreo

### Logging

Todos los eventos importantes se registran:

```dart
// El resultado incluye información para logging
final logData = result.toLogFormat();
logger.info('Payment processed', extra: logData);
```

### Métricas Disponibles

- Total de transacciones
- Tasa de éxito
- Montos totales y netos
- Comisiones aplicadas
- Tiempo promedio de procesamiento

## 🚨 Manejo de Errores

### Códigos de Error Comunes

- `insufficient_funds` - Fondos insuficientes
- `card_declined` - Tarjeta rechazada
- `expired_card` - Tarjeta expirada
- `network_error` - Error de conexión
- `timeout` - Tiempo agotado
- `validation_error` - Error de validación

### Mensajes Amigables

```dart
final result = await paymentRepository.processPayment(request);

if (!result.success) {
  // Mostrar mensaje amigable al usuario
  showErrorDialog(result.userFriendlyMessage);
  
  // Log para debugging
  logger.error('Payment failed', extra: result.toLogFormat());
}
```

## 🔄 Flujo de Pago Típico

1. **Usuario inicia pago** → Se crea `TropipayPaymentRequest`
2. **Validación** → Se valida la request
3. **Crear pago** → Se envía a Tropipay API
4. **Redirección** → Usuario es redirigido a Tropipay (si es necesario)
5. **Procesamiento** → Tropipay procesa el pago
6. **Webhook** → Tropipay notifica el resultado
7. **Actualización** → Se actualiza el estado en la base de datos

## 📱 Integración con Flutter

### Use Cases

```dart
class ProcessPaymentUseCase {
  final PaymentRepository _paymentRepository;
  
  ProcessPaymentUseCase(this._paymentRepository);
  
  Future<PaymentResult> call(TropipayPaymentRequest request) async {
    return await _paymentRepository.processPayment(request);
  }
}
```

### State Management (BLoC/Cubit)

```dart
class PaymentCubit extends Cubit<PaymentState> {
  final ProcessPaymentUseCase _processPaymentUseCase;
  
  PaymentCubit(this._processPaymentUseCase) : super(PaymentInitial());
  
  Future<void> processPayment(TropipayPaymentRequest request) async {
    emit(PaymentLoading());
    
    try {
      final result = await _processPaymentUseCase(request);
      
      if (result.success) {
        emit(PaymentSuccess(result));
      } else {
        emit(PaymentError(result.userFriendlyMessage));
      }
    } catch (e) {
      emit(PaymentError('Error inesperado: $e'));
    }
  }
}
```

## 🧪 Testing

### Tests Unitarios

```dart
group('PaymentRepository', () {
  late PaymentRepository paymentRepository;
  late MockTropipayService mockTropipayService;
  
  setUp(() {
    mockTropipayService = MockTropipayService();
    paymentRepository = PaymentRepository(
      paymentService: PaymentService(
        tropipayService: mockTropipayService,
      ),
    );
  });
  
  test('should process payment successfully', () async {
    // Arrange
    final request = TropipayPaymentRequest.fromPayment(
      amount: 100.0,
      description: 'Test payment',
      userId: 'user_123',
      placeId: 'place_456',
    );
    
    when(() => mockTropipayService.createPayment(any()))
        .thenAnswer((_) async => PaymentResult.success(...));
    
    // Act
    final result = await paymentRepository.processPayment(request);
    
    // Assert
    expect(result.success, isTrue);
    verify(() => mockTropipayService.createPayment(request)).called(1);
  });
});
```

## 📚 Recursos Adicionales

- [Documentación de Tropipay API](https://tpp.stoplight.io/docs/tropipay-api-doc)
- [Ejemplos de uso](examples/payment_usage_example.dart)
- [Configuración de ejemplo](env.payment.example)
- [Webhooks de Tropipay](https://tpp.stoplight.io/docs/tropipay-api-doc/webhooks)

## 🤝 Contribución

Para contribuir al PaymentRepository:

1. Sigue las convenciones de código existentes
2. Agrega tests para nuevas funcionalidades
3. Actualiza la documentación
4. Verifica que todos los tests pasen

## 📄 Licencia

Este código es parte del proyecto Turbo y está sujeto a la licencia del proyecto.


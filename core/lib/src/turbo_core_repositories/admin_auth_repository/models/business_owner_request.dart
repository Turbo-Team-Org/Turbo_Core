import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_owner_request.freezed.dart';
part 'business_owner_request.g.dart';

/// 📝 Modelo de Solicitud de Registro para Business Owner
///
/// Representa una solicitud de registro enviada por un potencial
/// propietario de negocio que quiere unirse a Turbo Platform
@freezed
sealed class BusinessOwnerRequest with _$BusinessOwnerRequest {
  const BusinessOwnerRequest._();

  const factory BusinessOwnerRequest({
    required String id,
    required String userId,
    required String email,
    required String displayName,
    required String businessName,
    required String businessDescription,
    required String businessAddress,
    String? phoneNumber,
    String? website,
    @Default(BusinessOwnerRequestStatus.pending)
    BusinessOwnerRequestStatus status,
    required DateTime createdAt,
    DateTime? lastLogin,
    DateTime? reviewedAt,
    String? reviewedBy,
    String? rejectionReason,
    String? approvalNotes,
    @Default({}) Map<String, dynamic> businessMetadata,
    @Default({}) Map<String, dynamic> contactInfo,
  }) = _BusinessOwnerRequest;

  factory BusinessOwnerRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessOwnerRequestFromJson(json);

  /// 🕐 Verifica si la solicitud está pendiente
  bool get isPending => status == BusinessOwnerRequestStatus.pending;

  /// ✅ Verifica si la solicitud fue aprobada
  bool get isApproved => status == BusinessOwnerRequestStatus.approved;

  /// ❌ Verifica si la solicitud fue rechazada
  bool get isRejected => status == BusinessOwnerRequestStatus.rejected;

  /// ⏱️ Calcula días desde la solicitud
  int get daysSinceRequest => DateTime.now().difference(createdAt).inDays;

  /// 🎯 Verifica si la solicitud es urgente (más de 7 días)
  bool get isUrgent => daysSinceRequest > 7;

  /// 📈 Convierte a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'businessName': businessName,
      'businessDescription': businessDescription,
      'businessAddress': businessAddress,
      'phoneNumber': phoneNumber,
      'website': website,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'reviewedAt': reviewedAt != null ? Timestamp.fromDate(reviewedAt!) : null,
      'reviewedBy': reviewedBy,
      'rejectionReason': rejectionReason,
      'approvalNotes': approvalNotes,
      'businessMetadata': businessMetadata,
      'contactInfo': contactInfo,
    };
  }

  /// 📥 Crea desde documento de Firestore
  factory BusinessOwnerRequest.fromFirestore(Map<String, dynamic> data) {
    return BusinessOwnerRequest(
      id: data['id'] as String,
      userId: data['userId'] as String,
      email: data['email'] as String,
      displayName: data['displayName'] as String,
      businessName: data['businessName'] as String,
      businessDescription: data['businessDescription'] as String,
      businessAddress: data['businessAddress'] as String,
      phoneNumber: data['phoneNumber'] as String?,
      website: data['website'] as String?,
      status: BusinessOwnerRequestStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => BusinessOwnerRequestStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      reviewedAt:
          data['reviewedAt'] != null
              ? (data['reviewedAt'] as Timestamp).toDate()
              : null,
      reviewedBy: data['reviewedBy'] as String?,
      rejectionReason: data['rejectionReason'] as String?,
      approvalNotes: data['approvalNotes'] as String?,
      businessMetadata: Map<String, dynamic>.from(
        data['businessMetadata'] as Map<dynamic, dynamic>? ?? {},
      ),
      contactInfo: Map<String, dynamic>.from(
        data['contactInfo'] as Map<dynamic, dynamic>? ?? {},
      ),
    );
  }
}

/// 📊 Estados de la Solicitud de Business Owner
enum BusinessOwnerRequestStatus {
  /// ⏳ Pendiente de revisión
  pending,

  /// ✅ Aprobada y usuario creado
  approved,

  /// ❌ Rechazada
  rejected,

  /// 🔄 En revisión (adicional)
  reviewing,

  /// ⏸️ Necesita más información
  needsMoreInfo,
}

/// 🎯 Extensiones útiles para BusinessOwnerRequestStatus
extension BusinessOwnerRequestStatusExtensions on BusinessOwnerRequestStatus {
  /// 🏷️ Nombre legible del estado
  String get displayName {
    switch (this) {
      case BusinessOwnerRequestStatus.pending:
        return 'Pendiente';
      case BusinessOwnerRequestStatus.approved:
        return 'Aprobada';
      case BusinessOwnerRequestStatus.rejected:
        return 'Rechazada';
      case BusinessOwnerRequestStatus.reviewing:
        return 'En Revisión';
      case BusinessOwnerRequestStatus.needsMoreInfo:
        return 'Necesita Más Información';
    }
  }

  /// 🎨 Color representativo del estado
  String get colorHex {
    switch (this) {
      case BusinessOwnerRequestStatus.pending:
        return '#FF9800'; // Naranja
      case BusinessOwnerRequestStatus.approved:
        return '#4CAF50'; // Verde
      case BusinessOwnerRequestStatus.rejected:
        return '#F44336'; // Rojo
      case BusinessOwnerRequestStatus.reviewing:
        return '#2196F3'; // Azul
      case BusinessOwnerRequestStatus.needsMoreInfo:
        return '#9C27B0'; // Púrpura
    }
  }

  /// 🔍 Emoji representativo
  String get emoji {
    switch (this) {
      case BusinessOwnerRequestStatus.pending:
        return '⏳';
      case BusinessOwnerRequestStatus.approved:
        return '✅';
      case BusinessOwnerRequestStatus.rejected:
        return '❌';
      case BusinessOwnerRequestStatus.reviewing:
        return '🔄';
      case BusinessOwnerRequestStatus.needsMoreInfo:
        return '📝';
    }
  }

  /// 🚦 Verifica si es un estado final
  bool get isFinal {
    return [
      BusinessOwnerRequestStatus.approved,
      BusinessOwnerRequestStatus.rejected,
    ].contains(this);
  }
}

/// 📊 Estadísticas de Solicitudes de Business Owners
class BusinessOwnerRequestStats {
  const BusinessOwnerRequestStats({
    required this.totalRequests,
    required this.pendingRequests,
    required this.approvedRequests,
    required this.rejectedRequests,
    required this.reviewingRequests,
    required this.needsMoreInfoRequests,
    required this.urgentRequests,
    required this.requestsThisWeek,
    required this.requestsThisMonth,
    required this.averageResponseTimeDays,
  });

  final int totalRequests;
  final int pendingRequests;
  final int approvedRequests;
  final int rejectedRequests;
  final int reviewingRequests;
  final int needsMoreInfoRequests;
  final int urgentRequests;
  final int requestsThisWeek;
  final int requestsThisMonth;
  final double averageResponseTimeDays;

  /// 📈 Calcula porcentaje de aprobación
  double get approvalRate {
    final processedRequests = approvedRequests + rejectedRequests;
    if (processedRequests == 0) return 0;
    return (approvedRequests / processedRequests) * 100;
  }

  /// ⚡ Verifica si hay solicitudes urgentes
  bool get hasUrgentRequests => urgentRequests > 0;

  factory BusinessOwnerRequestStats.fromRequests(
    List<BusinessOwnerRequest> requests,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month, 1);

    var requestsThisWeek = 0;
    var requestsThisMonth = 0;
    var urgentRequests = 0;
    var totalResponseTime = 0;
    var processedRequests = 0;

    for (final request in requests) {
      // Contar por semana y mes
      if (request.createdAt.isAfter(startOfWeek)) requestsThisWeek++;
      if (request.createdAt.isAfter(startOfMonth)) requestsThisMonth++;

      // Contar urgentes
      if (request.isUrgent && request.isPending) urgentRequests++;

      // Calcular tiempo de respuesta promedio
      if (request.reviewedAt != null) {
        totalResponseTime +=
            request.reviewedAt!.difference(request.createdAt).inDays;
        processedRequests++;
      }
    }

    return BusinessOwnerRequestStats(
      totalRequests: requests.length,
      pendingRequests:
          requests
              .where((r) => r.status == BusinessOwnerRequestStatus.pending)
              .length,
      approvedRequests:
          requests
              .where((r) => r.status == BusinessOwnerRequestStatus.approved)
              .length,
      rejectedRequests:
          requests
              .where((r) => r.status == BusinessOwnerRequestStatus.rejected)
              .length,
      reviewingRequests:
          requests
              .where((r) => r.status == BusinessOwnerRequestStatus.reviewing)
              .length,
      needsMoreInfoRequests:
          requests
              .where(
                (r) => r.status == BusinessOwnerRequestStatus.needsMoreInfo,
              )
              .length,
      urgentRequests: urgentRequests,
      requestsThisWeek: requestsThisWeek,
      requestsThisMonth: requestsThisMonth,
      averageResponseTimeDays:
          processedRequests > 0 ? totalResponseTime / processedRequests : 0,
    );
  }
}

/// Estados posibles de una reserva
enum ReservationStatus {
  /// Reserva pendiente de confirmación
  pending('pending', 'Pendiente'),

  /// Reserva confirmada por el negocio
  confirmed('confirmed', 'Confirmada'),

  /// Reserva cancelada por el usuario
  cancelled('cancelled', 'Cancelada'),

  /// Reserva rechazada por el negocio
  rejected('rejected', 'Rechazada'),

  /// Cliente ya se presentó
  checkedIn('checked_in', 'Cliente presente'),

  /// Cliente no se presentó (no-show)
  noShow('no_show', 'No se presentó'),

  /// Reserva completada exitosamente
  completed('completed', 'Completada'),

  /// Reserva en proceso de modificación
  modifying('modifying', 'Modificando');

  const ReservationStatus(this.value, this.displayName);

  final String value;
  final String displayName;

  /// Estados que permiten modificación
  static const List<ReservationStatus> modifiableStates = [pending, confirmed];

  /// Estados que cuentan como activas
  static const List<ReservationStatus> activeStates = [
    pending,
    confirmed,
    modifying,
  ];

  /// Estados finales (no pueden cambiar)
  static const List<ReservationStatus> finalStates = [
    cancelled,
    rejected,
    noShow,
    completed,
  ];

  /// Verificar si la reserva se puede modificar
  bool get canBeModified => modifiableStates.contains(this);

  /// Verificar si la reserva está activa
  bool get isActive => activeStates.contains(this);

  /// Verificar si la reserva está en estado final
  bool get isFinal => finalStates.contains(this);

  /// Crear desde string
  static ReservationStatus fromString(String value) {
    return ReservationStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => ReservationStatus.pending,
    );
  }

  /// Color asociado al estado (para UI)
  String get colorCode {
    switch (this) {
      case pending:
        return '#FFA726'; // Orange
      case confirmed:
        return '#66BB6A'; // Green
      case cancelled:
      case rejected:
        return '#EF5350'; // Red
      case checkedIn:
        return '#42A5F5'; // Blue
      case noShow:
        return '#AB47BC'; // Purple
      case completed:
        return '#26A69A'; // Teal
      case modifying:
        return '#FFEE58'; // Yellow
    }
  }
}

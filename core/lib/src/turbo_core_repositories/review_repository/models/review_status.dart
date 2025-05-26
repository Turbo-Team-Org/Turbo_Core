/// Enum representing the different status states of a review.
///
/// This enum is used to manage the approval workflow for reviews,
/// allowing places to moderate comments before they are publicly visible.
enum ReviewStatus {
  /// Review is pending approval from the place owner/admin
  pending('pending'),

  /// Review has been approved and is publicly visible
  approved('approved'),

  /// Review has been rejected and is not publicly visible
  rejected('rejected'),

  /// Review is under review/investigation (e.g., reported content)
  underReview('under_review'),

  /// Review has been flagged by users or automated systems
  flagged('flagged');

  const ReviewStatus(this.value);

  /// The string value used for serialization/deserialization
  final String value;

  /// Creates a ReviewStatus from a string value
  static ReviewStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return ReviewStatus.pending;
      case 'approved':
        return ReviewStatus.approved;
      case 'rejected':
        return ReviewStatus.rejected;
      case 'under_review':
        return ReviewStatus.underReview;
      case 'flagged':
        return ReviewStatus.flagged;
      default:
        return ReviewStatus.pending; // Default to pending for unknown values
    }
  }

  /// Returns a human-readable description in Spanish
  String get description {
    switch (this) {
      case ReviewStatus.pending:
        return 'Pendiente de aprobación';
      case ReviewStatus.approved:
        return 'Aprobada';
      case ReviewStatus.rejected:
        return 'Rechazada';
      case ReviewStatus.underReview:
        return 'En revisión';
      case ReviewStatus.flagged:
        return 'Reportada';
    }
  }

  /// Returns the color associated with the status (for UI purposes)
  String get colorHex {
    switch (this) {
      case ReviewStatus.pending:
        return '#FFA500'; // Orange
      case ReviewStatus.approved:
        return '#4CAF50'; // Green
      case ReviewStatus.rejected:
        return '#F44336'; // Red
      case ReviewStatus.underReview:
        return '#2196F3'; // Blue
      case ReviewStatus.flagged:
        return '#FF5722'; // Deep Orange
    }
  }

  /// Returns true if the review should be publicly visible
  bool get isPubliclyVisible {
    return this == ReviewStatus.approved;
  }

  /// Returns true if the review requires admin attention
  bool get requiresAttention {
    return this == ReviewStatus.pending ||
        this == ReviewStatus.underReview ||
        this == ReviewStatus.flagged;
  }
}

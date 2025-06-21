// ignore_for_file: public_member_api_docs

/// ⚠️ Excepción personalizada para errores de autenticación administrativa
class AdminAuthException implements Exception {
  const AdminAuthException(this.message);

  final String message;

  @override
  String toString() => 'AdminAuthException: $message';
}

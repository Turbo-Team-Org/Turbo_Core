// ignore_for_file: public_member_api_docs

/// 🚨 Tipos de fallos en autenticación administrativa
abstract class AdminAuthFailure {
  const AdminAuthFailure();

  // Errores de autenticación
  const factory AdminAuthFailure.invalidEmail() = InvalidEmailFailure;
  const factory AdminAuthFailure.weakPassword() = WeakPasswordFailure;
  const factory AdminAuthFailure.emailAlreadyInUse() = EmailAlreadyInUseFailure;
  const factory AdminAuthFailure.userNotFound() = UserNotFoundFailure;
  const factory AdminAuthFailure.wrongPassword() = WrongPasswordFailure;
  const factory AdminAuthFailure.userDisabled() = UserDisabledFailure;
  const factory AdminAuthFailure.tooManyRequests() = TooManyRequestsFailure;

  // Errores de autorización
  const factory AdminAuthFailure.insufficientPermissions() =
      InsufficientPermissionsFailure;
  const factory AdminAuthFailure.accountInactive() = AccountInactiveFailure;
  const factory AdminAuthFailure.notAuthorizedForAdminPanel() =
      NotAuthorizedForAdminPanelFailure;

  // Errores de red y sistema
  const factory AdminAuthFailure.networkError() = NetworkErrorFailure;
  const factory AdminAuthFailure.serverError() = ServerErrorFailure;
  const factory AdminAuthFailure.custom(String message) = CustomFailure;
}

// Implementaciones específicas de fallos
class InvalidEmailFailure extends AdminAuthFailure {
  const InvalidEmailFailure();
  @override
  String toString() => 'Email inválido';
}

class WeakPasswordFailure extends AdminAuthFailure {
  const WeakPasswordFailure();
  @override
  String toString() => 'La contraseña es muy débil';
}

class EmailAlreadyInUseFailure extends AdminAuthFailure {
  const EmailAlreadyInUseFailure();
  @override
  String toString() => 'El email ya está en uso';
}

class UserNotFoundFailure extends AdminAuthFailure {
  const UserNotFoundFailure();
  @override
  String toString() => 'Usuario no encontrado';
}

class WrongPasswordFailure extends AdminAuthFailure {
  const WrongPasswordFailure();
  @override
  String toString() => 'Contraseña incorrecta';
}

class UserDisabledFailure extends AdminAuthFailure {
  const UserDisabledFailure();
  @override
  String toString() => 'Cuenta deshabilitada';
}

class TooManyRequestsFailure extends AdminAuthFailure {
  const TooManyRequestsFailure();
  @override
  String toString() => 'Demasiados intentos, intenta más tarde';
}

class InsufficientPermissionsFailure extends AdminAuthFailure {
  const InsufficientPermissionsFailure();
  @override
  String toString() => 'Permisos insuficientes';
}

class AccountInactiveFailure extends AdminAuthFailure {
  const AccountInactiveFailure();
  @override
  String toString() => 'Cuenta inactiva';
}

class NotAuthorizedForAdminPanelFailure extends AdminAuthFailure {
  const NotAuthorizedForAdminPanelFailure();
  @override
  String toString() => 'No autorizado para admin panel';
}

class NetworkErrorFailure extends AdminAuthFailure {
  const NetworkErrorFailure();
  @override
  String toString() => 'Error de conexión';
}

class ServerErrorFailure extends AdminAuthFailure {
  const ServerErrorFailure();
  @override
  String toString() => 'Error del servidor';
}

class CustomFailure extends AdminAuthFailure {
  const CustomFailure(this.message);
  final String message;

  @override
  String toString() => message;
}

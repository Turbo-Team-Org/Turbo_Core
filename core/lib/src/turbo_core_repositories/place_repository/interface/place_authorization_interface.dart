/// Interfaz para verificar permisos de gestión de lugares
abstract class PlaceAuthorizationInterface {
  /// Verifica si el usuario actual puede gestionar un lugar específico
  bool canManagePlace(String placeId);
}

/// Implementación por defecto que siempre permite la gestión (para testing)
class DefaultPlaceAuthorization implements PlaceAuthorizationInterface {
  const DefaultPlaceAuthorization();

  @override
  bool canManagePlace(String placeId) => true;
}

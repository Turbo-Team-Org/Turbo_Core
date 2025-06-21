// 🏢 Ejemplo de Auto-Registro de Business Owner - Nuevo Flujo
//
// Demuestra el flujo real donde:
// 1. Usuario se registra como usuario regular
// 2. Usuario hace login
// 3. Usuario va al panel y toca "Crear mi lugar"
// 4. Usuario llena información y envía solicitud
// 5. Super admin aprueba/rechaza
// 6. Usuario se convierte en business owner

import 'package:core/src/turbo_core_repositories/admin_auth_repository/admin_auth_repository_imports.dart';
import 'package:get_it/get_it.dart';

void main() async {
  print('🚀 Ejemplo de Business Owner Registration - Nuevo Flujo\n');

  // Simular GetIt setup
  final sl = GetIt.instance;
  final adminAuthRepo = sl<AdminAuthRepository>();

  await demonstrateCompleteFlow(adminAuthRepo);
}

/// 🎯 Flujo completo: Usuario a Business Owner
Future<void> demonstrateCompleteFlow(AdminAuthRepository adminAuthRepo) async {
  print('🎯 === FLUJO COMPLETO: USUARIO A BUSINESS OWNER ===\n');

  // PASO 1: Usuario ya está registrado y logueado
  print('✅ PASO 1: Usuario ya registrado y logueado');
  print('   👤 Usuario: Carlos Rodríguez');
  print('   📧 Email: carlos@email.com');
  print('   🔑 UID: user_123456');
  print('   📱 Usando la app/panel como usuario regular\n');

  // PASO 2: Usuario ve botón "Crear mi lugar/negocio"
  print('🏢 PASO 2: Usuario ve opción "Crear mi lugar"');
  print('   📱 En el panel/app, usuario navega a sección de negocios');
  print('   🆕 Usuario toca botón "Crear mi lugar/negocio"');
  print('   📝 Se abre formulario de solicitud\n');

  // PASO 3: Usuario llena formulario de business owner
  await demonstrateUserSubmitsRequest(adminAuthRepo);

  // PASO 4: Super admin revisa y aprueba
  await demonstrateSuperAdminApproval(adminAuthRepo);

  // PASO 5: Usuario ahora es business owner
  await demonstrateUserNowBusinessOwner(adminAuthRepo);
}

/// 📝 Usuario llena y envía solicitud
Future<void> demonstrateUserSubmitsRequest(
  AdminAuthRepository adminAuthRepo,
) async {
  print('📝 PASO 3: Usuario llena solicitud de business owner');

  final result = await adminAuthRepo.submitBusinessOwnerRequest(
    userId: 'user_123456', // UID del usuario ya registrado
    displayName: 'Carlos Rodríguez',
    businessName: 'Restaurante La Abuela',
    businessDescription:
        'Restaurante familiar especializado en comida tradicional mexicana, recetas de mi abuela',
    businessAddress: 'Calle Reforma 123, Col. Centro, CDMX',
    phoneNumber: '+52 55 1234 5678',
    website: 'https://restaurantelaabuela.mx',
    businessMetadata: {
      'category': 'restaurant',
      'cuisine': 'mexican',
      'priceRange': 'medium',
      'capacity': 80,
      'hasDelivery': true,
      'hasParking': true,
      'acceptsCards': true,
    },
    contactInfo: {
      'managerName': 'Carlos Rodríguez',
      'emergencyContact': '+52 55 8765 4321',
      'socialMedia': {
        'facebook': '@restaurantelaabuela',
        'instagram': '@laabuela_oficial',
        'tiktok': '@laabuela_mx',
      },
      'businessHours': {
        'monday': '9:00-22:00',
        'tuesday': '9:00-22:00',
        'wednesday': '9:00-22:00',
        'thursday': '9:00-22:00',
        'friday': '9:00-23:00',
        'saturday': '9:00-23:00',
        'sunday': '9:00-21:00',
      },
    },
  );

  result.fold(
    (failure) {
      print('   ❌ Error enviando solicitud: $failure');
    },
    (request) {
      print('   ✅ Solicitud enviada exitosamente!');
      print('   📧 ID: ${request.id}');
      print('   👤 Usuario: ${request.userId}');
      print('   🏢 Negocio: ${request.businessName}');
      print('   📊 Estado: ${request.status.displayName}');
      print('   🔔 Super admins notificados automáticamente');
      print('');
      print('   📱 Mensaje al usuario:');
      print(
        '   "Tu solicitud para crear ${request.businessName} ha sido enviada."',
      );
      print('   "Te notificaremos cuando sea revisada por nuestro equipo."');
      print('   "Tiempo estimado de respuesta: 2-3 días hábiles."\n');
    },
  );
}

/// 👑 Super admin revisa y aprueba
Future<void> demonstrateSuperAdminApproval(
  AdminAuthRepository adminAuthRepo,
) async {
  print('👑 PASO 4: Super Admin revisa solicitud');

  // Ver solicitudes pendientes
  final requestsResult = await adminAuthRepo.getAllBusinessOwnerRequests(
    requestedByUid: 'super_admin_001',
    filterByStatus: BusinessOwnerRequestStatus.pending,
  );

  await requestsResult.fold(
    (failure) {
      print('   ❌ Error: $failure');
      return Future.value();
    },
    (requests) async {
      if (requests.isNotEmpty) {
        final request = requests.first;
        print('   📋 Revisando solicitud:');
        print('   👤 Usuario: ${request.displayName} (${request.userId})');
        print('   🏢 Negocio: ${request.businessName}');
        print('   📍 Ubicación: ${request.businessAddress}');
        print('   📅 Enviada: ${request.createdAt}');
        print('   📝 Descripción: ${request.businessDescription}');

        // Super admin puede marcar como "en revisión"
        await adminAuthRepo.updateRequestStatus(
          requestId: request.id,
          updatedByUid: 'super_admin_001',
          newStatus: BusinessOwnerRequestStatus.reviewing,
          notes: 'Revisando documentación y verificando información',
        );

        print('   🔄 Marcada como "En Revisión"');

        // Super admin aprueba
        final approvalResult = await adminAuthRepo.approveBusinessOwnerRequest(
          requestId: request.id,
          approvedByUid: 'super_admin_001',
          initialPlaceIds: [], // Inicialmente sin lugares específicos
          approvalNotes:
              'Solicitud aprobada. Documentación correcta. Usuario verificado.',
        );

        approvalResult.fold(
          (failure) => print('   ❌ Error aprobando: $failure'),
          (adminUser) {
            print('   ✅ ¡Solicitud APROBADA!');
            print('   👤 Usuario convertido a Business Owner');
            print('   🔑 UID Admin: ${adminUser.uid}');
            print('   📧 Email: ${adminUser.email}');
            print('   🏢 Rol: ${adminUser.role.displayName}');
            print(
              '   🎯 Permisos: ${adminUser.allPermissions.length} permisos',
            );
            print('   📧 Usuario notificado automáticamente\n');
          },
        );
      }
    },
  );
}

/// 🎉 Usuario ahora es business owner
Future<void> demonstrateUserNowBusinessOwner(
  AdminAuthRepository adminAuthRepo,
) async {
  print('🎉 PASO 5: Usuario ahora es Business Owner');
  print('   📱 Usuario recibe notificación:');
  print(
    '   "¡Felicidades! Tu solicitud para Restaurante La Abuela ha sido aprobada."',
  );
  print(
    '   "Ahora puedes gestionar tu negocio desde el panel administrativo."',
  );
  print('');
  print('   🔄 Al hacer login, usuario ve:');
  print('   ✅ Acceso a Panel de Business Owner');
  print('   🏢 Opción "Gestionar mi negocio"');
  print('   📊 Dashboard con analytics básicos');
  print('   🎯 Opciones para crear primer lugar');
  print('   📝 Gestión de información del negocio');
  print('');
  print('   📋 Próximos pasos para el usuario:');
  print('   1. 🏪 Crear primer lugar/sucursal');
  print('   2. 📸 Subir fotos del negocio');
  print('   3. 📝 Configurar horarios y servicios');
  print('   4. 🎯 Crear ofertas especiales');
  print('   5. 📊 Monitorear reviews y analytics\n');

  // Verificar que el usuario ahora es admin
  final getCurrentResult = await adminAuthRepo.getCurrentAdminUser();
  getCurrentResult.fold(
    (failure) => print('   ⚠️ Error verificando estado: $failure'),
    (adminUser) {
      if (adminUser != null) {
        print('   ✅ Verificación: Usuario es ahora Business Owner');
        print(
          '   🎯 Puede gestionar: ${adminUser.ownedPlaceIds.length} lugares',
        );
        print(
          '   🔑 Permisos activos: ${adminUser.allPermissions.map((p) => p.displayName).join(", ")}',
        );
      }
    },
  );
}

/// 📱 Ejemplo de UI para el usuario
void demonstrateUserInterface() {
  print('\n📱 === EJEMPLO DE INTERFAZ DE USUARIO ===\n');

  print('🏠 PANTALLA PRINCIPAL (Usuario regular):');
  print('┌─────────────────────────────────────┐');
  print('│  🏠 Inicio                         │');
  print('│  🔍 Buscar lugares                 │');
  print('│  ⭐ Mis favoritos                  │');
  print('│  📝 Mis reviews                    │');
  print('│  ➕ ¿Tienes un negocio?            │'); // <-- BOTÓN CLAVE
  print('│     Créalo aquí                    │');
  print('└─────────────────────────────────────┘');
  print('');

  print('🏢 FORMULARIO "CREAR MI NEGOCIO":');
  print('┌─────────────────────────────────────┐');
  print('│  📝 Crear mi lugar de negocio      │');
  print('│  ─────────────────────────────────  │');
  print('│  🏢 Nombre del negocio: ___________  │');
  print('│  📝 Descripción: __________________  │');
  print('│  📍 Dirección: ____________________  │');
  print('│  📞 Teléfono: _____________________  │');
  print('│  🌐 Website: ______________________  │');
  print('│  📂 Categoría: ____________________  │');
  print('│  ─────────────────────────────────  │');
  print('│  [Cancelar]         [Enviar] 🚀    │');
  print('└─────────────────────────────────────┘');
  print('');

  print('✅ DESPUÉS DE APROBACIÓN:');
  print('┌─────────────────────────────────────┐');
  print('│  🎉 ¡Bienvenido Business Owner!    │');
  print('│  ─────────────────────────────────  │');
  print('│  🏢 Gestionar mi negocio           │');
  print('│  📊 Analytics y reportes           │');
  print('│  🎯 Crear ofertas especiales       │');
  print('│  📝 Gestionar reviews              │');
  print('│  📸 Galería de fotos               │');
  print('│  ⚙️ Configuración                  │');
  print('└─────────────────────────────────────┘');
}

/// 🔄 Ejemplo de estados de solicitud
void demonstrateRequestStates() {
  print('\n🔄 === ESTADOS DE LA SOLICITUD ===\n');

  print('Para el Usuario:');
  print('⏳ Pendiente    - "Tu solicitud está siendo revisada"');
  print('🔄 En Revisión  - "Estamos verificando tu información"');
  print('📝 Más Info     - "Necesitamos información adicional"');
  print('✅ Aprobada     - "¡Felicidades! Solicitud aprobada"');
  print('❌ Rechazada    - "Solicitud no aprobada"');
  print('');

  print('Para el Super Admin:');
  print(
    '⏳ ${BusinessOwnerRequestStatus.pending.displayName} - Acción requerida',
  );
  print('🔄 ${BusinessOwnerRequestStatus.reviewing.displayName} - En proceso');
  print(
    '📝 ${BusinessOwnerRequestStatus.needsMoreInfo.displayName} - Esperando respuesta',
  );
  print('✅ ${BusinessOwnerRequestStatus.approved.displayName} - Completado');
  print('❌ ${BusinessOwnerRequestStatus.rejected.displayName} - Cerrado');
}

/// 📊 Dashboard de super admin
void demonstrateSuperAdminDashboard() {
  print('\n📊 === DASHBOARD SUPER ADMIN ===\n');

  print('┌─────────────────────────────────────────────────────┐');
  print('│  👑 Panel de Business Owner Requests               │');
  print('│  ─────────────────────────────────────────────────  │');
  print('│  📊 Estadísticas:                                  │');
  print('│     ⏳ Pendientes: 5    🔄 En revisión: 2          │');
  print('│     ✅ Aprobadas: 23    ❌ Rechazadas: 3           │');
  print('│     ⚡ Urgentes: 1     📈 Tasa aprobación: 88.5%   │');
  print('│  ─────────────────────────────────────────────────  │');
  print('│  📋 Solicitudes Recientes:                         │');
  print('│  🟠 Carlos R. - Restaurante La Abuela (2 días)     │');
  print('│  🔵 María L. - Café Central (5 días) ⚡             │');
  print('│  🟠 José M. - Barbería El Corte (1 día)            │');
  print('│  ─────────────────────────────────────────────────  │');
  print('│  [Ver Todas] [Filtros] [Exportar] [Configuración]  │');
  print('└─────────────────────────────────────────────────────┘');
}

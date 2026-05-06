import 'dart:io';

/// Script para configurar automáticamente la base de datos de Supabase
///
/// Este script proporciona instrucciones y verifica la configuración
class SupabaseSetup {
  static const String _setupSqlPath = 'scripts/supabase_database_setup.sql';

  /// Muestra las instrucciones de setup
  static void showSetupInstructions() {
    print('''
🚀 SUPABASE DATABASE SETUP - TURBO PLATFORM
=====================================================

📋 PASOS PARA CONFIGURAR LA BASE DE DATOS:

1. 📝 CREAR PROYECTO SUPABASE:
   - Ve a https://supabase.com
   - Crea un nuevo proyecto
   - Anota la URL y las API keys

2. 🔑 CONFIGURAR VARIABLES DE ENTORNO:
   Crea un archivo .env en la raíz del proyecto:
   
   SUPABASE_URL=https://tu-proyecto.supabase.co
   SUPABASE_ANON_KEY=tu-anon-key
   SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key

3. 🗄️ EJECUTAR SCRIPT SQL:
   
   OPCIÓN A - Desde Supabase Dashboard:
   - Ve a SQL Editor en tu proyecto Supabase
   - Copia todo el contenido de: $_setupSqlPath
   - Pega y ejecuta el script
   
   OPCIÓN B - Desde línea de comandos:
   - Instala psql si no lo tienes
   - Ejecuta: psql "postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres" -f $_setupSqlPath

4. ✅ VERIFICAR INSTALACIÓN:
   - Ve a Table Editor en Supabase
   - Verifica que se crearon todas las tablas
   - Revisa que hay datos de muestra

5. 🔧 CONFIGURAR AUTENTICACIÓN:
   - Ve a Authentication > Settings
   - Configura los providers que necesites (Email, Google, etc.)
   - Actualiza las URLs de redirección

6. 🧪 PROBAR SERVICIOS:
   - Ejecuta los tests de los servicios Supabase
   - Verifica que las funciones CRUD funcionan
   - Prueba la autenticación

📊 TABLAS QUE SE CREARÁN:
- users (usuarios con autenticación)
- categories (categorías de lugares)
- places (lugares/negocios)
- reviews (reseñas con moderación)
- favorites (favoritos de usuarios)
- events (eventos)
- place_categories (relaciones many-to-many)
- place_locations (ubicaciones geoespaciales)
- admin_users (usuarios administrativos)
- business_owner_requests (solicitudes de propietarios)

🔧 FUNCIONES Y TRIGGERS:
- increment_category_places_count()
- decrement_category_places_count()
- update_place_rating()
- Triggers automáticos para timestamps
- Triggers para actualizar ratings

🔒 SEGURIDAD:
- Row Level Security (RLS) habilitado
- Políticas de acceso configuradas
- Autenticación integrada

📈 DATOS DE MUESTRA:
- 5 categorías (Restaurantes, Cafeterías, etc.)
- 5 lugares con ubicaciones reales
- Usuarios de prueba
- Reseñas y favoritos de ejemplo
- Eventos próximos

🔧 TROUBLESHOOTING:

❌ Error: "permission denied"
   → Usa SERVICE_ROLE_KEY en lugar de ANON_KEY

❌ Error: "table already exists"
   → El script usa IF NOT EXISTS, es seguro ejecutarlo múltiples veces

❌ Error: "function does not exist"
   → Ejecuta el script completo en orden

❌ Error: "RLS policy failed"
   → Verifica que auth está habilitado en Supabase

❌ Error: "connection failed"
   → Verifica la URL y credenciales de Supabase

📚 DOCUMENTACIÓN ADICIONAL:
- supabase_database_schema.md - Detalles del schema
- supabase_migration_status.md - Estado de la migración
- README.md - Guía general del proyecto

🎉 ¡TU BASE DE DATOS ESTARÁ LISTA PARA PRODUCCIÓN!
''');
  }

  /// Verifica que el archivo SQL existe
  static Future<bool> verifySqlFile() async {
    final file = File(_setupSqlPath);
    if (await file.exists()) {
      final content = await file.readAsString();
      print('✅ Archivo SQL encontrado: $_setupSqlPath');
      print('   Tamaño: ${content.length} caracteres');
      print('   Líneas: ${content.split('\n').length}');
      return true;
    } else {
      print('❌ Archivo SQL no encontrado: $_setupSqlPath');
      return false;
    }
  }

  /// Muestra el contenido del archivo SQL
  static Future<void> showSqlContent() async {
    final file = File(_setupSqlPath);
    if (await file.exists()) {
      print('\n📄 CONTENIDO DEL ARCHIVO SQL:');
      print('=====================================================');
      final content = await file.readAsString();
      print(content);
      print('=====================================================');
    } else {
      print('❌ Archivo SQL no encontrado');
    }
  }

  /// Verifica las variables de entorno
  static void checkEnvironmentVariables() {
    print('\n🔍 VERIFICANDO VARIABLES DE ENTORNO:');

    final supabaseUrl = Platform.environment['SUPABASE_URL'];
    final supabaseAnonKey = Platform.environment['SUPABASE_ANON_KEY'];
    final supabaseServiceKey =
        Platform.environment['SUPABASE_SERVICE_ROLE_KEY'];

    print(
        'SUPABASE_URL: ${supabaseUrl != null ? '✅ Configurado' : '❌ Faltante'}');
    print(
        'SUPABASE_ANON_KEY: ${supabaseAnonKey != null ? '✅ Configurado' : '❌ Faltante'}');
    print(
        'SUPABASE_SERVICE_ROLE_KEY: ${supabaseServiceKey != null ? '✅ Configurado' : '❌ Faltante'}');

    if (supabaseUrl == null ||
        supabaseAnonKey == null ||
        supabaseServiceKey == null) {
      print('\n⚠️  Configura las variables de entorno antes de continuar');
    } else {
      print('\n✅ Todas las variables están configuradas');
    }
  }

  /// Muestra comandos útiles
  static void showUsefulCommands() {
    print('''
🔧 COMANDOS ÚTILES:

# Verificar archivo SQL
dart run scripts/supabase_setup.dart --check-sql

# Mostrar contenido SQL
dart run scripts/supabase_setup.dart --show-sql

# Verificar variables de entorno
dart run scripts/supabase_setup.dart --check-env

# Ejecutar tests de servicios
dart test test/src/turbo_core_repositories/

# Analizar código
dart analyze lib/src/turbo_core_repositories/

# Verificar migración
dart run scripts/supabase_setup.dart --help
''');
  }
}

/// Función principal
void main(List<String> args) async {
  if (args.contains('--help') || args.contains('-h')) {
    SupabaseSetup.showSetupInstructions();
    return;
  }

  if (args.contains('--check-sql')) {
    await SupabaseSetup.verifySqlFile();
    return;
  }

  if (args.contains('--show-sql')) {
    await SupabaseSetup.showSqlContent();
    return;
  }

  if (args.contains('--check-env')) {
    SupabaseSetup.checkEnvironmentVariables();
    return;
  }

  if (args.contains('--commands')) {
    SupabaseSetup.showUsefulCommands();
    return;
  }

  // Por defecto, mostrar instrucciones
  SupabaseSetup.showSetupInstructions();

  print('\n');
  SupabaseSetup.checkEnvironmentVariables();

  print('\n');
  await SupabaseSetup.verifySqlFile();
}

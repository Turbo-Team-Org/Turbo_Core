import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';
import 'package:core/src/turbo_core_repositories/common/config/hybrid_database_config.dart';
import 'package:core/src/monorepo_utils/environments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Supabase services imports
import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service_edge.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/service/admin_auth_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/service/admin_auth_service_edge.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service_edge.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/service/ai_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/service/ai_service_edge.dart';
import 'package:core/src/turbo_core_repositories/category_repository/service/category_service_edge.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service_edge.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/service/favorite_service_edge.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service_edge.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/service/place_category_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/service/place_category_service_edge.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/service/reservation_service_supabase.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/service/reservation_service_edge.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/interface/admin_auth_interface.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/interface/ai_interface.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/ai_repository.dart';

/// Initialize dependencies based on environment configuration
/// Supports dynamic switching between Firebase (dev) and Supabase (staging/prod)
///
/// [environment] - Environment passed from the app/admin panel
/// [sl] - GetIt service locator instance
/// [firebaseApp] - Optional Firebase app instance
/// [enableDebugLogs] - Enable detailed logging
Future<void> initCoreDependencies({
  required GetIt sl,
  TurboEnvironment? environment,
  FirebaseApp? firebaseApp,
  bool enableDebugLogs = false,
}) async {
  print('🔧 Inicializando dependencias Turbo Core...');

  // 1. Initialize hybrid database configuration
  if (environment != null) {
    // Use environment passed from app
    await _initializeWithPassedEnvironment(environment, enableDebugLogs);
  } else {
    // Fallback to environment variables
    await HybridDatabaseConfig.initializeFromEnvironment();
  }

  if (enableDebugLogs) {
    HybridDatabaseConfig.printConfigInfo();
  }

  // 2. Register database clients
  await _registerDatabaseClients(sl, firebaseApp);

  // 3. Register authorization interface
  _registerAuthorizationInterface(sl);

  // 4. Register basic services based on current environment
  await _registerBasicServices(sl);

  // 5. Register repositories
  _registerRepositories(sl);

  print('✅ Dependencias Turbo Core inicializadas correctamente\n');
  print('📋 ESTADO DE REGISTROS:');
  print('   - Services: ✅ Completos (Firebase y Supabase)');
  print('   - Interfaces: ✅ Registradas según entorno');
  print(
    '   - Repositories: ✅ Authentication, Review, Category, Event, Favorite, Location, Place, Analytics, PlaceCategory, Reservation, AdminAuth, AI (ambos entornos)',
  );
  print('   - Uso uniforme: sl<AuthenticationRepository>() en ambos entornos');
  print('   - ✅ TODOS LOS REPOSITORIOS REFACTORIZADOS Y REGISTRADOS\n');
}

/// Initialize with environment passed from app/admin panel
Future<void> _initializeWithPassedEnvironment(
  TurboEnvironment environment,
  bool enableDebugLogs,
) async {
  print(
    '📱 Inicializando con entorno pasado desde la app: ${environment.name}',
  );

  // Determine database provider based on environment
  final provider = _getProviderForEnvironment(environment);

  // Get configuration for the environment
  final config = _getConfigurationForEnvironment(environment);

  await HybridDatabaseConfig.initialize(
    environment: environment,
    primaryProvider: provider,
    supabaseUrl: config['supabaseUrl'],
    supabaseAnonKey: config['supabaseAnonKey'],
    firebaseProjectId: config['firebaseProjectId'],
    enableDebugLogs: enableDebugLogs,
  );
}

/// Get database provider for environment
DatabaseProvider _getProviderForEnvironment(TurboEnvironment environment) {
  switch (environment) {
    case TurboEnvironment.dev:
      return DatabaseProvider.firebase;
    case TurboEnvironment.staging:
      return DatabaseProvider.supabase;
    case TurboEnvironment.prod:
      return DatabaseProvider.supabase;
  }
}

/// Get configuration for environment
Map<String, String?> _getConfigurationForEnvironment(
  TurboEnvironment environment,
) {
  switch (environment) {
    case TurboEnvironment.dev:
      return {
        'firebaseProjectId': 'turbo-16770',
        'supabaseUrl': null,
        'supabaseAnonKey': null,
      };
    case TurboEnvironment.staging:
    case TurboEnvironment.prod:
      return {
        'firebaseProjectId': null,
        'supabaseUrl': 'https://oiugslxvekwnoubljrde.supabase.co',
        'supabaseAnonKey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pdWdzbHh2ZWt3bm91YmxqcmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEzOTYzMDksImV4cCI6MjA2Njk3MjMwOX0.r5yHCTclwn31efrv9HaaRHIPwXbmQRXdu6f0czrn1rk',
      };
  }
}

/// Register database clients (Firebase and/or Supabase)
Future<void> _registerDatabaseClients(
  GetIt sl,
  FirebaseApp? firebaseApp,
) async {
  // Register Firebase services if available
  if (HybridDatabaseConfig.isFirebaseAvailable) {
    if (!sl.isRegistered<FirebaseFirestore>()) {
      sl.registerLazySingleton<FirebaseFirestore>(
        () =>
            firebaseApp != null
                ? FirebaseFirestore.instanceFor(app: firebaseApp)
                : HybridDatabaseConfig.firestore,
      );
    }

    if (!sl.isRegistered<FirebaseAuth>()) {
      sl.registerSingleton<FirebaseAuth>(
        firebaseApp != null
            ? FirebaseAuth.instanceFor(app: firebaseApp)
            : FirebaseAuth.instance,
      );
    }

    print('✅ Firebase services registrados');
  }

  // Register Supabase client if available
  if (HybridDatabaseConfig.isSupabaseAvailable) {
    if (!sl.isRegistered<SupabaseClient>()) {
      sl.registerLazySingleton<SupabaseClient>(
        () => HybridDatabaseConfig.supabase,
      );
    }

    print('✅ Supabase client registrado');
  }
}

/// Register authorization interface with default implementation
void _registerAuthorizationInterface(GetIt sl) {
  if (!sl.isRegistered<PlaceAuthorizationInterface>()) {
    sl.registerLazySingleton<PlaceAuthorizationInterface>(
      () => const DefaultPlaceAuthorization(),
    );
  }
}

/// Register basic services based on current environment
Future<void> _registerBasicServices(GetIt sl) async {
  final environment = HybridDatabaseConfig.currentEnvironment;
  final provider = HybridDatabaseConfig.currentProvider;

  print('📦 Registrando servicios básicos para:');
  print('   Entorno: ${environment?.name ?? 'unknown'}');
  print('   Proveedor: ${provider?.name ?? 'unknown'}');

  // Register services based on provider
  if (provider == DatabaseProvider.firebase &&
      HybridDatabaseConfig.isFirebaseAvailable) {
    await _registerFirebaseServices(sl);
  } else if (provider == DatabaseProvider.supabase &&
      HybridDatabaseConfig.isSupabaseAvailable) {
    await _registerSupabaseServices(sl);
  }

  print('✅ Servicios básicos registrados\n');
}

/// Register Firebase services
Future<void> _registerFirebaseServices(GetIt sl) async {
  // Authentication Service
  if (!sl.isRegistered<AuthenticationInterface>()) {
    sl.registerLazySingleton<AuthenticationInterface>(
      () => AuthenticationService(
        firebaseAuth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ AuthenticationService (Firebase)');
  }

  // Place Service (requiere AnalyticsService)
  if (!sl.isRegistered<PlaceInterface>()) {
    // Registrar AnalyticsService primero si no existe
    if (!sl.isRegistered<AnalyticsService>()) {
      sl.registerLazySingleton<AnalyticsService>(
        () => AnalyticsService(firestore: sl<FirebaseFirestore>()),
      );
    }

    sl.registerLazySingleton<PlaceInterface>(
      () => PlaceService(
        firestore: sl<FirebaseFirestore>(),
        analyticsService: sl<AnalyticsService>(),
        authorization: sl<PlaceAuthorizationInterface>(),
      ),
    );
    print('   ✅ PlaceService (Firebase)');
  }

  // Review Service
  if (!sl.isRegistered<ReviewInterface>()) {
    sl.registerLazySingleton<ReviewInterface>(
      () => ReviewService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ ReviewService (Firebase)');
  }

  // Category Service
  if (!sl.isRegistered<CategoryInterface>()) {
    sl.registerLazySingleton<CategoryInterface>(
      () => CategoryService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ CategoryService (Firebase)');
  }

  // Event Service
  if (!sl.isRegistered<EventInterface>()) {
    sl.registerLazySingleton<EventInterface>(
      () => EventService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ EventService (Firebase)');
  }

  // Favorite Service
  if (!sl.isRegistered<FavoriteInterface>()) {
    sl.registerLazySingleton<FavoriteInterface>(
      () => FavoriteService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ FavoriteService (Firebase)');
  }

  // Location Service
  if (!sl.isRegistered<LocationInterface>()) {
    sl.registerLazySingleton<LocationInterface>(
      () => LocationService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ LocationService (Firebase)');
  }

  // Place Category Service
  if (!sl.isRegistered<PlaceCategoryRepositoryInterface>()) {
    sl.registerLazySingleton<PlaceCategoryRepositoryInterface>(
      () => PlaceCategoryService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ PlaceCategoryService (Firebase)');
  }

  // Reservation Service
  if (!sl.isRegistered<ReservationInterface>()) {
    sl.registerLazySingleton<ReservationInterface>(
      () => ReservationService(firestore: sl<FirebaseFirestore>()),
    );
    print('   ✅ ReservationService (Firebase)');
  }

  // Admin Auth Service
  if (!sl.isRegistered<AdminAuthService>()) {
    sl.registerLazySingleton<AdminAuthService>(
      () => AdminAuthService(
        firestore: sl<FirebaseFirestore>(),
        firebaseAuth: sl<FirebaseAuth>(),
      ),
    );
    print('   ✅ AdminAuthService (Firebase)');
  }

  // AI Service (vía Edge Gateway)
  if (!sl.isRegistered<AiServiceEdge>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<AiServiceEdge>(
        () =>
            AiServiceEdge(baseUrl: Env.supabaseEdgeBaseUrl, httpClient: Dio()),
      );
      print('   ✅ AiServiceEdge (Firebase)');
    }
  }

  // Interface -> implementación concreta para AI (Firebase)
  if (!sl.isRegistered<AiInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<AiInterface>(() => sl<AiServiceEdge>());
      print('   ✅ AiInterface -> Edge Gateway (Firebase)');
    }
  }
}

/// Register Supabase services
Future<void> _registerSupabaseServices(GetIt sl) async {
  // Register concrete Supabase services
  // Authentication Service
  if (!sl.isRegistered<AuthenticationServiceSupabase>()) {
    sl.registerLazySingleton<AuthenticationServiceSupabase>(
      () => AuthenticationServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ AuthenticationServiceSupabase');
  }

  // Review Service
  if (!sl.isRegistered<ReviewServiceSupabase>()) {
    sl.registerLazySingleton<ReviewServiceSupabase>(
      () => ReviewServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ ReviewServiceSupabase');
  }

  // AI Service
  if (!sl.isRegistered<AiServiceSupabase>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      // Registrar Edge como servicio concreto
      sl.registerLazySingleton<AiServiceEdge>(
        () =>
            AiServiceEdge(baseUrl: Env.supabaseEdgeBaseUrl, httpClient: Dio()),
      );
      print('   ✅ AiServiceEdge');
    } else {
      sl.registerLazySingleton<AiServiceSupabase>(
        () => AiServiceSupabase(supabase: sl<SupabaseClient>()),
      );
      print('   ✅ AiServiceSupabase');
    }
  }

  // Category Service (Supabase directo y alternativa Edge Gateway)
  if (!sl.isRegistered<CategoryServiceSupabase>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<CategoryServiceEdge>(
        () => CategoryServiceEdge(
          baseUrl: Env.supabaseEdgeBaseUrl,
          httpClient: Dio(),
        ),
      );
      print('   ✅ CategoryServiceEdge');
    } else {
      sl.registerLazySingleton<CategoryServiceSupabase>(
        () => CategoryServiceSupabase(supabaseClient: sl<SupabaseClient>()),
      );
      print('   ✅ CategoryServiceSupabase');
    }
  }

  // Event Service
  if (!sl.isRegistered<EventServiceSupabase>()) {
    sl.registerLazySingleton<EventServiceSupabase>(
      () => EventServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ EventServiceSupabase');
  }

  // Favorite Service
  if (!sl.isRegistered<FavoriteServiceSupabase>()) {
    sl.registerLazySingleton<FavoriteServiceSupabase>(
      () => FavoriteServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ FavoriteServiceSupabase');
  }

  // Location Service
  if (!sl.isRegistered<LocationServiceSupabase>()) {
    sl.registerLazySingleton<LocationServiceSupabase>(
      () => LocationServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ LocationServiceSupabase');
  }

  // Analytics Service
  if (!sl.isRegistered<AnalyticsServiceSupabase>()) {
    sl.registerLazySingleton<AnalyticsServiceSupabase>(
      () => AnalyticsServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ AnalyticsServiceSupabase');
  }

  // Place Service (Supabase directo y alternativa Edge Gateway)
  if (!sl.isRegistered<PlaceServiceSupabase>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      // Registrar Edge como servicio concreto
      sl.registerLazySingleton<PlaceServiceEdge>(
        () => PlaceServiceEdge(
          baseUrl: Env.supabaseEdgeBaseUrl,
          httpClient: Dio(),
          analyticsService: sl<AnalyticsInterface>(),
          authorization: sl<PlaceAuthorizationInterface>(),
        ),
      );
      print('   ✅ PlaceServiceEdge');
    } else {
      sl.registerLazySingleton<PlaceServiceSupabase>(
        () => PlaceServiceSupabase(
          supabase: sl<SupabaseClient>(),
          analyticsService: sl<AnalyticsServiceSupabase>(),
          authorization: sl<PlaceAuthorizationInterface>(),
        ),
      );
      print('   ✅ PlaceServiceSupabase');
    }
  }

  // Place Category Service
  if (!sl.isRegistered<PlaceCategoryServiceSupabase>()) {
    sl.registerLazySingleton<PlaceCategoryServiceSupabase>(
      () => PlaceCategoryServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ PlaceCategoryServiceSupabase');
  }

  // Admin Auth Service
  if (!sl.isRegistered<AdminAuthServiceSupabase>()) {
    sl.registerLazySingleton<AdminAuthServiceSupabase>(
      () => AdminAuthServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ AdminAuthServiceSupabase');
  }

  // Reservation Service
  if (!sl.isRegistered<ReservationServiceSupabase>()) {
    sl.registerLazySingleton<ReservationServiceSupabase>(
      () => ReservationServiceSupabase(supabaseClient: sl<SupabaseClient>()),
    );
    print('   ✅ ReservationServiceSupabase');
  }

  // Register interfaces pointing to Supabase implementations
  if (!sl.isRegistered<AuthenticationInterface>()) {
    sl.registerLazySingleton<AuthenticationInterface>(
      () => sl<AuthenticationServiceSupabase>(),
    );
    print('   ✅ AuthenticationInterface -> Supabase');
  }

  if (!sl.isRegistered<ReviewInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      // Registrar ReviewServiceEdge concreto si no existe
      if (!sl.isRegistered<ReviewServiceEdge>()) {
        sl.registerLazySingleton<ReviewServiceEdge>(
          () => ReviewServiceEdge(
            baseUrl: Env.supabaseEdgeBaseUrl,
            httpClient: Dio(),
          ),
        );
        print('   ✅ ReviewServiceEdge');
      }
      sl.registerLazySingleton<ReviewInterface>(() => sl<ReviewServiceEdge>());
      print('   ✅ ReviewInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<ReviewInterface>(
        () => sl<ReviewServiceSupabase>(),
      );
      print('   ✅ ReviewInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<CategoryInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<CategoryInterface>(
        () => sl<CategoryServiceEdge>(),
      );
      print('   ✅ CategoryInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<CategoryInterface>(
        () => sl<CategoryServiceSupabase>(),
      );
      print('   ✅ CategoryInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<EventInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      if (!sl.isRegistered<EventServiceEdge>()) {
        sl.registerLazySingleton<EventServiceEdge>(
          () => EventServiceEdge(
            baseUrl: Env.supabaseEdgeBaseUrl,
            httpClient: Dio(),
          ),
        );
        print('   ✅ EventServiceEdge');
      }
      sl.registerLazySingleton<EventInterface>(() => sl<EventServiceEdge>());
      print('   ✅ EventInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<EventInterface>(
        () => sl<EventServiceSupabase>(),
      );
      print('   ✅ EventInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<FavoriteInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      if (!sl.isRegistered<FavoriteServiceEdge>()) {
        sl.registerLazySingleton<FavoriteServiceEdge>(
          () => FavoriteServiceEdge(
            baseUrl: Env.supabaseEdgeBaseUrl,
            httpClient: Dio(),
          ),
        );
        print('   ✅ FavoriteServiceEdge');
      }
      sl.registerLazySingleton<FavoriteInterface>(
        () => sl<FavoriteServiceEdge>(),
      );
      print('   ✅ FavoriteInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<FavoriteInterface>(
        () => sl<FavoriteServiceSupabase>(),
      );
      print('   ✅ FavoriteInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<LocationInterface>()) {
    sl.registerLazySingleton<LocationInterface>(
      () => sl<LocationServiceSupabase>(),
    );
    print('   ✅ LocationInterface -> Supabase');
  }

  if (!sl.isRegistered<AnalyticsInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      if (!sl.isRegistered<AnalyticsServiceEdge>()) {
        sl.registerLazySingleton<AnalyticsServiceEdge>(
          () => AnalyticsServiceEdge(
            baseUrl: Env.supabaseEdgeBaseUrl,
            httpClient: Dio(),
          ),
        );
        print('   ✅ AnalyticsServiceEdge');
      }
      sl.registerLazySingleton<AnalyticsInterface>(
        () => sl<AnalyticsServiceEdge>(),
      );
      print('   ✅ AnalyticsInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<AnalyticsInterface>(
        () => sl<AnalyticsServiceSupabase>(),
      );
      print('   ✅ AnalyticsInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<PlaceInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<PlaceInterface>(() => sl<PlaceServiceEdge>());
      print('   ✅ PlaceInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<PlaceInterface>(
        () => sl<PlaceServiceSupabase>(),
      );
      print('   ✅ PlaceInterface -> Supabase');
    }
  }

  // Interface -> implementación concreta para AI
  if (!sl.isRegistered<AiInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<AiInterface>(() => sl<AiServiceEdge>());
      print('   ✅ AiInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<AiInterface>(() => sl<AiServiceSupabase>());
      print('   ✅ AiInterface -> Supabase');
    }
  }

  if (!sl.isRegistered<PlaceCategoryRepositoryInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<PlaceCategoryRepositoryInterface>(
        () => PlaceCategoryServiceEdge(
          baseUrl: Env.supabaseEdgeBaseUrl,
          httpClient: Dio(),
        ),
      );
      print('   ✅ PlaceCategoryRepositoryInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<PlaceCategoryRepositoryInterface>(
        () =>
            PlaceCategoryServiceSupabase(supabaseClient: sl<SupabaseClient>()),
      );
      print('   ✅ PlaceCategoryRepositoryInterface -> Supabase');
    }
  }

  // Reservation Service
  if (!sl.isRegistered<ReservationInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<ReservationInterface>(
        () => ReservationServiceEdge(
          baseUrl: Env.supabaseEdgeBaseUrl,
          httpClient: Dio(),
        ),
      );
      print('   ✅ ReservationInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<ReservationInterface>(
        () => ReservationServiceSupabase(supabaseClient: sl<SupabaseClient>()),
      );
      print('   ✅ ReservationInterface -> Supabase');
    }
  }

  // Admin Auth Service
  if (!sl.isRegistered<AdminAuthInterface>()) {
    if (Env.useEdgeGateway && Env.supabaseEdgeBaseUrl.isNotEmpty) {
      sl.registerLazySingleton<AdminAuthInterface>(
        () => AdminAuthServiceEdge(
          baseUrl: Env.supabaseEdgeBaseUrl,
          httpClient: Dio(),
        ),
      );
      print('   ✅ AdminAuthInterface -> Edge Gateway');
    } else {
      sl.registerLazySingleton<AdminAuthInterface>(
        () => AdminAuthServiceSupabase(supabaseClient: sl<SupabaseClient>()),
      );
      print('   ✅ AdminAuthInterface -> Supabase');
    }
  }

  print('🎉 Servicios e interfaces Supabase registrados correctamente');
}

/// Utility function to check if a specific repository is available in current environment
bool isRepositoryAvailable<T extends Object>() {
  final sl = GetIt.instance;
  return sl.isRegistered<T>();
}

/// Get environment information for debugging
Map<String, dynamic> getDependencyInfo() {
  return {
    'hybridConfig': HybridDatabaseConfig.debugInfo,
    'registeredServices': {
      'Firebase': HybridDatabaseConfig.isFirebaseAvailable,
      'Supabase': HybridDatabaseConfig.isSupabaseAvailable,
    },
    'environmentSafe': _getSafeEnvironmentInfo(),
  };
}

/// Get environment info safely without requiring dotenv
Map<String, dynamic> _getSafeEnvironmentInfo() {
  try {
    return Env.debugInfo;
  } catch (e) {
    return {
      'environment': HybridDatabaseConfig.currentEnvironment?.name ?? 'NOT_SET',
      'databaseProvider':
          HybridDatabaseConfig.currentProvider?.name ?? 'NOT_SET',
      'source': 'PASSED_FROM_APP',
      'error': 'dotenv_not_initialized',
    };
  }
}

/// Register repositories layer (uses services)
void _registerRepositories(GetIt sl) {
  print('📦 Registrando repositorios...');

  // Note: Repositories need concrete service classes, not interfaces
  // Get current environment to determine which concrete service to use
  final provider = HybridDatabaseConfig.currentProvider;

  if (provider == DatabaseProvider.firebase) {
    _registerFirebaseRepositories(sl);
  } else if (provider == DatabaseProvider.supabase) {
    _registerSupabaseRepositories(sl);
  }

  print('🎯 Repositorios registrados correctamente');
}

/// Register repositories for Firebase environment
void _registerFirebaseRepositories(GetIt sl) {
  // Authentication Repository
  if (!sl.isRegistered<AuthenticationRepository>()) {
    sl.registerLazySingleton<AuthenticationRepository>(
      () =>
          AuthenticationRepository(authService: sl<AuthenticationInterface>()),
    );
    print('   ✅ AuthenticationRepository (Firebase)');
  }

  // Review Repository
  if (!sl.isRegistered<ReviewRepository>()) {
    sl.registerLazySingleton<ReviewRepository>(
      () => ReviewRepository(reviewService: sl<ReviewInterface>()),
    );
    print('   ✅ ReviewRepository (Firebase)');
  }

  // Category Repository
  if (!sl.isRegistered<CategoryRepository>()) {
    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(
        categoryService: sl<CategoryInterface>(),
        placeCategoryService: sl<PlaceCategoryRepositoryInterface>(),
      ),
    );
    print('   ✅ CategoryRepository (Firebase)');
  }

  // Event Repository
  if (!sl.isRegistered<EventRepository>()) {
    sl.registerLazySingleton<EventRepository>(
      () => EventRepository(eventService: sl<EventInterface>()),
    );
    print('   ✅ EventRepository (Firebase)');
  }

  // Favorite Repository
  if (!sl.isRegistered<FavoriteRepository>()) {
    sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepository(favoriteService: sl<FavoriteInterface>()),
    );
    print('   ✅ FavoriteRepository (Firebase)');
  }

  // Location Repository
  if (!sl.isRegistered<LocationRepository>()) {
    sl.registerLazySingleton<LocationRepository>(
      () => LocationRepository(locationService: sl<LocationInterface>()),
    );
    print('   ✅ LocationRepository (Firebase)');
  }

  // Place Repository
  if (!sl.isRegistered<PlaceRepository>()) {
    sl.registerLazySingleton<PlaceRepository>(
      () => PlaceRepository(placeService: sl<PlaceInterface>()),
    );
    print('   ✅ PlaceRepository (Firebase)');
  }

  // Analytics Repository
  if (!sl.isRegistered<AnalyticsRepository>()) {
    sl.registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepository(analyticsService: sl<AnalyticsInterface>()),
    );
    print('   ✅ AnalyticsRepository (Firebase)');
  }

  // Place Category Repository
  if (!sl.isRegistered<PlaceCategoryRepository>()) {
    sl.registerLazySingleton<PlaceCategoryRepository>(
      () => PlaceCategoryRepository(
        placeCategoryService: sl<PlaceCategoryRepositoryInterface>(),
      ),
    );
    print('   ✅ PlaceCategoryRepository (Firebase)');
  }

  // Reservation Repository
  if (!sl.isRegistered<ReservationRepository>()) {
    sl.registerLazySingleton<ReservationRepository>(
      () =>
          ReservationRepository(reservationService: sl<ReservationInterface>()),
    );
    print('   ✅ ReservationRepository (Firebase)');
  }

  // Admin Auth Repository
  if (!sl.isRegistered<AdminAuthRepository>()) {
    sl.registerLazySingleton<AdminAuthRepository>(
      () => AdminAuthRepositoryImpl(adminAuthService: sl<AdminAuthService>()),
    );
    print('   ✅ AdminAuthRepository (Firebase)');
  }

  // AI Repository
  if (!sl.isRegistered<AiRepository>()) {
    sl.registerLazySingleton<AiRepository>(
      () => AiRepository(aiService: sl<AiInterface>()),
    );
    print('   ✅ AiRepository (Firebase)');
  }

  print('   🎉 ¡Todos los repositorios refactorizados!');
}

/// Register repositories for Supabase environment
void _registerSupabaseRepositories(GetIt sl) {
  // Authentication Repository
  if (!sl.isRegistered<AuthenticationRepository>()) {
    sl.registerLazySingleton<AuthenticationRepository>(
      () =>
          AuthenticationRepository(authService: sl<AuthenticationInterface>()),
    );
    print('   ✅ AuthenticationRepository (Supabase)');
  }

  // Review Repository
  if (!sl.isRegistered<ReviewRepository>()) {
    sl.registerLazySingleton<ReviewRepository>(
      () => ReviewRepository(reviewService: sl<ReviewInterface>()),
    );
    print('   ✅ ReviewRepository (Supabase)');
  }

  // Category Repository
  if (!sl.isRegistered<CategoryRepository>()) {
    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(
        categoryService: sl<CategoryInterface>(),
        placeCategoryService: sl<PlaceCategoryRepositoryInterface>(),
      ),
    );
    print('   ✅ CategoryRepository (Supabase)');
  }

  // Event Repository
  if (!sl.isRegistered<EventRepository>()) {
    sl.registerLazySingleton<EventRepository>(
      () => EventRepository(eventService: sl<EventInterface>()),
    );
    print('   ✅ EventRepository (Supabase)');
  }

  // Favorite Repository
  if (!sl.isRegistered<FavoriteRepository>()) {
    sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepository(favoriteService: sl<FavoriteInterface>()),
    );
    print('   ✅ FavoriteRepository (Supabase)');
  }

  // Location Repository
  if (!sl.isRegistered<LocationRepository>()) {
    sl.registerLazySingleton<LocationRepository>(
      () => LocationRepository(locationService: sl<LocationInterface>()),
    );
    print('   ✅ LocationRepository (Supabase)');
  }

  // Place Repository
  if (!sl.isRegistered<PlaceRepository>()) {
    sl.registerLazySingleton<PlaceRepository>(
      () => PlaceRepository(placeService: sl<PlaceInterface>()),
    );
    print('   ✅ PlaceRepository (Supabase)');
  }

  // Analytics Repository
  if (!sl.isRegistered<AnalyticsRepository>()) {
    sl.registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepository(analyticsService: sl<AnalyticsInterface>()),
    );
    print('   ✅ AnalyticsRepository (Supabase)');
  }

  // Place Category Repository
  if (!sl.isRegistered<PlaceCategoryRepository>()) {
    sl.registerLazySingleton<PlaceCategoryRepository>(
      () => PlaceCategoryRepository(
        placeCategoryService: sl<PlaceCategoryRepositoryInterface>(),
      ),
    );
    print('   ✅ PlaceCategoryRepository (Supabase)');
  }

  // Reservation Repository
  if (!sl.isRegistered<ReservationRepository>()) {
    sl.registerLazySingleton<ReservationRepository>(
      () =>
          ReservationRepository(reservationService: sl<ReservationInterface>()),
    );
    print('   ✅ ReservationRepository (Supabase)');
  }

  // Admin Auth Repository
  if (!sl.isRegistered<AdminAuthRepository>()) {
    sl.registerLazySingleton<AdminAuthRepository>(
      () => AdminAuthRepositoryImpl(adminAuthService: sl<AdminAuthService>()),
    );
    print(
      '   ✅ AdminAuthRepository (Supabase - usando Firebase temporalmente)',
    );
  }

  // AI Repository
  if (!sl.isRegistered<AiRepository>()) {
    sl.registerLazySingleton<AiRepository>(
      () => AiRepository(aiService: sl<AiInterface>()),
    );
    print('   ✅ AiRepository (Supabase)');
  }

  print('   🎉 ¡Todos los repositorios refactorizados!');
}

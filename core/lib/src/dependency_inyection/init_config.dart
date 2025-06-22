import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

/// Initialize dependencies
Future<void> initCoreDependencies({
  required FirebaseApp firebaseApp,
  required GetIt sl,
}) async {
  // Register Firebase services only if they're not already registered
  if (!sl.isRegistered<FirebaseFirestore>()) {
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instanceFor(app: firebaseApp),
    );
  }

  if (!sl.isRegistered<FirebaseAuth>()) {
    sl.registerSingleton<FirebaseAuth>(
      FirebaseAuth.instanceFor(app: firebaseApp),
    );
  }

  // Register authorization interface with default implementation
  if (!sl.isRegistered<PlaceAuthorizationInterface>()) {
    sl.registerLazySingleton<PlaceAuthorizationInterface>(
      () => const DefaultPlaceAuthorization(),
    );
  }

  // Register services
  sl
    ..registerLazySingleton<EventService>(
      () => EventService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PlaceService>(
      () => PlaceService(
        firestore: sl<FirebaseFirestore>(),
        analyticsService: sl<AnalyticsService>(),
        authorization: sl<PlaceAuthorizationInterface>(),
      ),
    )
    ..registerLazySingleton<ReviewService>(
      () => ReviewService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<FavoriteService>(
      () => FavoriteService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(
        firestore: sl<FirebaseFirestore>(),
        firebaseAuth: sl<FirebaseAuth>(),
      ),
    )
    ..registerLazySingleton<AdminAuthService>(
      () => AdminAuthService(
        firestore: sl<FirebaseFirestore>(),
        firebaseAuth: sl<FirebaseAuth>(),
      ),
    )
    ..registerLazySingleton<CategoryService>(
      () => CategoryService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PlaceCategoryService>(
      () => PlaceCategoryService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<LocationService>(LocationService.new)
    ..registerLazySingleton<AnalyticsService>(
      () => AnalyticsService(firestore: sl<FirebaseFirestore>()),
    )
    // Register repositories
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(
        categoryService: sl<CategoryService>(),
        placeCategoryService: sl<PlaceCategoryService>(),
      ),
    )
    ..registerLazySingleton<EventRepository>(
      () => EventRepository(eventService: sl<EventService>()),
    )
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepository(favoriteService: sl<FavoriteService>()),
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepository(locationService: sl<LocationService>()),
    )
    ..registerLazySingleton<PlaceCategoryRepository>(() =>
        PlaceCategoryRepository(
            placeCategoryService: sl<PlaceCategoryService>()))
    ..registerLazySingleton<PlaceRepository>(
      () => PlaceRepository(placeService: sl<PlaceService>()),
    )
    ..registerLazySingleton<ReviewRepository>(
      () => ReviewRepository(reviewService: sl<ReviewService>()),
    )
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(authService: sl<AuthenticationService>()),
    )
    ..registerLazySingleton<AdminAuthRepository>(
      () => AdminAuthRepositoryImpl(adminAuthService: sl<AdminAuthService>()),
    )
    ..registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepository(analyticsService: sl<AnalyticsService>()),
    );
}

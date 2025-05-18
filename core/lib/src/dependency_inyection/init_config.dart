import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

/// Initialize dependencies
Future<void> initCoreDependencies({
  required FirebaseApp firebaseApp,
  required GetIt sl,
}) async {
  // Register services
  sl
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instanceFor(app: firebaseApp),
    )
    ..registerSingleton<FirebaseAuth>(
      FirebaseAuth.instanceFor(app: firebaseApp),
    )
    ..registerLazySingleton<EventService>(
      () => EventService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PlaceService>(
      () => PlaceService(firestore: sl<FirebaseFirestore>()),
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
    ..registerLazySingleton<CategoryService>(
      () => CategoryService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PlaceCategoryService>(
      () => PlaceCategoryService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<EventService>(
      () => EventService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<LocationService>(LocationService.new)
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
    ..registerLazySingleton<PlaceRepository>(
      () => PlaceRepository(placeService: sl<PlaceService>()),
    )
    ..registerLazySingleton<ReviewRepository>(
      () => ReviewRepository(reviewService: sl<ReviewService>()),
    )
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(authService: sl<AuthenticationService>()),
    );

  // Repeat for each service/repository
}

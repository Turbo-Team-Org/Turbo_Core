import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockTransaction extends Mock implements Transaction {}

class MockTimestamp extends Mock implements Timestamp {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDocumentReference());
  });
  late ReviewService reviewService;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockReviewsCollection;
  late MockCollectionReference mockPlacesCollection;
  late MockDocumentReference mockPlaceDoc;
  late MockDocumentReference mockReviewDoc;
  late MockQuerySnapshot mockReviewsSnapshot;
  late MockTransaction mockTransaction;
  late MockQueryDocumentSnapshot mockReviewSnapshot;
  late MockQuery mockQuery;
  late MockTimestamp mockTimestamp;
  late MockDocumentSnapshot mockDocSnapshot;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockReviewsCollection = MockCollectionReference();
    mockPlacesCollection = MockCollectionReference();
    mockPlaceDoc = MockDocumentReference();
    mockReviewDoc = MockDocumentReference();
    mockReviewsSnapshot = MockQuerySnapshot();
    mockTransaction = MockTransaction();
    mockReviewSnapshot = MockQueryDocumentSnapshot();
    mockQuery = MockQuery();
    mockTimestamp = MockTimestamp();
    mockDocSnapshot = MockDocumentSnapshot();

    reviewService = ReviewService(firestore: mockFirestore);

    when(
      () => mockFirestore.collection('reviews'),
    ).thenReturn(mockReviewsCollection);
    when(
      () => mockFirestore.collection('places'),
    ).thenReturn(mockPlacesCollection);
    when(() => mockFirestore.collectionGroup('reviews')).thenReturn(mockQuery);
    when(() => mockPlacesCollection.doc(any())).thenReturn(mockPlaceDoc);
    when(
      () => mockPlaceDoc.collection('reviews'),
    ).thenReturn(mockReviewsCollection);
    when(() => mockReviewsCollection.doc(any())).thenReturn(mockReviewDoc);
    when(() => mockTimestamp.toDate()).thenReturn(DateTime.now());
    when(
      () => mockDocSnapshot.data(),
    ).thenReturn({'reviews_count': 0, 'rating': 0.0});
  });

  group('ReviewService', () {
    const testPlaceId = 'test-place-id';
    const testReviewId = 'test-review-id';

    Map<String, dynamic> getTestReview() => {
      'id': testReviewId,
      'userId': 'test-user-id',
      'userName': 'Test User',
      'userAvatar': 'https://example.com/avatar.jpg',
      'comment': 'Test Review',
      'rating': 4.5,
      'date': mockTimestamp,
      'imageUrls': [],
    };

    test('getReviews success', () async {
      when(() => mockReviewSnapshot.data()).thenReturn(getTestReview());
      when(() => mockReviewsSnapshot.docs).thenReturn([mockReviewSnapshot]);
      // Mock para collectionGroup query
      when(() => mockQuery.get()).thenAnswer((_) async => mockReviewsSnapshot);

      final result = await reviewService.getReviews();

      print('Resultado de getReviews: $result'); // Log del resultado

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testReviewId));
      expect(result.first.userId, equals('test-user-id'));
    });

    // TODO: Fix transaction mocking - complex Firebase transaction mocking issue
    // The main functionality is tested in review_repository_test.dart
    /*
    test('addReview success', () async {
      final testReview = Review(
        id: testReviewId,
        userId: 'test-user-id',
        userName: 'Test User',
        userAvatar: 'https://example.com/avatar.jpg',
        comment: 'Test Review',
        rating: 4.5,
        date: DateTime.now(),
      );

      // Mock a successful transaction - just verify it's called
      when(() => mockFirestore.runTransaction(any())).thenAnswer((_) async => Future<void>.value());

      // Call the method and verify it returns the review ID
      final result = await reviewService.addReview(testReview, testPlaceId);

      // Verify that the method returns the review ID
      expect(result, equals(testReviewId));

      // Verify that runTransaction was called
      verify(() => mockFirestore.runTransaction(any())).called(1);

      print(
        'Test de addReview completado - verificado que retorna el ID: $result',
      ); // Log de la operación
    });
    */

    test('getAllReviews success with pagination', () async {
      // Preparar datos de prueba
      final testReviews = List.generate(
        5,
        (index) => {
          'id': 'review-$index',
          'userId': 'user-$index',
          'userName': 'User $index',
          'userAvatar': 'https://example.com/avatar$index.jpg',
          'comment': 'Test Review $index',
          'rating': 4.0 + (index * 0.2),
          'date': mockTimestamp,
          'imageUrls': [],
          'status': ReviewStatus.approved.value,
        },
      );

      final mockSnapshots =
          testReviews.map((data) {
            final mockSnapshot = MockQueryDocumentSnapshot();
            when(() => mockSnapshot.data()).thenReturn(data);
            when(() => mockSnapshot.id).thenReturn(data['id'] as String);
            return mockSnapshot;
          }).toList();

      // Mock para el conteo total
      when(() => mockReviewsSnapshot.docs).thenReturn(mockSnapshots);
      when(() => mockQuery.get()).thenAnswer((_) async => mockReviewsSnapshot);

      // Mock para la consulta con ordenamiento
      final mockOrderedQuery = MockQuery();
      when(
        () => mockQuery.orderBy('date', descending: true),
      ).thenReturn(mockOrderedQuery);

      // Mock para la consulta con límite
      final mockLimitedQuery = MockQuery();
      when(() => mockOrderedQuery.limit(any())).thenReturn(mockLimitedQuery);

      // Mock para el snapshot final con límite
      final mockLimitedSnapshot = MockQuerySnapshot();
      when(
        () => mockLimitedSnapshot.docs,
      ).thenReturn(mockSnapshots.take(2).toList());
      when(
        () => mockLimitedQuery.get(),
      ).thenAnswer((_) async => mockLimitedSnapshot);

      final result = await reviewService.getAllReviews(page: 1, limit: 2);

      expect(result, isA<PagedResult<Review>>());
      expect(result.items.length, equals(2));
      expect(result.totalCount, equals(5));
      expect(result.currentPage, equals(1));
      expect(result.pageSize, equals(2));
      expect(result.totalPages, equals(3));
      expect(result.hasNextPage, isTrue);
      expect(result.hasPreviousPage, isFalse);

      print('Test de getAllReviews completado exitosamente');
    });

    test('getAllReviews with status filter', () async {
      // Mock para consulta con filtro de estado
      final mockFilteredQuery = MockQuery();
      when(
        () => mockQuery.where('status', isEqualTo: ReviewStatus.approved.value),
      ).thenReturn(mockFilteredQuery);

      // Mock para el conteo con filtro
      when(
        () => mockFilteredQuery.get(),
      ).thenAnswer((_) async => mockReviewsSnapshot);
      when(() => mockReviewsSnapshot.docs).thenReturn([]);

      // Mock para ordenamiento
      when(
        () => mockFilteredQuery.orderBy('date', descending: true),
      ).thenReturn(mockFilteredQuery);

      // Mock para límite
      when(() => mockFilteredQuery.limit(any())).thenReturn(mockFilteredQuery);

      final result = await reviewService.getAllReviews(
        page: 1,
        limit: 20,
        status: ReviewStatus.approved,
      );

      expect(result, isA<PagedResult<Review>>());
      expect(result.items, isEmpty);
      expect(result.totalCount, equals(0));

      print('Test de getAllReviews con filtro de estado completado');
    });
  });
}

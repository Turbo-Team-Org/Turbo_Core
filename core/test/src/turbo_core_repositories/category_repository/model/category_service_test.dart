import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:core/src/turbo_core_repositories/category_repository/service/category_service.dart';
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

void main() {
  late CategoryService categoryService;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCategoriesCollection;
  late MockQuerySnapshot mockCategoriesSnapshot;
  late MockQueryDocumentSnapshot mockCategoryDoc;
  late MockQuery mockQuery;
  late MockDocumentReference mockDocRef;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCategoriesCollection = MockCollectionReference();
    mockCategoriesSnapshot = MockQuerySnapshot();
    mockCategoryDoc = MockQueryDocumentSnapshot();
    mockQuery = MockQuery();
    mockDocRef = MockDocumentReference();

    categoryService = CategoryService(firestore: mockFirestore);

    when(
      () => mockFirestore.collection('categories'),
    ).thenReturn(mockCategoriesCollection);
    when(
      () => mockCategoriesCollection.get(),
    ).thenAnswer((_) async => mockCategoriesSnapshot);
    when(() => mockCategoriesCollection.doc(any())).thenReturn(mockDocRef);
    when(
      () => mockCategoriesCollection.where(
        any(),
        isEqualTo: any(named: 'isEqualTo'),
      ),
    ).thenReturn(mockQuery);
    when(() => mockQuery.get()).thenAnswer((_) async => mockCategoriesSnapshot);
  });

  group('CategoryService', () {
    const testCategoryId = 'test-category-id';

    test('getAllCategories success', () async {
      final testCategory = {
        'id': testCategoryId,
        'name': 'Test Category',
        'icon': 'test_icon',
        'description': 'Test Description',
        'imageUrl': 'https://example.com/image.jpg',
        'placesCount': 5,
        'isFeatured': true,
        'metadata': {'key': 'value'},
      };

      when(() => mockCategoryDoc.data()).thenReturn(testCategory);
      when(() => mockCategoriesSnapshot.docs).thenReturn([mockCategoryDoc]);
      when(() => mockCategoryDoc.id).thenReturn(testCategoryId);

      final result = await categoryService.getAllCategories();

      print('Resultado de getAllCategories: $result');

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testCategoryId));
      expect(result.first.name, equals('Test Category'));
      expect(result.first.icon, equals('test_icon'));
    });

    test('getCategoryById success', () async {
      final testCategory = {
        'id': testCategoryId,
        'name': 'Test Category',
        'icon': 'test_icon',
        'description': 'Test Description',
        'imageUrl': 'https://example.com/image.jpg',
        'placesCount': 5,
        'isFeatured': true,
        'metadata': {'key': 'value'},
      };

      when(() => mockCategoryDoc.data()).thenReturn(testCategory);
      when(() => mockCategoryDoc.exists).thenReturn(true);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockCategoryDoc);
      when(() => mockCategoryDoc.id).thenReturn(testCategoryId);

      final result = await categoryService.getCategoryById(testCategoryId);

      print('Resultado de getCategoryById: $result');

      expect(result.id, equals(testCategoryId));
      expect(result.name, equals('Test Category'));
      expect(result.icon, equals('test_icon'));
    });

    test('getCategoryById not found', () async {
      when(() => mockCategoryDoc.exists).thenReturn(false);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockCategoryDoc);

      expect(
        () => categoryService.getCategoryById(testCategoryId),
        throwsException,
      );
    });

    test('addCategory success', () async {
      final testCategory = Category(
        id: testCategoryId,
        name: 'Test Category',
        icon: 'test_icon',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        placesCount: 5,
        isFeatured: true,
        metadata: {'key': 'value'},
      );

      when(() => mockDocRef.set(any())).thenAnswer((_) async => Future.value());

      await categoryService.addCategory(testCategory);

      print('Categoría añadida exitosamente: $testCategory');

      verify(() => mockDocRef.set(any())).called(1);
    });

    test('updateCategory success', () async {
      final testCategory = Category(
        id: testCategoryId,
        name: 'Test Category',
        icon: 'test_icon',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        placesCount: 5,
        isFeatured: true,
        metadata: {'key': 'value'},
      );

      when(
        () => mockDocRef.update(any()),
      ).thenAnswer((_) async => Future.value());

      await categoryService.updateCategory(testCategory);

      print('Categoría actualizada exitosamente: $testCategory');

      verify(() => mockDocRef.update(any())).called(1);
    });

    test('deleteCategory success', () async {
      when(() => mockDocRef.delete()).thenAnswer((_) async => Future.value());

      await categoryService.deleteCategory(testCategoryId);

      print('Categoría eliminada exitosamente: $testCategoryId');

      verify(() => mockDocRef.delete()).called(1);
    });
  });
}

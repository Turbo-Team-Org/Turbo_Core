import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthenticationService authenticationService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    authenticationService = AuthenticationService(
      firebaseAuth: mockFirebaseAuth,
      firestore: mockFirestore,
    );

    when(
      () => mockFirestore.collection('users'),
    ).thenReturn(mockCollectionReference);
    when(
      () => mockCollectionReference.doc(any()),
    ).thenReturn(mockDocumentReference);

    // Mock Google Sign In method channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/google_sign_in'),
          (MethodCall methodCall) async {
            switch (methodCall.method) {
              case 'init':
                return null;
              case 'signOut':
                return null;
              default:
                return null;
            }
          },
        );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/google_sign_in'),
          null,
        );
  });

  group('AuthenticationService', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testUid = 'test-uid';
    const testDisplayName = 'Test User';

    test('signInWithEmail success', () async {
      final mockUser = MockUser();
      final mockUserCredential = MockUserCredential();

      when(() => mockUser.uid).thenReturn(testUid);
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockUser.displayName).thenReturn(testDisplayName);
      when(() => mockUser.photoURL).thenReturn(null);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);
      when(() => mockDocumentSnapshot.exists).thenReturn(true);
      when(() => mockDocumentSnapshot.data()).thenReturn({
        'uid': testUid,
        'email': testEmail,
        'displayName': testDisplayName,
        'favorites': [],
        'createdAt': DateTime.now().toIso8601String(),
      });

      final result = await authenticationService.signInWithEmail(
        email: testEmail,
        password: testPassword,
      );

      expect(result, isNotNull);
      expect(result?.uid, equals(testUid));
      expect(result?.email, equals(testEmail));
      expect(result?.displayName, equals(testDisplayName));
    });

    test('signInWithEmail failure', () async {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenThrow(
        FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found for that email.',
        ),
      );

      expect(
        () => authenticationService.signInWithEmail(
          email: testEmail,
          password: testPassword,
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });

    test('signUpWithEmail success', () async {
      final mockUser = MockUser();
      final mockUserCredential = MockUserCredential();

      when(() => mockUser.uid).thenReturn(testUid);
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockUser.displayName).thenReturn(testDisplayName);
      when(() => mockUser.photoURL).thenReturn(null);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(
        () => mockDocumentReference.set(any()),
      ).thenAnswer((_) async => Future.value());

      final result = await authenticationService.signUpWithEmail(
        email: testEmail,
        password: testPassword,
        displayName: testDisplayName,
      );

      expect(result, isNotNull);
      expect(result?.uid, equals(testUid));
      expect(result?.email, equals(testEmail));
      expect(result?.displayName, equals(testDisplayName));
    });

    test('signOut success', () async {
      when(
        () => mockFirebaseAuth.signOut(),
      ).thenAnswer((_) async => Future.value());

      await expectLater(authenticationService.signOut(), completes);
    });
  });
}

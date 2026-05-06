import 'package:core/src/turbo_core_repositories/authentication_repository/authentication_repository.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/interface/authentication_interface.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationInterface {}

void main() {
  late AuthenticationRepository authRepository;
  late MockAuthenticationService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthenticationService();
    authRepository = AuthenticationRepository(authService: mockAuthService);
  });

  group('AuthenticationRepository', () {
    const testEmail = 'test@example.com';
    const testPassword = 'testPassword123';
    const testDisplayName = 'Test User';
    const testCurrentPassword = 'currentPassword123';
    const testNewPassword = 'newPassword123';

    final testAuthUser = AuthUser(
      uid: 'test-uid',
      email: testEmail,
      displayName: testDisplayName,
      photoUrl: 'https://example.com/photo.jpg',
      favorites: [],
      createdAt: DateTime(2024, 1, 1),
    );

    group('AUTHENTICATION Operations', () {
      test('signInWithEmail success', () async {
        // Arrange
        when(
          () => mockAuthService.signInWithEmail(
            email: testEmail,
            password: testPassword,
          ),
        ).thenAnswer((_) async => testAuthUser);

        // Act
        final result = await authRepository.signInWithEmail(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        expect(result, equals(testAuthUser));
        verify(
          () => mockAuthService.signInWithEmail(
            email: testEmail,
            password: testPassword,
          ),
        ).called(1);
      });

      test('signInWithEmail failure', () async {
        // Arrange
        when(
          () => mockAuthService.signInWithEmail(
            email: testEmail,
            password: testPassword,
          ),
        ).thenThrow(Exception('Authentication failed'));

        // Act & Assert
        expect(
          () => authRepository.signInWithEmail(
            email: testEmail,
            password: testPassword,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al iniciar sesión con email'),
            ),
          ),
        );
      });

      test('signInWithGoogle success', () async {
        // Arrange
        when(
          () => mockAuthService.signInWithGoogle(),
        ).thenAnswer((_) async => testAuthUser);

        // Act
        final result = await authRepository.signInWithGoogle();

        // Assert
        expect(result, equals(testAuthUser));
        verify(() => mockAuthService.signInWithGoogle()).called(1);
      });

      test('signInWithGoogle failure', () async {
        // Arrange
        when(
          () => mockAuthService.signInWithGoogle(),
        ).thenThrow(Exception('Google sign-in failed'));

        // Act & Assert
        expect(
          () => authRepository.signInWithGoogle(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al iniciar sesión con Google'),
            ),
          ),
        );
      });

      test('signUpWithEmail success', () async {
        // Arrange
        when(
          () => mockAuthService.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: testDisplayName,
          ),
        ).thenAnswer((_) async => testAuthUser);

        // Act
        final result = await authRepository.signUpWithEmail(
          email: testEmail,
          password: testPassword,
          displayName: testDisplayName,
        );

        // Assert
        expect(result, equals(testAuthUser));
        verify(
          () => mockAuthService.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: testDisplayName,
          ),
        ).called(1);
      });

      test('signUpWithEmail without displayName', () async {
        // Arrange
        when(
          () => mockAuthService.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: null,
          ),
        ).thenAnswer((_) async => testAuthUser);

        // Act
        final result = await authRepository.signUpWithEmail(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        expect(result, equals(testAuthUser));
        verify(
          () => mockAuthService.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: null,
          ),
        ).called(1);
      });

      test('signUpWithEmail failure', () async {
        // Arrange
        when(
          () => mockAuthService.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: testDisplayName,
          ),
        ).thenThrow(Exception('Registration failed'));

        // Act & Assert
        expect(
          () => authRepository.signUpWithEmail(
            email: testEmail,
            password: testPassword,
            displayName: testDisplayName,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al registrar usuario'),
            ),
          ),
        );
      });

      test('signOut success', () async {
        // Arrange
        when(() => mockAuthService.signOut()).thenAnswer((_) async {});

        // Act
        await authRepository.signOut();

        // Assert
        verify(() => mockAuthService.signOut()).called(1);
      });

      test('signOut failure', () async {
        // Arrange
        when(
          () => mockAuthService.signOut(),
        ).thenThrow(Exception('Sign out failed'));

        // Act & Assert
        expect(
          () => authRepository.signOut(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al cerrar sesión'),
            ),
          ),
        );
      });
    });

    group('PASSWORD Operations', () {
      test('changePassword success', () async {
        // Arrange
        when(
          () => mockAuthService.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: testNewPassword,
          ),
        ).thenAnswer((_) async {});

        // Act
        await authRepository.changePassword(
          currentPassword: testCurrentPassword,
          newPassword: testNewPassword,
        );

        // Assert
        verify(
          () => mockAuthService.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: testNewPassword,
          ),
        ).called(1);
      });

      test('changePassword with weak password', () async {
        // Arrange
        const weakPassword = '123';

        // Act & Assert
        expect(
          () => authRepository.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: weakPassword,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('La contraseña debe tener al menos 6 caracteres'),
            ),
          ),
        );

        verifyNever(
          () => mockAuthService.changePassword(
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        );
      });

      test('changePassword with too long password', () async {
        // Arrange
        final tooLongPassword = 'a' * 129;

        // Act & Assert
        expect(
          () => authRepository.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: tooLongPassword,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('La contraseña no puede tener más de 128 caracteres'),
            ),
          ),
        );

        verifyNever(
          () => mockAuthService.changePassword(
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        );
      });

      test('changePassword service failure', () async {
        // Arrange
        when(
          () => mockAuthService.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: testNewPassword,
          ),
        ).thenThrow(Exception('Password change failed'));

        // Act & Assert
        expect(
          () => authRepository.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: testNewPassword,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al cambiar contraseña'),
            ),
          ),
        );
      });

      test('sendPasswordResetEmail success', () async {
        // Arrange
        when(
          () => mockAuthService.sendPasswordResetEmail(email: testEmail),
        ).thenAnswer((_) async {});

        // Act
        await authRepository.sendPasswordResetEmail(email: testEmail);

        // Assert
        verify(
          () => mockAuthService.sendPasswordResetEmail(email: testEmail),
        ).called(1);
      });

      test('sendPasswordResetEmail with invalid email format', () async {
        // Arrange
        const invalidEmail = 'invalid-email';

        // Act & Assert
        expect(
          () => authRepository.sendPasswordResetEmail(email: invalidEmail),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('El formato del email es inválido'),
            ),
          ),
        );

        verifyNever(
          () => mockAuthService.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        );
      });

      test('sendPasswordResetEmail service failure', () async {
        // Arrange
        when(
          () => mockAuthService.sendPasswordResetEmail(email: testEmail),
        ).thenThrow(Exception('Reset email failed'));

        // Act & Assert
        expect(
          () => authRepository.sendPasswordResetEmail(email: testEmail),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al enviar email de recuperación'),
            ),
          ),
        );
      });
    });

    group('STATE Operations', () {
      test('authStateChanges returns stream', () {
        // Arrange
        final authStream = Stream<AuthUser?>.value(testAuthUser);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = authRepository.authStateChanges;

        // Assert
        expect(result, equals(authStream));
        verify(() => mockAuthService.authStateChanges).called(1);
      });
    });

    group('UTILITY Operations', () {
      test('getCurrentUser success', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(testAuthUser);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = await authRepository.getCurrentUser();

        // Assert
        expect(result, equals(testAuthUser));
      });

      test('getCurrentUser returns null when not authenticated', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(null);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = await authRepository.getCurrentUser();

        // Assert
        expect(result, isNull);
      });

      test('getCurrentUser handles stream error', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.error(Exception('Stream error'));
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act & Assert
        expect(
          () => authRepository.getCurrentUser(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener usuario actual'),
            ),
          ),
        );
      });

      test('isAuthenticated returns true when user exists', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(testAuthUser);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = await authRepository.isAuthenticated();

        // Assert
        expect(result, isTrue);
      });

      test('isAuthenticated returns false when user is null', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(null);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = await authRepository.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });

      test('isAuthenticated returns false on error', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.error(Exception('Stream error'));
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act
        final result = await authRepository.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });

      test('updateDisplayName delegates to updateUserProfile', () async {
        when(
          () => mockAuthService.updateUserProfile(
            displayName: any(named: 'displayName'),
            photoUrl: any(named: 'photoUrl'),
          ),
        ).thenAnswer((_) async => testAuthUser);

        await authRepository.updateDisplayName('New Name');

        verify(
          () => mockAuthService.updateUserProfile(
            displayName: 'New Name',
            photoUrl: null,
          ),
        ).called(1);
      });

      test('updateDisplayName propagates service errors', () async {
        when(
          () => mockAuthService.updateUserProfile(
            displayName: any(named: 'displayName'),
            photoUrl: any(named: 'photoUrl'),
          ),
        ).thenThrow(Exception('fail'));

        expect(
          () => authRepository.updateDisplayName('New Name'),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al actualizar nombre'),
            ),
          ),
        );
      });

      test('getCurrentProfile delegates to authService', () async {
        when(() => mockAuthService.getCurrentProfile()).thenAnswer(
          (_) async => testAuthUser,
        );

        final result = await authRepository.getCurrentProfile();

        expect(result, equals(testAuthUser));
        verify(() => mockAuthService.getCurrentProfile()).called(1);
      });

      test('updateUserProfile delegates to authService', () async {
        when(
          () => mockAuthService.updateUserProfile(
            displayName: any(named: 'displayName'),
            photoUrl: any(named: 'photoUrl'),
          ),
        ).thenAnswer((_) async => testAuthUser);

        final result = await authRepository.updateUserProfile(
          displayName: 'X',
          photoUrl: 'https://x/y.png',
        );

        expect(result, equals(testAuthUser));
        verify(
          () => mockAuthService.updateUserProfile(
            displayName: 'X',
            photoUrl: 'https://x/y.png',
          ),
        ).called(1);
      });

      test('deleteAccount throws not implemented', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(testAuthUser);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act & Assert
        expect(
          () => authRepository.deleteAccount(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Eliminación de cuenta no implementada aún'),
            ),
          ),
        );
      });

      test('deleteAccount throws when no user authenticated', () async {
        // Arrange
        final authStream = Stream<AuthUser?>.value(null);
        when(
          () => mockAuthService.authStateChanges,
        ).thenAnswer((_) => authStream);

        // Act & Assert
        expect(
          () => authRepository.deleteAccount(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('No hay usuario autenticado'),
            ),
          ),
        );
      });
    });

    group('LEGACY Methods', () {
      test('sigInWithGoogle (deprecated) works', () async {
        // Arrange
        when(
          () => mockAuthService.signInWithGoogle(),
        ).thenAnswer((_) async => testAuthUser);

        // Act
        // ignore: deprecated_member_use_from_same_package
        final result = await authRepository.sigInWithGoogle();

        // Assert
        expect(result, equals(testAuthUser));
        verify(() => mockAuthService.signInWithGoogle()).called(1);
      });

      test('logOut (deprecated) works', () async {
        // Arrange
        when(() => mockAuthService.signOut()).thenAnswer((_) async {});

        // Act
        // ignore: deprecated_member_use_from_same_package
        await authRepository.logOut();

        // Assert
        verify(() => mockAuthService.signOut()).called(1);
      });
    });

    group('VALIDATION Methods', () {
      test('valid email formats pass validation', () async {
        // Arrange
        const validEmails = [
          'test@example.com',
          'user.name@domain.co.uk',
          'test123@test-domain.org',
        ];

        when(
          () => mockAuthService.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async {});

        // Act & Assert
        for (final email in validEmails) {
          await authRepository.sendPasswordResetEmail(email: email);
          verify(
            () => mockAuthService.sendPasswordResetEmail(email: email),
          ).called(1);
        }
      });

      test('invalid email formats fail validation', () {
        // Arrange
        const invalidEmails = [
          'invalid-email',
          '@domain.com',
          'test@',
          'test.domain.com',
          '',
        ];

        // Act & Assert
        for (final email in invalidEmails) {
          expect(
            () => authRepository.sendPasswordResetEmail(email: email),
            throwsA(
              isA<Exception>().having(
                (e) => e.toString(),
                'message',
                contains('El formato del email es inválido'),
              ),
            ),
          );
        }

        verifyNever(
          () => mockAuthService.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        );
      });

      test('valid password lengths pass validation', () async {
        // Arrange
        final validPasswords = [
          'password123',
          '123456',
          'a' * 128, // Maximum length
        ];

        when(
          () => mockAuthService.changePassword(
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer((_) async {});

        // Act & Assert
        for (final password in validPasswords) {
          await authRepository.changePassword(
            currentPassword: testCurrentPassword,
            newPassword: password,
          );
          verify(
            () => mockAuthService.changePassword(
              currentPassword: testCurrentPassword,
              newPassword: password,
            ),
          ).called(1);
        }
      });

      test('invalid password lengths fail validation', () {
        // Arrange
        final invalidPasswords = [
          '', // Empty
          '12345', // Too short
          'a' * 129, // Too long
        ];

        // Act & Assert
        for (final password in invalidPasswords) {
          expect(
            () => authRepository.changePassword(
              currentPassword: testCurrentPassword,
              newPassword: password,
            ),
            throwsA(isA<Exception>()),
          );
        }

        verifyNever(
          () => mockAuthService.changePassword(
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        );
      });
    });
  });
}

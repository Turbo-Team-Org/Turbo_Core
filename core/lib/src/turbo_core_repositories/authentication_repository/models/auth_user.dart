import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_role.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Auth user model
@freezed
sealed class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String email,
    required DateTime createdAt,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    String? authProvider,
    @Default([]) List<int> favorites,
    @Default(UserRole.regular) UserRole role,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

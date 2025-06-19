// ignore_for_file: public_member_api_docs

import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';

/// 📊 Estadísticas de usuarios administrativos
class AdminUsersStats {
  const AdminUsersStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.placeOwners,
    required this.superAdmins,
    required this.usersCreatedThisMonth,
    required this.lastLoginStats,
  }); // 'today', 'week', 'month', 'older'

  factory AdminUsersStats.fromUsers(List<AdminUser> users) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfDay = DateTime(now.year, now.month, now.day);

    var usersCreatedThisMonth = 0;
    var todayLogins = 0;
    var weekLogins = 0;
    var monthLogins = 0;
    var olderLogins = 0;

    for (final user in users) {
      // Contar usuarios creados este mes
      if (user.createdAt.isAfter(startOfMonth)) {
        usersCreatedThisMonth++;
      }

      // Contar últimos logins
      final lastLogin = user.lastLogin;
      if (lastLogin != null) {
        if (lastLogin.isAfter(startOfDay)) {
          todayLogins++;
        } else if (lastLogin.isAfter(startOfWeek)) {
          weekLogins++;
        } else if (lastLogin.isAfter(startOfMonth)) {
          monthLogins++;
        } else {
          olderLogins++;
        }
      }
    }

    return AdminUsersStats(
      totalUsers: users.length,
      activeUsers: users.where((u) => u.isActive).length,
      placeOwners: users.where((u) => u.role == AdminRole.placeOwner).length,
      superAdmins: users.where((u) => u.role == AdminRole.superAdmin).length,
      usersCreatedThisMonth: usersCreatedThisMonth,
      lastLoginStats: {
        'today': todayLogins,
        'week': weekLogins,
        'month': monthLogins,
        'older': olderLogins,
      },
    );
  }

  final int totalUsers;
  final int activeUsers;
  final int placeOwners;
  final int superAdmins;
  final int usersCreatedThisMonth;
  final Map<String, int> lastLoginStats;
}

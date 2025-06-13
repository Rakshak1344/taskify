import 'package:app/features/auth/navigation/auth_route_names.dart';
import 'package:app/features/dashboard/navigation/dashboard_route_names.dart';

class AppRouteName {
  static const String root = 'root';
  static const AuthRouteNames auth = AuthRouteNames();
  static const DashboardRouteNames dashboard = DashboardRouteNames();

  static const String underMaintenance = "underMaintenance";
  static const String forceUpdate = "forceUpdate";
}

import 'package:app/features/dashboard/views/home_page.dart';
import 'package:app/features/dashboard/views/profile_page.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/app_config.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardRoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: 'home',
        name: AppRouteName.dashboard.home,
        builder: (BuildContext context, GoRouterState state) => HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            parentNavigatorKey: AppConfig.navigatorKey,
            name: AppRouteName.dashboard.profile,
            builder:
                (BuildContext context, GoRouterState state) => ProfilePage(),
          ),
        ],
      ),
    ];
  }
}

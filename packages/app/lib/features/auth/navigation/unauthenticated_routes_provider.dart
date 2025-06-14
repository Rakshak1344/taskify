import 'package:app/features/auth/navigation/middlewares/intro_viewed_navigation_middleware.dart';
import 'package:app/features/auth/views/intro_page.dart';
import 'package:app/features/auth/views/login_signup_page.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnauthenticatedRoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/intro',
        name: AppRouteName.auth.intro,
        builder:
            (BuildContext context, GoRouterState state) => const IntroPage(),
      ),
      GoRoute(
        path: '/login-signup',
        name: AppRouteName.auth.loginSignUp,
        redirect: IntroViewedNavigationMiddleware().call,
        builder:
            (BuildContext context, GoRouterState state) =>
                const LoginSignupPage(),
      ),
    ];
  }
}

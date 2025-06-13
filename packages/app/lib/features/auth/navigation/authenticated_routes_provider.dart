import 'package:app/features/dashboard/navigation/dashboard_route_provider.dart';
import 'package:app/features/dashboard/navigation/middlewares/authenticated_root_navigation_middleware.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/app_config.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthenticatedRoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/',
        name: AppRouteName.root,
        redirect: (context, state) {
          var ref = ProviderScope.containerOf(context);
          var isIntroViewed =
              ref
                  .read(preferenceProvider)
                  .getValue(PreferenceKeys.isIntroViewed) ??
              false;

          if (isIntroViewed) {
            return state.namedLocation(AppRouteName.auth.loginSignUp);
          }
          return state.namedLocation(AppRouteName.auth.intro);
        },
        // redirect: AuthenticatedRootNavigationMiddleware().call,
        routes: [...DashboardRoutesProvider().routes()],
      ),
    ];
  }
}

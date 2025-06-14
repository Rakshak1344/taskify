import 'package:app/features/dashboard/navigation/dashboard_route_provider.dart';
import 'package:app/features/dashboard/navigation/middlewares/authenticated_root_navigation_middleware.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:go_router/go_router.dart';

class AuthenticatedRoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/',
        name: AppRouteName.root,
        redirect: AuthenticatedRootNavigationMiddleware().call,
        routes: [...DashboardRoutesProvider().routes()],
      ),
    ];
  }
}

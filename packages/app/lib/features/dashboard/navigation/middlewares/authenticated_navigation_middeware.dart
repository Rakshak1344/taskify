import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/navigation/middlewares/navigation_middleware.dart';

class AuthenticatedNavigationMiddleware extends NavigationMiddleware {
  @override
  String? onRedirect() {
    /// TODO: Uncomment and implement user authentication check
    // var user = ref.read(userStateProvider).value;
    //
    // if (user == null) {
    //   return namedLocation(AppRouteName.auth.loginSignUp);
    // }

    // if (state.uri.toString() == namedLocation(AppRouteName.root)) {
    //   return namedLocation(AppRouteName.dashboard.home);
    // }

    return null;
  }
}

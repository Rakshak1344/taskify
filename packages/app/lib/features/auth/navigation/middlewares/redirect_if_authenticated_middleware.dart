import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/navigation/middlewares/navigation_middleware.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:app/navigation/app_route_name.dart';


class RedirectIfAuthenticatedNavigationMiddleware extends NavigationMiddleware {
  @override
  String? onRedirect() {
    var pref = ref.read(preferenceProvider);
    var accessToken = pref.getValue(PreferenceKeys.accessToken);

    if (accessToken != null) {
      return namedLocation(AppRouteName.dashboard.home);
    }

    return null;
  }
}

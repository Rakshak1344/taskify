import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/navigation/middlewares/navigation_middleware.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:app/navigation/app_route_name.dart';

class IntroViewedNavigationMiddleware extends NavigationMiddleware {
  @override
  String? onRedirect() {
    var pref = ref.read(preferenceProvider);

    var isIntroViewed = pref.getValue(
      PreferenceKeys.isIntroViewed,
      defaultValue: false,
    );

    if (isIntroViewed != true) {
      return namedLocation(AppRouteName.auth.intro);
    }

    return null;
  }
}

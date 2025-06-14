import 'package:app/features/dashboard/navigation/middlewares/authenticated_navigation_middeware.dart';
import 'package:core/arch/navigation/middlewares/navigation_middleware.dart';
import 'package:core/arch/navigation/middlewares/multiple_navigation_middleware.dart';

class AuthenticatedRootNavigationMiddleware extends NavigationMiddleware {
  @override
  String? onRedirect() => MultipleNavigationMiddleware([
    AuthenticatedNavigationMiddleware(),
    // Can add multiple middlewares here if needed
    // OnBoardingCompletionNavigationMiddleware(),
  ]).call(context, state);
}

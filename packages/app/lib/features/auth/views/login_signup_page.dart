import 'package:app/features/auth/views/state/user_state.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:core/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginSignupPage extends ConsumerStatefulWidget {
  const LoginSignupPage({super.key});

  @override
  ConsumerState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends ConsumerState<LoginSignupPage> {
  void watchUserState() {
    ref.listen(userStateProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        context.goNamed(AppRouteName.root);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    watchUserState();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Intro viewed: ${ref.read(preferenceProvider).getValue(PreferenceKeys.isIntroViewed).toString()}",
              ),
            ),
            SizedBox(height: 20),
            ref
                .watch(userStateProvider)
                .maybeWhen(
                  loading: context.buildLoadingIndicator,
                  orElse: () {
                    return ElevatedButton(
                      onPressed: _signInWithGoogle,
                      child: Text("Google SignIn"),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle() {
    ref.read(userStateProvider.notifier).authenticateViaGoogle();
  }
}

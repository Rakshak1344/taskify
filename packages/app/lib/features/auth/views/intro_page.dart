import 'package:app/navigation/app_route_name.dart';
import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends ConsumerStatefulWidget {
  const IntroPage({super.key});

  @override
  ConsumerState createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to Taskify",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Intro viewed: ${ref.read(preferenceProvider).getValue(PreferenceKeys.isIntroViewed).toString()}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _onContinueTap,
              label: Text("Continue"),
              icon: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinueTap() {
    ref.read(preferenceProvider).setValue(PreferenceKeys.isIntroViewed, true);
    context.goNamed(AppRouteName.auth.loginSignUp);
  }
}

import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginSignupPage extends ConsumerStatefulWidget {
  const LoginSignupPage({super.key});

  @override
  ConsumerState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends ConsumerState<LoginSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                "Intro viewed: ${ref.read(preferenceProvider).getValue(PreferenceKeys.isIntroViewed).toString()}",
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Google SignIn")),
          ],
        ),
      ),
    );
  }
}

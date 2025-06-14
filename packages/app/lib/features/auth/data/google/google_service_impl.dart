import 'dart:developer';

import 'package:app/config/env.dart';
import 'package:app/features/auth/data/google/google_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServiceImpl extends GoogleService {
  final Ref ref;

  GoogleServiceImpl(this.ref);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // serverClientId: !kIsWeb ? Env.googleServerClientId : null,
    clientId: kIsWeb ? Env.googleWebClientId : null,
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/user.birthday.read',
    ],
  );

  @override
  Future<fb.User?> signIn() async {
    try {
      // TODO: should remove signOut() later, need to check status of this
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credentials = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredentials = await fb.FirebaseAuth.instance
          .signInWithCredential(credentials);

      return userCredentials.user!;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await fb.FirebaseAuth.instance.signOut();
  }
}

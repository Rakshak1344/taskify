import 'package:app/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

extension FirebaseUserMapper on fb.User {
  User? toUser() {
    return User(
      uid: uid,
      email: email ?? '',
      displayName: displayName ?? '',
      photoUrl: photoURL,
    );
  }
}

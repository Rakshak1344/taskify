import 'package:app/features/auth/data/google/google_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_service.g.dart';

@riverpod
GoogleService googleService(Ref ref) => GoogleServiceImpl(ref);

abstract class GoogleService {
  // Gives back the firebase idToken
  FutureOr<fb.User?> signIn();

  // Sign out
  Future<void> signOut();
}

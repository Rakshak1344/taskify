import 'package:app/features/auth/data/extension/firebase_user_ext.dart';
import 'package:app/features/auth/data/google/google_service.dart';
import 'package:app/features/auth/data/models/user.dart';
import 'package:app/features/auth/data/repositories/local_user_repository.dart';
import 'package:app/storage/preference_keys.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

@riverpod
UserService userService(Ref ref) {
  return UserService(ref);
}

class UserService {
  final Ref ref;

  final GoogleService _googleService;
  final LocalUserRepository _localUserRepository;

  UserService(this.ref)
    : _googleService = ref.read(googleServiceProvider),
      _localUserRepository = ref.read(localUserRepositoryProvider);

  Stream<User?> watch() => _localUserRepository.watch();

  Future<void> signInWithGoogle() async {
    fb.User? firebaseUser = await _googleService.signIn();
    await save(firebaseUser?.toUser());
  }

  Future<void> save(User? user) async {
    await _localUserRepository.save(user);
  }

  void signOut() {
    ref.read(preferenceProvider).setValue(PreferenceKeys.isIntroViewed, false);
    _googleService.signOut();
    _localUserRepository.save(null);
  }
}

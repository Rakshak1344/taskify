import 'package:app/features/auth/data/extension/firebase_user_ext.dart';
import 'package:app/features/auth/data/google/google_service.dart';
import 'package:app/features/auth/data/models/user.dart';
import 'package:app/features/auth/data/services/user_service.dart';
import 'package:core/arch/exception/exception_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

part 'user_state.g.dart';

@riverpod
class UserState extends _$UserState {
  UserService get _userService => ref.read(userServiceProvider);

  GoogleService get _googleService => ref.read(googleServiceProvider);

  ExceptionAdapter get _exceptionAdapter => ref.read(exceptionAdapterProvider);

  @override
  Stream<User?> build() => _userService.watch();

  Future<void> authenticateViaGoogle() async {
    await _exceptionAdapter
        .run(() async {
          fb.User? firebaseUser = await _googleService.signIn();
          state = const AsyncValue<User?>.loading();
          await Future.delayed(Duration(seconds: 4), () async {
            await _userService.save(firebaseUser?.toUser());
          });
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  void logout() async {
    state = const AsyncValue<User?>.loading();
    await Future.delayed(Duration(seconds: 4), () async {
      await _userService.signOut();
    });
    state = const AsyncData(null);
  }
}

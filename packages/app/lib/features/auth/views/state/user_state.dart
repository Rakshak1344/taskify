import 'package:app/features/auth/data/models/user.dart';

import 'package:app/features/auth/data/services/user_service.dart';

import 'package:core/utils/logger.dart';
import 'package:core/arch/exception/exception_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state.g.dart';

@riverpod
class UserState extends _$UserState {
  UserService get _userService => ref.read(userServiceProvider);

  ExceptionAdapter get _exceptionAdapter => ref.read(exceptionAdapterProvider);

  @override
  Stream<User?> build() => _userService.watch();

  Future<void> authenticateViaGoogle() async {
    await _exceptionAdapter
        .run(() async {
          await _userService.signInWithGoogle();
        })
        .catchError((e, st) {
          log(st);
          state = AsyncError(e, st);
        });
  }

  void logout() => _userService.signOut();
}

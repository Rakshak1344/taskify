import 'dart:async';
import 'dart:convert';

import 'package:app/features/auth/data/models/user.dart';
import 'package:core/arch/repository.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_user_repository.g.dart';

@riverpod
LocalUserRepository localUserRepository(Ref ref) => LocalUserRepository(ref);

class LocalUserRepository extends ObjectRepository<User> {
  LocalUserRepository(this.ref);

  final Ref ref;

  Preferences get sharedPreferences => ref.read(preferenceProvider);

  final StreamController<User?> _controller = StreamController<User?>();

  @override
  Future<void> save(User? data) {
    if (data == null) {
      return sharedPreferences.remove('user');
    }

    return sharedPreferences.setValue('user', json.encode(data.toJson()));
  }

  @override
  Stream<User?> watch() {
    sharedPreferences
        .watchValue<String?>('user')
        .listen(updateUserToController);

    _controller.add(get());

    return _controller.stream;
  }

  void updateUserToController(String? userString) {
    if (userString == null) {
      _controller.add(null);

      return;
    }

    var user = User.fromJson(json.decode(userString));
    _controller.add(user);
  }

  @override
  User? get() {
    var userString = sharedPreferences.getValue<String?>('user');
    if (userString == null) {
      return null;
    }

    return User.fromJson(json.decode(userString));
  }

  @override
  Future<void> delete() async {
    await sharedPreferences.remove('user');
  }
}

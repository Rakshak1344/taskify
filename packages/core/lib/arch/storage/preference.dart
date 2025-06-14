import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preference.g.dart';

@riverpod
Preferences preference(Ref ref) => throw UnimplementedError();

abstract class Preferences {
  T? getValue<T>(String key, {T? defaultValue});

  Future<void> setValue<T>(String key, T value);

  Stream<T?> watchValue<T>(String key);

  Future<void> clear();

  Future<void> remove(String key);
}

import 'dart:convert';

import 'package:app/storage/box_name.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:core/arch/storage/preference.dart';

class HivePreference extends Preferences {
  static final String _preferencesBox = BoxName.preferences;
  final Box<dynamic> _box;

  static HivePreference? _preference;

  HivePreference._(this._box);

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HivePreference> getInstance() async {
    if (_preference != null) {
      return _preference!;
    }

    const secureStorage = FlutterSecureStorage();
    var encryptionKey = await secureStorage.read(key: 'encryptionKey');
    if (encryptionKey == null) {
      final key = Hive.generateSecureKey();
      encryptionKey = base64Url.encode(key);
      await secureStorage.write(key: 'encryptionKey', value: encryptionKey);
    }
    final key = base64Url.decode(encryptionKey);

    final box = await Hive.openBox<dynamic>(
      _preferencesBox,
      encryptionCipher: HiveAesCipher(key),
    );
    await box.flush();

    _preference = HivePreference._(box);

    return _preference!;
  }

  @override
  T? getValue<T>(String key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T?;

  @override
  Stream<T?> watchValue<T>(String key) {
    return _box.watch(key: key).map((BoxEvent event) => getValue(key));
  }

  @override
  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  @override
  Future<void> clear() async {
    await _box.deleteAll(_box.keys);
  }

  @override
  Future<void> remove(String key) {
    return _box.delete(key);
  }
}

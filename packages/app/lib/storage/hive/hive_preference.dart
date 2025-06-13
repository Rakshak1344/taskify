import 'dart:convert';

import 'package:app/storage/box_name.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';

class HivePreference extends Preferences {
  static final String _preferencesBox = BoxName.preferences;
  final Box<dynamic> _box;

  static HivePreference? _preference;

  HivePreference._(this._box);

  // The logic here is sound and works perfectly with hive_ce.
  // It ensures the box is open and encrypted before use.
  static Future<HivePreference> getInstance() async {
    if (_preference != null) {
      return _preference!;
    }

    const secureStorage = FlutterSecureStorage();
    var encryptionKeyString = await secureStorage.read(key: 'encryptionKey');
    late final List<int> encryptionKey;

    if (encryptionKeyString == null) {
      // If no key exists, generate a new one
      final newKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'encryptionKey',
        value: base64Url.encode(newKey), // Store the new key
      );
      encryptionKey = newKey;
    } else {
      // If a key exists, decode it
      encryptionKey = base64Url.decode(encryptionKeyString);
    }

    // Open the box with the encryption key
    final box = await Hive.openBox<dynamic>(
      _preferencesBox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    // The flush() call here is generally not needed unless you need to
    // guarantee writes are on disk immediately after opening. You can often remove it.
    // await box.flush();

    _preference = HivePreference._(box);
    return _preference!;
  }

  @override
  T? getValue<T>(String key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T?;

  @override
  Stream<T?> watchValue<T>(String key) {
    return _box
        .watch(key: key)
        .map(
          (BoxEvent event) => event.value as T?, // A more direct mapping
        );
  }

  @override
  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  @override
  Future<void> clear() => _box.clear(); // .clear() is more efficient than .deleteAll(keys)

  @override
  Future<void> remove(String key) => _box.delete(key);
}

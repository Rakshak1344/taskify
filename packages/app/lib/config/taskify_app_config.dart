import 'dart:async';

import 'package:app/storage/hive/hive_helper.dart';
import 'package:app/storage/hive/hive_preference.dart';
import 'package:core/arch/app_config.dart';
import 'package:app/firebase_options.dart';
import 'package:app/config/state_observer.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskifyAppConfig extends AppConfig {
  late HivePreference hivePreferencesInstance;

  @override
  Future<void> initDependencies() async {
    await HiveHelper.init();
    hivePreferencesInstance = await HivePreference.getInstance();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  FutureOr<List<Override>> overrides() {
    return [preferenceProvider.overrideWithValue(hivePreferencesInstance)];
  }

  @override
  FutureOr<List<ProviderObserver>> observers() {
    return [StateObserver()];
  }

  @override
  FutureOr<Widget> onInit({required Widget child}) {
    return child;
  }
}

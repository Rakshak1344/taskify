import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueStateExt on BuildContext {
  bool didFinishLoading<T>(AsyncValue<T>? previous, AsyncValue<T> next) =>
      previous?.isLoading == true && !next.isLoading;

  bool didStateGetNewData<T>(
    AsyncValue<T>? previous,
    AsyncValue<T> next, {
    bool checkWithPrev = false,
  }) {
    if (checkWithPrev) {
      return didFinishLoading<T>(previous, next) &&
          next.hasValue &&
          previous?.value != next.value;
    }

    return didFinishLoading<T>(previous, next) && next.hasValue;
  }

  bool didStateGetNewError<T>(AsyncValue<T>? previous, AsyncValue<T> next) =>
      didFinishLoading<T>(previous, next) && next.hasError;

  bool didNewErrorOccur<T>(AsyncValue<T>? previous, AsyncValue<T> next) {
    if (previous?.error == next.error) {
      return false;
    }

    if (next.error == null) {
      return false;
    }

    return true;
  }
}

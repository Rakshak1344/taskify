import 'package:flutter/material.dart';

extension SnackbarExtensions on BuildContext {
  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

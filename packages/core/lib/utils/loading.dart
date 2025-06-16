import 'package:flutter/material.dart';

extension LoadingIndicatorExtensions on BuildContext {
  Widget buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }

  void showLoadingIndicator() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => buildLoadingIndicator(),
    );
  }
}

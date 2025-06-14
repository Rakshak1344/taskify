import 'package:app/loading_page.dart';
import 'package:app/taskify_app.dart';
import 'package:app/config/taskify_app_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoadingPage());

  TaskifyAppConfig()
      .init(child: const TaskifyApp())
      .then((widget) => runApp(widget));
}

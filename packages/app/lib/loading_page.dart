import 'package:core/ui/app_theme.dart';
import 'package:core/utils/loading.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: context.buildLoadingIndicator()),
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Taskify',
    );
  }
}

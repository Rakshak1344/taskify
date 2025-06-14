import 'package:core/ui/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Taskify',
    );
  }
}

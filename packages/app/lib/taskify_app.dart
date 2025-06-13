import 'package:app/navigation/app_router.dart';
import 'package:core/ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskifyApp extends ConsumerStatefulWidget {
  const TaskifyApp({super.key});

  @override
  ConsumerState createState() => _SocialItAppState();
}

class _SocialItAppState extends ConsumerState<TaskifyApp> {
  @override
  Widget build(BuildContext context) {
    var goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Taskify",
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: goRouter,
    );
  }
}

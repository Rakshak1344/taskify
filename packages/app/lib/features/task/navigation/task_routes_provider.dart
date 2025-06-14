import 'package:app/features/task/views/create_task_page.dart';
import 'package:app/features/task/views/edit_task_page.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/app_config.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskRoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: 'task',
        name: AppRouteName.task.create,
        parentNavigatorKey: AppConfig.navigatorKey,
        builder:
            (BuildContext context, GoRouterState state) => CreateTaskPage(),
      ),
      GoRoute(
        path: 'task/edit',
        name: AppRouteName.task.edit,
        parentNavigatorKey: AppConfig.navigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final taskId = state.uri.queryParameters['taskId'];
          return EditTaskPage(taskId: taskId.toString());
        },
      ),
    ];
  }
}

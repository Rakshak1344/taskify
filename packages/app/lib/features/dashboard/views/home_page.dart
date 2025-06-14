import 'package:app/features/task/data/models/task.dart';
import 'package:app/features/task/views/states/task_state.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskStateProvider.notifier).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taskify"),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRouteName.dashboard.profile),
            icon: Icon(Icons.person_outline_rounded),
          ),
          IconButton(
            onPressed:
                () => ref.read(taskStateProvider.notifier).deleteAllTasks(),
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(AppRouteName.task.create),
        tooltip: "Add Task",
        child: Icon(Icons.add),
      ),
      body: ref
          .watch(taskStateProvider)
          .when(
            data: (tasks) {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.completedAt != null,
                      onChanged: (value) {
                        ref
                            .read(taskStateProvider.notifier)
                            .toggleTaskCompletion(
                              task.id,
                              task.completedAt == null ? true : false,
                            );
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.completedAt != null
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(
                        decoration:
                            task.completedAt != null
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    trailing: buildEditAndDeleteButton(task),
                    onTap:
                        () => context.goNamed(
                          AppRouteName.task.detail,
                          pathParameters: {'taskId': task.id},
                        ),
                  );
                },
              );
            },
            error: (e, s) => Text("Something went wrong: $e"),
            loading: () => CircularProgressIndicator(),
          ),
    );
  }

  Widget buildEditAndDeleteButton(Task task) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed:
              () => context.goNamed(
                AppRouteName.task.edit,
                queryParameters: {'taskId': task.id},
              ),
          icon: Icon(Icons.edit),
        ),
        SizedBox(width: 2),
        IconButton(
          onPressed:
              () => ref.read(taskStateProvider.notifier).deleteTask(task.id),
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}

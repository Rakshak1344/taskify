import 'package:app/features/task/data/models/task.dart';
import 'package:app/features/task/views/states/task_state.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:core/utils/loading.dart';
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
          ref
              .watch(taskStateProvider)
              .maybeWhen(
                data:
                    (tasks) => Visibility(
                      visible: tasks.isNotEmpty,
                      child: IconButton(
                        onPressed:
                            () =>
                                ref
                                    .read(taskStateProvider.notifier)
                                    .deleteAllTasks(),
                        icon: Icon(Icons.delete_forever),
                      ),
                    ),
                orElse: () => SizedBox.shrink(),
              ),
        ],
      ),
      floatingActionButton: buildAddTaskFloatingButton(context),
      body: ref
          .watch(taskStateProvider)
          .when(
            data: (tasks) {
              if (tasks.isEmpty) {
                return buildWhenNoTasks(context);
              }

              return buildTasksListView(tasks);
            },
            error: (e, s) => Text("Something went wrong: $e"),
            loading: context.buildLoadingIndicator,
          ),
    );
  }

  Widget buildTasksListView(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.completedAt != null,
            onChanged: (value) {},
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration:
                  task.completedAt != null ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.description,
            style: TextStyle(
              decoration:
                  task.completedAt != null ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: buildEditAndDeleteButton(task),
          onTap: () {
            ref
                .read(taskStateProvider.notifier)
                .toggleTaskCompletion(
                  task.id,
                  task.completedAt == null ? true : false,
                );

            ///TODO: If need can create a detail page for task
            // context.goNamed(
            //   AppRouteName.task.detail,
            //   pathParameters: {'taskId': task.id},
            // );
          },
        );
      },
    );
  }

  Widget buildWhenNoTasks(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("No tasks available. Create one!")),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => context.goNamed(AppRouteName.task.create),
          label: Text("Create Task"),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget buildAddTaskFloatingButton(BuildContext context) {
    return Visibility(
      visible: ref
          .watch(taskStateProvider)
          .maybeWhen(data: (tasks) => tasks.isNotEmpty, orElse: () => true),
      child: FloatingActionButton(
        onPressed: () => context.goNamed(AppRouteName.task.create),
        tooltip: "Add Task",
        child: Icon(Icons.add),
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

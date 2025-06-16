import 'package:app/features/task/views/states/task_state.dart';
import 'package:app/features/task/views/task_mixin.dart';
import 'package:core/utils/extensions/async_value_extension.dart';
import 'package:core/utils/loading.dart';
import 'package:core/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  const CreateTaskPage({super.key});

  @override
  ConsumerState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends ConsumerState<CreateTaskPage>
    with TaskFormMixin {
  void watchTaskState() {
    ref.listen(taskStateProvider, (previous, next) {
      if (context.didStateGetNewError(previous, next)) {
        if (context.didNewErrorOccur(previous, next)) {
          context.showSnackBar(next.error.toString());
        }
        return;
      }

      if (context.didStateGetNewData(previous, next, checkWithPrev: true)) {
        context.showSnackBar("Task created");
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    watchTaskState();
    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTaskForm(),
              ref
                  .watch(taskStateProvider)
                  .maybeWhen(
                    loading: context.buildLoadingIndicator,
                    orElse: () {
                      return ElevatedButton.icon(
                        onPressed: _createTask,
                        icon: Icon(Icons.add),
                        label: Text("Create Task"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    ref.read(taskStateProvider.notifier).createTask(title, description);
  }

  @override
  void dispose() {
    disposeFormControllers();
    super.dispose();
  }
}

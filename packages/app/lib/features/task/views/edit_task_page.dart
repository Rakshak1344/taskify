import 'package:app/features/task/data/models/task.dart';
import 'package:app/features/task/views/states/task_state.dart';
import 'package:app/features/task/views/task_mixin.dart';
import 'package:collection/collection.dart';
import 'package:core/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTaskPage extends ConsumerStatefulWidget {
  final String taskId;

  const EditTaskPage({super.key, required this.taskId});

  @override
  ConsumerState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends ConsumerState<EditTaskPage>
    with TaskFormMixin {
  var isCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateInitialValues();
    });
  }

  void updateInitialValues() {
    List<Task>? tasks = ref.read(taskStateProvider).valueOrNull;
    if (tasks == null) return;
    final task = tasks.firstWhereOrNull((task) => task.id == widget.taskId);
    if (task == null) {
      context.showSnackBar("Task not found");
      return;
    }
    setState(() {
      titleController.text = task.title;
      descriptionController.text = task.description;
      isCompleted = task.completedAt != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Task id: ${widget.taskId}"),
              SizedBox(height: 20),
              buildTaskForm(),
              ListTile(
                leading: Checkbox(
                  value: isCompleted,
                  onChanged:
                      (value) => setState(() => isCompleted = !isCompleted),
                ),
                title: Text(isCompleted ? "Completed" : "Pending"),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _saveTask,
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    ref
        .read(taskStateProvider.notifier)
        .updateTask(widget.taskId, title, description, isCompleted);
  }

  @override
  void dispose() {
    disposeFormControllers();
    super.dispose();
  }
}

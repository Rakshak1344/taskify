import 'package:app/features/task/data/models/task.dart';
import 'package:app/features/task/data/services/task_service.dart';
import 'package:core/arch/exception/exception_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_state.g.dart';

@riverpod
class TaskState extends _$TaskState {
  TaskService get _taskService => ref.read(taskServiceProvider);

  ExceptionAdapter get _exceptionAdapter => ref.read(exceptionAdapterProvider);

  @override
  Stream<List<Task>> build() => _taskService.watch();

  // Fetch all tasks
  Future<void> fetchTasks() async {
    state = const AsyncValue<List<Task>>.loading();
    await _exceptionAdapter
        .run(() async {
          await _taskService.fetchTasks();
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  Future<void> createTask(String title, String description) async {
    state = const AsyncValue<List<Task>>.loading();
    await _exceptionAdapter
        .run(() async {
          await _taskService.createTask(title, description);
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  Future<void> updateTask(
    String taskId,
    String title,
    String description,
    bool isCompleted,
  ) async {
    state = const AsyncValue<List<Task>>.loading();
    await _exceptionAdapter
        .run(() async {
          await _taskService.updateTask(
            taskId,
            title,
            description,
            isCompleted,
          );
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  /// Delete a task by its ID
  Future<void> deleteTask(String taskId) async {
    await _exceptionAdapter
        .run(() async {
          await _taskService.deleteTask(taskId);
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  /// Delete all tasks
  Future<void> deleteAllTasks() async {
    await _exceptionAdapter
        .run(() async {
          await _taskService.deleteAllTasks();
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }

  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    await _exceptionAdapter
        .run(() async {
          await _taskService.toggleTaskCompletion(id, isCompleted);
        })
        .catchError((e, st) {
          state = AsyncError(e, st);
        });
  }
}

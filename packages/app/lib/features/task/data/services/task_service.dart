import 'package:app/features/task/data/models/task.dart';
import 'package:app/features/task/data/repositories/local_task_repository.dart';
import 'package:app/features/task/data/repositories/network_task_repository.dart';
import 'package:core/utils/logger.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_service.g.dart';

@riverpod
TaskService taskService(Ref ref) => TaskService(ref);

class TaskService {
  final Ref ref;

  final NetworkTaskRepository _networkTaskRepository;

  final LocalTaskRepository _localTaskRepository;

  TaskService(this.ref)
    : _networkTaskRepository = ref.read(networkTaskRepositoryProvider),
      _localTaskRepository = ref.read(localTaskRepositoryProvider);

  Stream<List<Task>> watch() => _localTaskRepository.watch();

  Future<void> createTask(String title, String description) async {
    var createdTask = await _networkTaskRepository.createTask(
      title,
      description,
    );

    await _localTaskRepository.saveOne(createdTask);
  }

  Future<void> fetchTasks() async {
    var tasks = await _networkTaskRepository.fetchTasks();
    await _localTaskRepository.save(tasks);
  }

  Future<void> deleteTask(String taskId) async {
    await _networkTaskRepository.deleteTask(taskId);
    var task = _localTaskRepository.getById(taskId);
    await _localTaskRepository.delete(task);
  }

  // delete all tasks
  Future<void> deleteAllTasks() async {
    await _networkTaskRepository.deleteAllTasks();
    await _localTaskRepository.deleteAll();
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    var task = _localTaskRepository.getById(taskId);
    if (task == null) {
      log('Task with id $taskId not found');
      return;
    }
    var updatedTask = task.copyWith(
      completedAt: isCompleted ? DateTime.now() : null,
    );
    await _networkTaskRepository.updateTask(updatedTask);
    await _localTaskRepository.saveOne(updatedTask);
  }

  Future<void> updateTask(
    String taskId,
    String title,
    String description,
    isCompleted,
  ) async {
    var task = _localTaskRepository.getById(taskId);
    if (task == null) {
      log('Task with id $taskId not found');
      return;
    }
    var updatedTask = task.copyWith(
      title: title,
      description: description,
      completedAt: isCompleted ? DateTime.now() : null,
    );
    await _networkTaskRepository.updateTask(updatedTask);
    await _localTaskRepository.saveOne(updatedTask);
  }
}

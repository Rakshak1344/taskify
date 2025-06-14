import 'dart:async';

import 'package:app/features/task/data/models/task.dart';
import 'package:collection/collection.dart';
import 'package:core/arch/repository.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_task_repository.g.dart';

@riverpod
LocalTaskRepository localTaskRepository(Ref ref) {
  return LocalTaskRepository(ref);
}

class LocalTaskRepository extends CollectionRepository<Task> {
  final Ref ref;

  LocalTaskRepository(this.ref);

  Preferences get sharedPreferences => ref.read(preferenceProvider);

  late final _controller = StreamController<List<Task>>();
  late final _stream = _controller.stream.asBroadcastStream();

  @override
  Future<void> save(List<Task> data) async {
    data.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    await sharedPreferences.setValue<List<Task>>('tasks', data.cast<Task>());
  }

  // save one task
  Future<void> saveOne(Task? data) async {
    if (data == null) {
      return;
    }

    var tasks = get();
    final index = tasks.indexWhere((task) => task.id == data.id);

    if (index != -1) {
      tasks[index] = data;
    } else {
      tasks.insert(0, data);
    }

    await sharedPreferences.setValue<List<Task>>('tasks', tasks.cast<Task>());
  }

  @override
  Stream<List<Task>> watch() {
    sharedPreferences.watchValue<List<Task>>('tasks').listen((
      List<Task>? event,
    ) {
      if (event != null) {
        _controller.add(event);
      }
    });

    _controller.add(get());

    return _stream;
  }

  Stream<Task> watchById(String id) {
    return _stream.transform(
      StreamTransformer<List<Task>, Task>.fromHandlers(
        handleData: (data, sink) {
          var transaction = data.firstWhereOrNull(
            (element) => element.id == id,
          );
          sink.add(transaction!);
        },
      ),
    );
  }

  // get by Id
  Task? getById(String id) {
    var tasks = get();
    return tasks.firstWhereOrNull((task) => task.id == id);
  }

  @override
  List<Task> get() {
    var tasks = sharedPreferences.getValue<List>('tasks') ?? [];

    return tasks.cast();
  }

  @override
  Future<void> delete(Task? data) async {
    var tasks = get();
    if (tasks.isEmpty) {
      return;
    }

    tasks.remove(data);
    await sharedPreferences.setValue<List<Task>>('tasks', tasks.cast<Task>());
  }

  @override
  Future<void> deleteAll() async {
    await sharedPreferences.remove('tasks');
    await sharedPreferences.setValue<List<Task>>('tasks', []);
  }
}

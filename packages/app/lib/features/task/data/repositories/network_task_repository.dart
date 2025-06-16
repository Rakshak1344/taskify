import 'package:app/features/task/data/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'network_task_repository.g.dart';

@riverpod
NetworkTaskRepository networkTaskRepository(Ref ref) {
  return NetworkTaskRepository(ref);
}

class NetworkTaskRepository {
  final Ref ref;
  final _store = FirebaseFirestore.instance;
  final _collection = 'tasks';
  final fb.User? _user;

  NetworkTaskRepository(this.ref)
    : _user = fb.FirebaseAuth.instance.currentUser;

  // Example method to fetch tasks from a network source
  Future<List<Task>> fetchTasks() async {
    if (_user == null) {
      return [];
    }

    final snapshot =
        await _store
            .collection(_collection)
            .where('userId', isEqualTo: _user.uid)
            .get();

    return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
  }

  // Example method to create a new task
  Future<Task?> createTask(String title, String description) async {
    var currentDateTime = DateTime.now();
    final task = Task(
      id: const Uuid().v4(),
      userId: _user!.uid,
      title: title,
      description: description,
      createdAt: currentDateTime,
      updatedAt: currentDateTime,
      completedAt: null,
    );
    await _store.collection(_collection).add(task.toJson());
    return task;
  }

  // Update a task
  Future<void> updateTask(Task task) async {
    final snapshot =
        await _store
            .collection(_collection)
            .where('id', isEqualTo: task.id)
            .limit(1)
            .get();
    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update(task.toJson());
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    final snapshot =
        await _store
            .collection(_collection)
            .where('id', isEqualTo: taskId)
            .limit(1)
            .get();
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.first.reference.delete();
    }
  }

  Future<void> deleteAllTasks() {
    return _store
        .collection(_collection)
        .where('userId', isEqualTo: _user?.uid)
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete();
          }
        });
  }
}

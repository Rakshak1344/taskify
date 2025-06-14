import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task extends HiveObject with _$Task {
  Task._();

  @HiveType(typeId: 0, adapterName: 'TaskAdapter')
  factory Task({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String title,
    @HiveField(3) required String description,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime updatedAt,
    @HiveField(6) DateTime? completedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

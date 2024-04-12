import 'package:internet_tasks/internet_tasks.dart';
import 'package:tasks_api/src/models/task.dart';

/// {@template tasks_api}
/// The interface and models for an API providing access to tasks.
/// {@endtemplate}
abstract class TasksApi {
  /// {@macro tasks_api}
  const TasksApi();

  /// Provides a [Future] of all tasks.
  Future<TaskResult?> getTasks(String pageNumber, String perPage);

  // /// add a [task].
  // Future<Task> addTask(Task task);

  /// Saves a [task].
  ///
  /// If a [task] with the same id already exists, it will be replaced.
  Future<Task> saveTask(Task task);

  /// Deletes the `task` with the given [id].
  ///
  /// If no `task` with the given [id] exists, a [TaskNotFoundException] error
  /// is thrown.
  Future<bool> deleteTask(int id);
}

/// Error thrown when a [Task] with a given id is not found.
class TaskNotFoundException implements Exception {}

import 'package:internet_tasks/internet_tasks.dart';
import 'package:tasks_api/tasks_api.dart';

/// {@template internet_tasks}
/// Provide the logic of dealing with RESTFull Api of tasks.
/// {@endtemplate}
class InternetTasks {
  /// {@macro internet_tasks}
  const InternetTasks({
    required TasksApi tasksApi,
  }) : _tasksApi = tasksApi;

  final TasksApi _tasksApi;

  /// Provides a [Future] of tasks in [pageNumber] and
  /// return number of tasks equal [perPage].
  Future<TaskResult?> getTasks(String pageNumber, String perPage) =>
      _tasksApi.getTasks(pageNumber, perPage);

  /// Deletes the `task` with the given id.
  Future<bool> deleteTask(int id) => _tasksApi.deleteTask(id);

  /// Saves a [task].
  ///
  /// If a [task] with the same id already exists, it will be replaced.
  Future<Task> saveTask(Task task) => _tasksApi.saveTask(task);
}

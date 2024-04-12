// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:internet_tasks/internet_tasks.dart';
import 'package:tasks_api/tasks_api.dart';

class TaskRepository extends TasksApi {
  const TaskRepository({
    required this.stroage,
    required this.client,
  });

  final TaskStroage stroage;
  final TaskClient client;

  Future<Task> addTask(Task task) async {
    final result = await client.addTask(task, stroage.getValue('token')!);
    if (result == null) {
      return task;
    }

    await stroage.setValue(task.id.toString(), jsonEncode(result));

    return task;
  }

  @override
  Future<bool> deleteTask(int id) async {
    final result = await client.deleteTask(id, stroage.getValue('token')!);
    if (!result) {
      return false;
    }

    await stroage.remove(id.toString());

    return true;
  }

  @override
  Future<TaskResult?> getTasks(String pageNumber, String perPage) async {
    final result =
        await client.getTasks(pageNumber, perPage, stroage.getValue('token')!);
    if (result == null) {
      if (stroage.contains('PageNumber:$pageNumber,PerPage:$perPage')) {
        final savedTasks =
            stroage.getValue('PageNumber:$pageNumber,PerPage:$perPage');

        if (savedTasks == null) return null;

        final tasks = TaskResult.fromJson(
          jsonDecode(savedTasks) as Map<String, dynamic>,
        );

        return tasks;
      }
      return null;
    }

    await stroage.setValue('PageNumber:$pageNumber,PerPage:$perPage', result);

    final tasks = TaskResult.fromJson(
      jsonDecode(result) as Map<String, dynamic>,
    );

    return tasks;
  }

  Future<Task> updateTask(Task task) async {
    final result = await client.updateTask(task, stroage.getValue('token')!);
    if (result == null) {
      if (stroage.contains(task.id.toString())) {
        final savedTask = stroage.getValue(task.id.toString());
        if (savedTask == null) {
          return task;
        }

        return Task.fromJson(jsonDecode(savedTask) as Map<String, dynamic>);
      }
      return task;
    }

    await stroage.setValue(task.id.toString(), result.toString());

    return result;
  }

  @override
  Future<Task> saveTask(Task task) {
    if (task.id == 0) {
      return addTask(task);
    }
    return updateTask(task);
  }
}

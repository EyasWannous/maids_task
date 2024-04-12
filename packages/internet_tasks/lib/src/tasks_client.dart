// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks_api/tasks_api.dart';

class TaskClient {
  TaskClient({
    http.Client? httpClient,
    this.baseUrl = 'https://dummyjson.com/todos',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<String?> getTasks(
    String pageNumber,
    String perPage,
    String token,
  ) async {
    final skip = (int.parse(pageNumber) - 1) * int.parse(perPage);

    try {
      final queryParameters = 'limit=10&skip=$skip';
      final taskRequest = Uri.parse('$baseUrl?$queryParameters');

      final response = await httpClient.get(
        taskRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Task?> addTask(Task task, String token) async {
    try {
      final taskRequest = Uri.parse('$baseUrl/add');

      final response = await httpClient.post(
        taskRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(task),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return task;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Task?> updateTask(Task task, String token) async {
    try {
      final taskRequest = Uri.parse('$baseUrl/${task.id}');

      final response = await httpClient.put(
        taskRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(task),
      );

      if (response.statusCode == 200) {
        return task;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(int id, String token) async {
    try {
      final taskRequest = Uri.parse('$baseUrl/$id');

      final response = await httpClient.delete(
        taskRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:tasks_api/tasks_api.dart';

part 'task_result.g.dart';

@JsonSerializable()
class TaskResult {
  TaskResult({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  factory TaskResult.fromJson(Map<String, dynamic> json) =>
      _$TaskResultFromJson(json);

  List<Task>? todos;
  int? total;
  int? skip;
  int? limit;

  Map<String, dynamic> toJson() => _$TaskResultToJson(this);
}

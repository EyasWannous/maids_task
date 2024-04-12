// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      todo: json['todo'] as String,
      userId: json['userId'] as int,
      completed: json['completed'] as bool,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'userId': instance.userId,
      'completed': instance.completed,
    };

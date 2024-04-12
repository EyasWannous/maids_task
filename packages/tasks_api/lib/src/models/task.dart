import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'task.g.dart';

/// {@template task_item}
/// A single `task` item.
///
/// Contains a [todo], [userId], [completed] and [id].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Task]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Task extends Equatable {
  /// {@macro task_item}
  const Task({
    required this.todo,
    required this.userId,
    required this.completed,
    int? id,
  }) : id = id ?? 0;

  /// The unique identifier of the `task`.
  ///
  /// Cannot be empty.
  final int id;

  /// The `todo` of the `task`.
  final String todo;

  /// The userId of the `task`.
  final int userId;

  /// The completed of the `task`.
  final bool completed;

  /// Returns a copy of this `task` with the given values updated.
  ///
  /// {@macro task_item}
  Task copyWith({
    int? id,
    String? todo,
    int? userId,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      userId: userId ?? this.userId,
      completed: completed ?? this.completed,
    );
  }

  /// Deserializes the given [Map<String, dynamic>] into a [Task].
  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Converts this [Task] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object> get props => [id, todo, userId, completed];
}

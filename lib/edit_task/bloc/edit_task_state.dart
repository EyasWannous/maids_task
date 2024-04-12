part of 'edit_task_bloc.dart';

enum EditTaskStatus { initial, loading, success, failure }

extension EditTaskStatusX on EditTaskStatus {
  bool get isLoadingOrSuccess => [
        EditTaskStatus.loading,
        EditTaskStatus.success,
      ].contains(this);
}

final class EditTaskState extends Equatable {
  const EditTaskState({
    this.status = EditTaskStatus.initial,
    this.initialTask,
    this.todo = '',
    this.userId = 0,
    this.completed = false,
  });

  final EditTaskStatus status;
  final Task? initialTask;
  final String todo;
  final int userId;
  final bool completed;

  bool get isNewTask => initialTask == null;

  EditTaskState copyWith({
    EditTaskStatus? status,
    Task? initialTask,
    String? todo,
    int? userId,
    bool? completed,
  }) {
    return EditTaskState(
      status: status ?? this.status,
      initialTask: initialTask ?? this.initialTask,
      todo: todo ?? this.todo,
      userId: userId ?? this.userId,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [status, initialTask, todo, userId, completed];
}

part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

final class EditTaskTodoChanged extends EditTaskEvent {
  const EditTaskTodoChanged(this.todo);

  final String todo;

  @override
  List<Object> get props => [todo];
}

final class EditTaskUserIdChanged extends EditTaskEvent {
  const EditTaskUserIdChanged(this.userId);

  final int userId;

  @override
  List<Object> get props => [userId];
}

final class EditTaskCompletedChanged extends EditTaskEvent {
  const EditTaskCompletedChanged(this.completed);

  final bool completed;

  @override
  List<Object> get props => [completed];
}

final class EditTaskSubmitted extends EditTaskEvent {
  const EditTaskSubmitted();
}

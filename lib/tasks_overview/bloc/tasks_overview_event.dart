part of 'tasks_overview_bloc.dart';

sealed class TasksOverviewEvent extends Equatable {
  const TasksOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TasksOverviewSubscriptionRequested extends TasksOverviewEvent {
  const TasksOverviewSubscriptionRequested();
}

final class TasksOverviewTaskAdd extends TasksOverviewEvent {
  const TasksOverviewTaskAdd(this.task);
  final Task task;

  @override
  List<Object> get props => [task];
}

final class TasksOverviewTaskCompletionToggled extends TasksOverviewEvent {
  const TasksOverviewTaskCompletionToggled({
    required this.task,
    required this.completed,
  });

  final Task task;
  final bool completed;

  @override
  List<Object> get props => [task, completed];
}

final class TasksOverviewTaskDeleted extends TasksOverviewEvent {
  const TasksOverviewTaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

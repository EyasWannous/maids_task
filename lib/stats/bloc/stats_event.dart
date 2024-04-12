part of 'stats_bloc.dart';

sealed class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];
}

final class StatsSubscriptionRequested extends StatsEvent {
  const StatsSubscriptionRequested();
}

final class StatsChangedCompletedTasks extends StatsEvent {
  const StatsChangedCompletedTasks(this.completedTasks);

  final int completedTasks;

  @override
  List<Object> get props => [completedTasks];
}

final class StatsChangedActiveTasks extends StatsEvent {
  const StatsChangedActiveTasks(this.activeTasks);

  final int activeTasks;

  @override
  List<Object> get props => [activeTasks];
}

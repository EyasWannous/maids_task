import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(const StatsState()) {
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
    on<StatsChangedCompletedTasks>(_onChangedCompletedTasks);
    on<StatsChangedActiveTasks>(_onChangedActiveTasks);
  }

  void _onSubscriptionRequested(
    StatsSubscriptionRequested event,
    Emitter<StatsState> emit,
  ) {
    emit(state.copyWith(
      status: StatsStatus.success,
      completedTasks: 0,
      activeTasks: 0,
    ));
  }

  void _onChangedCompletedTasks(
    StatsChangedCompletedTasks event,
    Emitter<StatsState> emit,
  ) {
    emit(state.copyWith(
      status: StatsStatus.success,
      completedTasks: state.completedTasks + event.completedTasks,
    ));
  }

  void _onChangedActiveTasks(
    StatsChangedActiveTasks event,
    Emitter<StatsState> emit,
  ) {
    emit(state.copyWith(
      status: StatsStatus.success,
      activeTasks: state.activeTasks + event.activeTasks,
    ));
  }
}

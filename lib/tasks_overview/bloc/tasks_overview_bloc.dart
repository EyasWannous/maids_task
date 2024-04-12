import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:task_manager_app/stats/bloc/stats_bloc.dart';
import 'package:tasks_api/tasks_api.dart';

part 'tasks_overview_event.dart';
part 'tasks_overview_state.dart';

class TasksOverviewBloc extends Bloc<TasksOverviewEvent, TasksOverviewState> {
  TasksOverviewBloc(
    this.resultScrollController, {
    required StatsBloc statsBloc,
    required InternetTasks internetTasks,
  })  : _internetTasks = internetTasks,
        _statsBloc = statsBloc,
        super(const TasksOverviewState()) {
    on<TasksOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TasksOverviewTaskCompletionToggled>(_onTaskCompletionToggled);
    on<TasksOverviewTaskAdd>(_onTaskAddOrUpdated);
    on<TasksOverviewTaskDeleted>(_onTaskDeleted);
  }

  final StatsBloc _statsBloc;

  void _onTaskAddOrUpdated(
      TasksOverviewTaskAdd event, Emitter<TasksOverviewState> emit) {
    emit(state.copyWith(status: () => TasksOverviewStatus.loading));

    final contains =
        tasksResult.indexWhere((element) => element.id == event.task.id);
    if (contains > -1) {
      tasksResult[contains] = event.task;
    } else {
      tasksResult.add(event.task);
      _statsBloc.add(const StatsChangedActiveTasks(1));
    }

    emit(state.copyWith(
      status: () => TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  final ScrollController resultScrollController;
  double lastPixelsPosition = 0;

  final InternetTasks _internetTasks;
  final List<Task> tasksResult = [];
  int pageNumber = 1;
  int perPage = 4;

  Future<void> _onSubscriptionRequested(
    TasksOverviewSubscriptionRequested event,
    Emitter<TasksOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TasksOverviewStatus.loading));

    TaskResult? currentTasks = await _internetTasks.getTasks(
        pageNumber.toString(), perPage.toString());

    if (currentTasks == null || currentTasks.todos == null) {
      emit(state.copyWith(status: () => TasksOverviewStatus.failure));
    }

    if (pageNumber == 1) {
      tasksResult.clear();

      if (currentTasks?.todos == null || currentTasks!.todos!.isEmpty) {
        emit(state.copyWith(
          status: () => TasksOverviewStatus.success,
          tasks: tasksResult,
        ));
        return;
      }

      tasksResult.insertAll(0, currentTasks.todos!);

      emit(state.copyWith(
        status: () => TasksOverviewStatus.success,
        tasks: tasksResult,
      ));

      int completedTasks = 0;

      for (var element in tasksResult) {
        if (element.completed) {
          completedTasks++;
        }
      }

      _statsBloc.add(StatsChangedCompletedTasks(completedTasks));
      _statsBloc
          .add(StatsChangedActiveTasks(tasksResult.length - completedTasks));

      return;
    }

    if (currentTasks?.todos != null && currentTasks!.todos!.isNotEmpty) {
      tasksResult.insertAll(0, currentTasks.todos!);
    }

    emit(state.copyWith(
      status: () => TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  Future<void> _onTaskDeleted(
    TasksOverviewTaskDeleted event,
    Emitter<TasksOverviewState> emit,
  ) async {
    try {
      await _internetTasks.deleteTask(event.task.id);
      tasksResult.remove(event.task);
      emit(state.copyWith(lastDeletedTask: () => event.task));

      if (event.task.completed) {
        _statsBloc.add(const StatsChangedCompletedTasks(-1));
      } else {
        _statsBloc.add(const StatsChangedActiveTasks(-1));
      }
    } catch (e) {
      emit(state.copyWith(status: () => TasksOverviewStatus.failure));
    }
  }

  Future<void> onRefresh() async {
    pageNumber = (tasksResult.length / perPage).floor();
    pageNumber++;
    add(const TasksOverviewSubscriptionRequested());
  }

  void _onTaskCompletionToggled(
    TasksOverviewTaskCompletionToggled event,
    Emitter<TasksOverviewState> emit,
  ) {
    final newTodo = event.task.copyWith(completed: event.completed);
    tasksResult[tasksResult.indexWhere(
      (element) => element.id == newTodo.id,
    )] = newTodo;

    emit(state.copyWith(
      status: () => TasksOverviewStatus.loading,
    ));

    if (event.completed) {
      _statsBloc.add(const StatsChangedCompletedTasks(1));
      _statsBloc.add(const StatsChangedActiveTasks(-1));
    } else {
      _statsBloc.add(const StatsChangedCompletedTasks(-1));
      _statsBloc.add(const StatsChangedActiveTasks(1));
    }

    _internetTasks.saveTask(newTodo);

    emit(state.copyWith(
      status: () => TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }
}

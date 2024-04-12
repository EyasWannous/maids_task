import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/theme/bloc/theme_helper.dart';
import 'package:task_manager_app/theme/theme.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light()) {
    on<InitialThemeSetEvent>(_onInitialThemeSetEvent);
    on<ThemeSwitchEvent>(_onThemeSwitchEvent);
  }

  Future<void> _onInitialThemeSetEvent(event, emit) async {
    final bool hasDarkTheme = await isDark();
    if (hasDarkTheme) {
      emit(FlutterTasksTheme.dark);
      return;
    }

    emit(FlutterTasksTheme.light);
  }

  void _onThemeSwitchEvent(event, emit) {
    final isDark = state == FlutterTasksTheme.dark;
    emit(isDark ? FlutterTasksTheme.light : FlutterTasksTheme.dark);
    setTheme(isDark);
  }
}

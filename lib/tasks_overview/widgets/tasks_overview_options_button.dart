import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/theme/bloc/theme_bloc.dart';
import 'package:task_manager_app/theme/theme.dart';

@visibleForTesting
enum TasksOverviewOption { swithTheme, logout }

class TasksOverviewOptionsButton extends StatelessWidget {
  const TasksOverviewOptionsButton({super.key, required this.enableLogOut});
  final bool enableLogOut;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TasksOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: 'Options',
      onSelected: (options) {
        switch (options) {
          case TasksOverviewOption.swithTheme:
            context.read<ThemeBloc>().add(ThemeSwitchEvent());
          case TasksOverviewOption.logout:
            context.read<AppBloc>().add(const AppLogoutRequested());
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TasksOverviewOption.logout,
            enabled: enableLogOut,
            child: const Text('Logout'),
          ),
          PopupMenuItem(
            value: TasksOverviewOption.swithTheme,
            child: BlocBuilder<ThemeBloc, ThemeData>(
              builder: (_, themeData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Change Theme'),
                    Icon(
                      themeData == FlutterTasksTheme.dark
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                  ],
                );
              },
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}

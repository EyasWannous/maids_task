import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:tasks_api/tasks_api.dart';

import 'edit_task_view.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});

  static Route<void> route({
    Task? initialTask,
    required TasksOverviewBloc tasksOverviewBloc,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTaskBloc(
          tasksOverviewBloc: tasksOverviewBloc,
          internetTasks: context.read<InternetTasks>(),
          initialTask: initialTask,
        ),
        child: const EditTaskPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskBloc, EditTaskState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTaskStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTaskView(),
    );
  }
}

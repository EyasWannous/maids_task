import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:task_manager_app/tasks_overview/view/tasks_overview_view.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TasksOverviewBloc>(),
      child: const TasksOverviewView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:task_manager_app/home/cubit/home_cubit.dart';
import 'package:task_manager_app/stats/bloc/stats_bloc.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => TasksOverviewBloc(
            ScrollController(),
            statsBloc: context.read<StatsBloc>(),
            internetTasks: context.read<InternetTasks>(),
          )..add(const TasksOverviewSubscriptionRequested()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

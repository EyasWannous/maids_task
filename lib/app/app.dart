import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/stats/bloc/stats_bloc.dart';
import 'package:task_manager_app/theme/bloc/theme_bloc.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.internetTasks,
    required this.internetAuthentication,
    required this.token,
  });

  final InternetTasks internetTasks;
  final InternetAuthentication internetAuthentication;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InternetTasks>.value(
          value: internetTasks,
        ),
        RepositoryProvider<InternetAuthentication>.value(
          value: internetAuthentication,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (_) => ThemeBloc()..add(InitialThemeSetEvent()),
          ),
          BlocProvider<AppBloc>(
            create: (_) =>
                AppBloc(internetAuthentication: internetAuthentication)
                  ..add(AppTokenChecked(token ?? '')),
          ),
          BlocProvider<StatsBloc>(
            create: (context) =>
                StatsBloc()..add(const StatsSubscriptionRequested()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/theme/bloc/theme_bloc.dart';

import 'routes/routes.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    var appState =
        context.select<AppBloc, AppStatus>((AppBloc bloc) => bloc.state.status);
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (_, themeState) {
        return MaterialApp(
          theme: themeState,
          debugShowCheckedModeBanner: false,
          home: FlowBuilder<AppStatus>(
            state: appState,
            onGeneratePages: onGenerateAppViewPages,
          ),
        );
      },
    );
  }
}

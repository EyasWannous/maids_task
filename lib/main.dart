import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/app/app.dart';
import 'package:task_manager_app/app/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final plugin = await SharedPreferences.getInstance();

  final tasksApi = TaskRepository(
    client: TaskClient(),
    stroage: TaskStroage(plugin: plugin),
  );

  final authenticationApi = AuthenticationRepository(
    client: AuthenticationClient(),
    plugin: plugin,
  );

  final internetAuthentication = InternetAuthentication(
    authenticationApi: authenticationApi,
  );

  final internetTasks = InternetTasks(tasksApi: tasksApi);

  final token = await internetAuthentication.checkLoggedIn();

  runApp(App(
    internetTasks: internetTasks,
    internetAuthentication: internetAuthentication,
    token: token,
  ));
}

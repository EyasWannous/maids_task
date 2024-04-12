import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/login/cubit/login_cubit.dart';
import 'package:task_manager_app/login/view/login_form.dart';
import 'package:task_manager_app/tasks_overview/widgets/tasks_overview_options_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: const [
          TasksOverviewOptionsButton(enableLogOut: false),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(
            context.read<InternetAuthentication>(),
            context.read<AppBloc>(),
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

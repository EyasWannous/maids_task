import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager_app/login/cubit/login_cubit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (_, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.user),
            labelStyle:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
            labelText: 'username',
            helperText: '',
            errorText:
                state.username.displayError != null ? 'invalid username' : null,
            suffix: const Icon(FontAwesomeIcons.envelope),
          ),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._internetAuthentication, this._appBloc)
      : super(const LoginState());

  final InternetAuthentication _internetAuthentication;
  final AppBloc _appBloc;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password]),
      ),
    );
  }

  // Password ObscureText
  bool isvisible = false;
  void changeVisbilty() {
    final password = Password.dirty('${state.password.value} ');
    final password2 = Password.dirty(state.password.value);
    isvisible = !isvisible;
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password]),
      ),
    );
    emit(
      state.copyWith(
        password: password2,
        isValid: Formz.validate([state.username, password2]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      var userResult = await _internetAuthentication.login(
        username: state.username.value,
        password: state.password.value,
      );
      if (userResult == null) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }

      _appBloc.add(AppTokenChecked(userResult?.token ?? ''));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}

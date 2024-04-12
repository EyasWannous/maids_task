import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_authentication/internet_authentication.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required InternetAuthentication internetAuthentication})
      : _internetAuthentication = internetAuthentication,
        super(const AppState.unauthenticated()) {
    on<AppTokenChecked>(_onTokenChecked);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  final InternetAuthentication _internetAuthentication;

  Future<void> _onTokenChecked(
      AppTokenChecked event, Emitter<AppState> emit) async {
    emit(
      (event.token.isNotEmpty)
          ? AppState.authenticated(event.token)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_internetAuthentication.logOut());
    emit(const AppState.unauthenticated());
  }
}

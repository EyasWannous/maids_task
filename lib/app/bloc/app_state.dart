part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

final class AppState extends Equatable {
  const AppState._({required this.status, this.token = ''});

  const AppState.authenticated(String token)
      : this._(status: AppStatus.authenticated, token: token);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final String token;

  @override
  List<Object> get props => [status, token];
}

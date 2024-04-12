import 'package:authentication_api/authentication_api.dart';
import 'package:internet_authentication/src/models/models.dart';

/// {@template internet_authentication}
/// Provide the logic of dealing with RESTFull Api of Authentications.
/// {@endtemplate}
class InternetAuthentication {
  /// {@macro internet_authentication}
  const InternetAuthentication({
    required AuthenticationApi authenticationApi,
  }) : _authenticationApi = authenticationApi;

  final AuthenticationApi _authenticationApi;

  /// Provides a [Future] that return token if the
  /// [username] and [password] is are correct and match in server.
  ///
  /// return `null` if they are not.
  Future<UserResult?> login({
    required String username,
    required String password,
  }) =>
      _authenticationApi.login(username, password);

  /// Provides a [Future] that return token that
  /// refreshed.
  ///
  /// return `null` if they error happened.
  Future<String?> refresh() => _authenticationApi.refresh();

  /// Provides a [Future] that return token
  /// if the User has token Already
  /// return `null` if not.
  Future<String?> checkLoggedIn() => _authenticationApi.checkLoggedIn();

  /// Provides a [Future] that delete saved token
  /// and logout from the app
  Future<void> logOut() => _authenticationApi.logOut();
}

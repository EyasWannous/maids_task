import 'package:internet_authentication/src/models/models.dart';

/// {@template authentication_api}
/// The interface and models for an API providing access to authentications.
/// {@endtemplate}
abstract class AuthenticationApi {
  /// {@macro authentication_api}
  const AuthenticationApi();

  /// Login API.
  Future<UserResult?> login(String username, String password);

  /// Check If User Already have token
  Future<String?> checkLoggedIn();

  /// Logout and delete token
  Future<void> logOut();

  /// Refresh Token
  Future<String?> refresh();
}

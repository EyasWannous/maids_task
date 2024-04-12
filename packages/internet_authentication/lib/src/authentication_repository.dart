// ignore_for_file: public_member_api_docs

import 'package:authentication_api/authentication_api.dart';
import 'package:internet_authentication/src/authentication_client.dart';
import 'package:internet_authentication/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends AuthenticationApi {
  const AuthenticationRepository({
    required this.client,
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final AuthenticationClient client;
  final SharedPreferences _plugin;

  @override
  Future<UserResult?> login(String username, String password) async {
    final result = await client.login(username, password);
    if (result == null) return null;

    await _plugin.setString('token', result.token!);
    return result;
  }

  @override
  Future<String?> checkLoggedIn() async {
    return _plugin.getString('token');
  }

  @override
  Future<void> logOut() => _plugin.remove('token');

  @override
  Future<String?> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}

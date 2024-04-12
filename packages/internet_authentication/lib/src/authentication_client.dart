// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_authentication/src/models/models.dart';
import 'package:internet_authentication/src/models/user_result.dart';

class AuthenticationClient {
  AuthenticationClient({
    http.Client? httpClient,
    // this.baseUrl = 'https://reqres.in/api',
    this.baseUrl = 'https://dummyjson.com/auth',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<UserResult?> login(String username, String password) async {
    try {
      final loginRequest = Uri.parse('$baseUrl/login');

      final user = User(username: username, password: password).toJson();

      final response = await httpClient.post(
        loginRequest,
        body: user,
      );

      if (response.statusCode == 200) {
        return UserResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

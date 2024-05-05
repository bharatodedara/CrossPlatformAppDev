// authentication_service.dart

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AuthenticationService {
  static Future<ParseResponse> signUp(String username, String password) async {
    final user = ParseUser(null, null, null)
      //..set('email', email)
      ..set('username', username)
      ..set('password', password);

    return await user.signUp();
  }

  static Future<ParseResponse> logIn(String username, String password) async {
    final user = ParseUser(username, password, null);
    return await user.login();
  }
}

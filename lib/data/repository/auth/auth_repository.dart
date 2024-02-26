import 'package:registration_flutter/data/models/user.dart';

abstract class AuthRepository {
  Future<bool> loggedIn();

  Future<bool> signUp(User user);

  Future<String> verifyLogin(String username, String password);

  Future<void> clear(String username);

  Future<void> logOut();
}

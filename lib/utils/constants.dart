import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants._();

  static const String wentWrong = 'Something went wrong.';
  static const String invalidCredentials = 'Invalid credentials';
  static const String usernamePasswordCantEmpty =
      'Username and Password cannot be empty.';
  static const String loggedInSuccessfully = 'LoggedIn successfully.';
  static const String errorInSignUp = 'Error in SignUp.';
  static const String errorInGeneratingOtp = 'Error in generating Otp.';
  static const String errorInValidatingOtp = 'Error in validating Otp.';
  static const String signUpSuccessfully = 'SignUp successfully.';
}

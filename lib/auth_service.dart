import 'dart:async';
import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_aws_sample/auth_credentials.dart';

enum AuthFlowStatus { login, singup, vertification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;
  
  AuthState({this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  AuthCredentials _credentials;

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.singup);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  void loginWithCredentials(AuthCredentials credentials) async {
    try {

      final result = await Amplify.Auth.signIn(
        username: credentials.username,
        password: credentials.password
      );

      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        print('User could not be signed in');
      }
    } on AuthException catch (authError) {
      print('Could not login - ${authError.message}');
    }
    // final state = AuthState(authFlowStatus: AuthFlowStatus.session);

    // authStateController.add(state);
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {'email':credentials.email};

      final result = await Amplify.Auth.signUp(
        username: credentials.username,
        password: credentials.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes)
      );

      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        this._credentials = credentials;

        final state = AuthState(authFlowStatus: AuthFlowStatus.vertification);
        authStateController.add(state);
      }
    } on AuthException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
    // final state = AuthState(authFlowStatus: AuthFlowStatus.vertification);

    // authStateController.add(state);
  }

  void verifyCode(String verificationCode) async {
    try {
    // 2
    final result = await Amplify.Auth.confirmSignUp(
        username: _credentials.username, confirmationCode: verificationCode);

        if (result.isSignUpComplete) {
          loginWithCredentials(_credentials);
        } else {
          // more steps
        }
      } on AuthException catch (authError) {
        print('Could not verify code - ${authError.message}');
      }
    // final state = AuthState(authFlowStatus: AuthFlowStatus.session);
    // authStateController.add(state);
  }

  void logOut() async {
    try {
      await Amplify.Auth.signOut();

      showLogin();
    } on AuthException catch (authError) {
      print('Could not log out - ${authError.message}');
    }
    // final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    // authStateController.add(state);
  }

  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }
}
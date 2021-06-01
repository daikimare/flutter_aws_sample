import 'dart:async';

import 'dart:ffi';

enum AuthFlowStatus { login, singup, vertification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;
  
  AuthState({this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.singup);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}
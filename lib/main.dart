import 'package:flutter/material.dart';
import 'package:flutter_aws_sample/auth_service.dart';
import 'package:flutter_aws_sample/login_page.dart';
import 'package:flutter_aws_sample/sign_up_page.dart';
import 'package:flutter_aws_sample/verification_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),

      home: StreamBuilder<AuthState> (
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // show login page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                MaterialPage(
                  child: LoginPage(
                    didProvideCredentials: _authService.loginWithCredentials,
                    shouldShowSignUp: _authService.showSignUp
                  )
                ),

                // show sign up page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.singup)
                MaterialPage(
                  child: SignUpPage(
                    didProvideCredentials: _authService.signUpWithCredentials,
                    shouldShowLogin: _authService.showLogin
                  )
                ),
                
                if (snapshot.data.authFlowStatus == AuthFlowStatus.vertification)
                  MaterialPage(child: VerificationPage(
                    didProvideVerificationCode: _authService.verifyCode,
                  ))
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
      // home: Navigator(
      //   pages: [
      //     MaterialPage(child: LoginPage()),
      //     MaterialPage(child: SignUpPage())
      //     ],
      //   onPopPage: (route, result) => route.didPop(result),
      // ),
    );
  }
}
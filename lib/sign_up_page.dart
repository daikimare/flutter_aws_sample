import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            // sign up form
            _signUpForm(),

            // login button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: () {},
                  child: Text('Already have an account? Login.')),
            )
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // user name textfiild
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
        ),

        // e-mail textfield
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'E-mail',
          ),
        ),

        // password textfield
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: 'Password',
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // sign up button
        FlatButton(
          onPressed: _signUp,
          child: Text('Sign Up'),
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('e-mail: $email');
    print('password: $password');
  }
}

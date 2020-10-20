import 'package:cubizz_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Container(
        child: Center(child: Text('Login screen')),
      ),
    );
  }
}

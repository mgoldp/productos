import 'package:flutter/material.dart';
import 'package:productos_app/widgets/auth_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Container(
          width: double.infinity,
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }
}

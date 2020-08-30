import 'package:flutter/material.dart';
import 'package:sonno/sign_in_with/sign_in_buttons.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GoogleSignInButton(),
              FacebookSignInButton(),
            ],
          ),
        )
      ),
    );
  }
}

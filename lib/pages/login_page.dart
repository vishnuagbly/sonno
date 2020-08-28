import 'package:flutter/material.dart';
import 'package:sonno/network.dart';
import 'package:sonno/sign_in_with/sign_in_buttons.dart';

import '../constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Network.signedIn.then((res) {
      if(res) WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(kHomePageRoute);
      });
    });

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

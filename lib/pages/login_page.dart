import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sonno/sign_in_with/sign_in_buttons.dart';

import '../main_profile.dart';
import 'home_page.dart';
import 'loading_screen.dart';

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

Widget openLoginPage() {
  log('opening login page', name: 'loginPage');
  return LoadingScreen<bool>(
    future: MainProfile.signedIn,
    func: (isSignedIn) {
      if (isSignedIn) return openHomePage();
      return LoginPage();
    },
  );
}

import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/dialogs/dialogs.dart';
import 'package:sonno/sign_in_with/sign_in_with_google.dart';

import '../network.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Colors.red,
      text: 'SIGN IN WITH GOOGLE',
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => FutureDialog(
            future: signInWithGoogle(trailingFunc: (uuid) async => Network.setAuthId(uuid)),
            hasData: (uuid) {
              return CommonAlertDialog(
                'Successfully logged in',
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, kHomePageRoute);
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class FacebookSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Colors.blue,
      text: 'SIGN IN WITH FACEBOOK',
      onPressed: () {},
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.color,
    @required this.onPressed,
    @required this.text,
  });

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: color,
      child: Container(
        width: screenWidth * 0.7,
        height: screenWidth * 0.07,
        constraints: BoxConstraints(
          maxWidth: 1000,
          maxHeight: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth < 10000 / 7 ? screenWidth * 0.04 : 400 / 7,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

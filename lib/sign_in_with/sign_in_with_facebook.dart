import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'custom_web_view.dart';

String clientId = "2749110221987378";
final firebaseAuth = FirebaseAuth.instance;
String redirectURL = "https://www.facebook.com/connect/login_success.html";

Future<String> signInWithFacebook(BuildContext context) async {
  String result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomWebView(
        selectedUrl:
            'https://www.facebook.com/dialog/oauth?client_id=$clientId&redirect_uri=$redirectURL&response_type=token&scope=email,public_profile,',
      ),
      maintainState: true,
    ),
  );
  if (result != null) {
    try {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      final authResult =
          await firebaseAuth.signInWithCredential(facebookAuthCred);
      log("uuid: ${authResult.user.uid}", name: "signInFacebook");
//      setAuthId(authResult.user.uid, SignInType.facebook);
//      Phoenix.rebirth(context);
    } catch (e) {
      print(e);
    }
  }
  return null;
}

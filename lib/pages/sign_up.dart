import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/main_profile.dart';
import 'package:sonno/pages/loading_screen.dart';

import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String name;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                ),
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: kPrimaryColor,
                  hintText: 'Enter Your Name',
                ),
                onChanged: (value) => name = value,
                onSubmitted: (value) => submit(name, context),
              ),
              SizedBox(height: 20),
              RaisedButton(
                padding: EdgeInsets.zero,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimarySelectionColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 200,
                    minWidth: screenWidth * 0.2,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Stack(
                      children: [
                        Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: kPrimaryBgColor,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () => submit(name, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void submit(String name, BuildContext context) async {
  log('submitting name', name: 'SignUpPage/submit');
  if (name == null) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoadingScreen<void>(
        future: MainProfile.setName(name),
        func: (_) => loadHomePageData(),
      ),
    ),
  );
}

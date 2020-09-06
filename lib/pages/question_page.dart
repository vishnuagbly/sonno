import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/objects.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage(this.quesObj);

  final QuestionObj quesObj;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              SizedBox(height: 30),
              Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  quesObj.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.all(30),
                child: Text(
                  quesObj.answer,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

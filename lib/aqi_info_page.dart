import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  InfoPage(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
    );
  }
}

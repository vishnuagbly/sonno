import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            children: [
              SizedBox(height: 20),
              Profile(
                profilePic: AssetImage('assets/best_pic.png'),
                name: 'Vishnu Agarwal',
              ),
              SizedBox(height: 50),
              Profile(
                profilePic: AssetImage('assets/default_profile_pic.jpg'),
                name: 'Ashok Arora',
              ),
              SizedBox(height: 50),
              Profile(
                profilePic: AssetImage('assets/default_profile_pic.jpg'),
                name: 'Aniket Sharma',
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  Profile({this.profilePic, this.name});

  final ImageProvider profilePic;
  final String name;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: profilePic,
            width: screenWidth * 0.8,
          ),
          Container(
            color: kPrimaryColor,
            height: screenWidth * 0.2,
            width: screenWidth * 0.8,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

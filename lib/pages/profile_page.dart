import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/components/custom_list_tile.dart';
import 'package:sonno/main_profile.dart';

import 'profile_sub_pages/profile_sub_pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = const EdgeInsets.all(20);
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: padding,
                  color: kPrimaryColor,
                  child: Column(
                    children: [
                      FutureBuilder<String>(
                        future: MainProfile.name,
                        builder: (context, snapshot) => Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        MainProfile.email,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  color: kPrimaryColor,
                  padding: padding,
                  child: CustomListTile(
                    iconData: Icons.settings,
                    title: 'Settings',
                    page: SettingsPage(),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  color: kPrimaryColor,
                  padding: padding,
                  child: Column(
                    children: [
                      CustomListTile(
                        iconData: Icons.question_answer,
                        title: 'FAQ',
                        page: FaqPage(),
                      ),
                      CustomListTile(
                        iconData: Icons.report_problem,
                        title: 'Feedback',
                        page: FeedbackPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/main_profile.dart';

import 'profile_sub_pages/profile_sub_pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = const EdgeInsets.all(20);
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      snapshot.data,
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
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  CustomListTile({IconData iconData, this.page, String title})
      : icon = Icon(iconData ?? Icons.label),
        title = title ?? "";

  final Icon icon;
  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {
        Navigator.push(
          context,
          createSlidingRoute(
            page,
            Offset(1.0, 0.0),
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 100),
          ),
        );
      },
    );
  }
}

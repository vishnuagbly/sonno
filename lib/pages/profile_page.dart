import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/components/settings_list_tile.dart';
import 'package:sonno/dialogs/common_alert_dialog.dart';
import 'package:sonno/dialogs/dialogs.dart';
import 'package:sonno/main_profile.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  child: SettingsListTile(
                    leadingIconData: Icons.settings,
                    title: 'Settings',
                    onTap: () async {
                      await Navigator.push(context,
                          createSlidingRoute(SettingsPage(), Offset(1, 0)));
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  color: kPrimaryColor,
                  padding: padding,
                  child: Column(
                    children: [
                      SettingsListTile(
                        leadingIconData: Icons.question_answer,
                        title: 'FAQ',
                        page: FaqPage(),
                      ),
                      SettingsListTile(
                        leadingIconData: Icons.report_problem,
                        title: 'Feedback',
                        onTap: () async {
                          const url =
                              "https://docs.google.com/forms/d/e/1FAIpQLSd5d2cAMrEEHjhN5WB6dA6P18daYmvKPycjK3Q2zHI7MPLeUw/viewform?usp=sf_link";
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => FutureDialog(
                              future: canLaunch(url),
                              hasData: (canLaunch) {
                                if (canLaunch)
                                  return FutureDialog(
                                    future: launch(url),
                                    hasData: (_) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.pop(context);
                                      });
                                      return CommonAlertDialog(
                                        "Successfully launched url",
                                      );
                                    },
                                    loadingText: 'Launching url...',
                                  );
                                return CommonAlertDialog(
                                  'Cannot open url',
                                  icon: Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          );
                        },
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

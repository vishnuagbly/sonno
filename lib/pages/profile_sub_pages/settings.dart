import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sonno/components/settings_list_tile.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/dialogs/dialogs.dart';
import 'package:sonno/main_profile.dart';
import 'package:sonno/pages/about_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  EdgeInsets padding = const EdgeInsets.all(20);
  Widget _nameChange;
  bool _notifications = false;
  double screenWidth = 500;
  String _name;

  @override
  void initState() {
    _nameChange = SettingsListTile(
      key: UniqueKey(),
      title: 'Change Name',
      leadingIconData: MdiIcons.cardAccountDetails,
      trailing: null,
      onTap: () async {
        String oldName = await MainProfile.name;
        setState(() {
          _nameChange = Container(
            color: kPrimaryColor,
            child: TextField(
              style: TextStyle(
                fontSize: screenWidth * 0.05,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                hintText: oldName,
                fillColor: Colors.white12,
                filled: true,
              ),
              onChanged: (value) => _name = value,
              onSubmitted: (value) async {
                showDialog(
                  context: context,
                  builder: (context) => FutureDialog(
                    future: MainProfile.setName(_name),
                    hasData: (_) => CommonAlertDialog(
                      'Name Changed',
                    ),
                  ),
                );
              },
            ),
          );
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Container(
              color: kPrimaryColor,
              padding: padding,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _nameChange,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: padding,
              color: kPrimaryColor,
              child: Column(
                children: [
                  SettingsListTile(
                    leadingIconData: Icons.notifications,
                    title: 'Notifications',
                    trailing: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        _notifications
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        key: UniqueKey(),
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    onTap: () => setState(() {
                      _notifications = !_notifications;
                    }),
                  ),
                  SettingsListTile(
                    leadingIconData: Icons.people,
                    title: 'About Us',
                    page: AboutPage(),
                  ),
                  SettingsListTile(
                    leadingIconData: Icons.exit_to_app,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => BooleanDialog(
                                'Do you want to logout?',
                                content: Text(
                                  "Note:- On logout all data will be deleted",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                onPressedYes: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => FutureDialog(
                                            future: MainProfile.logout(context),
                                          ));
                                },
                              ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

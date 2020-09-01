import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/main_profile.dart';
import 'package:sonno/objects/objects.dart';

import 'profile_sub_pages/profile_sub_pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static DeviceInfo _selectedDevice;
  static final _nullDevice = DeviceInfo.raw(999);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = const EdgeInsets.all(20);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int numberOfParticles = 0;
    String selectedDeviceName = 'Select Device for Visuals';
    if (_selectedDevice != _nullDevice && _selectedDevice != null) {
      numberOfParticles = _selectedDevice.getAvg(Parameters.aqi).toInt();
      selectedDeviceName = _selectedDevice.name;
      log('numOfParticles: $numberOfParticles', name: 'ProfilePage');
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 80,
              numberOfParticles: numberOfParticles.toDouble(),
              speedOfParticles: 1,
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: false,
              particleColor: Colors.white.withAlpha(150),
              awayAnimationDuration: Duration(milliseconds: 600),
              maxParticleSize: 8,
              isRandSize: true,
              isRandomColor: false,
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverColor: Colors.white,
              hoverRadius: 90,
              connectDots: false,
            ),
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
                    iconData: Icons.blur_on,
                    title: selectedDeviceName,
                    trailing: FutureBuilder<List<DeviceInfo>>(
                      future: MainProfile.getConnectedDevice(),
                      builder: (context, snapshot) {
                        Icon icon = Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: screenWidth * 0.08,
                        );
                        if (snapshot.hasData)
                          return PopupMenuButton<DeviceInfo>(
                            onSelected: (value) => setState(() {
                              log('selected a device',
                                  name: 'popupMenu/ProfilePage');
                              _selectedDevice = value;
                            }),
                            itemBuilder: (context) {
                              var devices = snapshot.data;
                              List<PopupMenuItem<DeviceInfo>> res = [];
                              TextStyle style = TextStyle(
                                fontSize: screenWidth * 0.05,
                              );
                              res.add(PopupMenuItem<DeviceInfo>(
                                value: _nullDevice,
                                child: Container(
                                  child: Text('No Device', style: style),
                                ),
                              ));
                              for (var device in devices) {
                                res.add(PopupMenuItem<DeviceInfo>(
                                  value: device,
                                  child: Container(
                                    child: Text('${device.name}', style: style),
                                  ),
                                ));
                              }
                              return res;
                            },
                            icon: icon,
                          );
                        return icon;
                      },
                    ),
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

class CustomListTile extends StatelessWidget {
  ///if both page and onTap are provided than onTap is given priority.
  CustomListTile({
    IconData iconData,
    this.page,
    String title,
    this.trailing = const Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey,
    ),
    this.onTap,
  })  : icon = Icon(iconData ?? Icons.label),
        title = title ?? "";

  final Icon icon;
  final Widget trailing;
  final String title;
  final Widget page;
  final Function onTap;

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
      trailing: trailing,
      onTap: onTap ??
          () {
            if (page != null)
              Navigator.push(
                context,
                createSlidingRoute(
                  page,
                  Offset(1.0, 0.0),
                ),
              );
          },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/components/settings_list_tile.dart';
import 'package:sonno/main_profile.dart';
import 'package:sonno/objects/objects.dart';

class VisualsPage extends StatefulWidget {
  @override
  _VisualsPageState createState() => _VisualsPageState();
}

class _VisualsPageState extends State<VisualsPage> {
  static DeviceInfo _selectedDevice;
  static final _nullDevice = DeviceInfo.raw(999);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var devices = await MainProfile.getConnectedDevice();
      if(_selectedDevice != null && !devices.contains(_selectedDevice))
        setState(() {
          _selectedDevice = _nullDevice;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int numberOfParticles = 0;
    String selectedDeviceName = 'Select Device for Visuals';
    if (_selectedDevice != _nullDevice && _selectedDevice != null) {
      numberOfParticles = _selectedDevice.getAvg(Parameters.aqi).toInt();
      selectedDeviceName = _selectedDevice.name;
      log('numOfParticles: $numberOfParticles', name: 'ProfilePage');
    }

    return Scaffold(
      body: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: numberOfParticles.toDouble(),
            speedOfParticles: 2,
            height: screenHeight,
            width: screenWidth,
            onTapAnimation: false,
            particleColor: Colors.brown[200].withAlpha(150),
            awayAnimationDuration: Duration(milliseconds: 600),
            maxParticleSize: 8,
            isRandSize: false,
            isRandomColor: false,
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
            connectDots: false,
          ),
          Center(
            child: Container(
                color: Colors.white12,
                padding: const EdgeInsets.all(20),
                child: SettingsListTile(
                  leadingIconData: Icons.blur_on,
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
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

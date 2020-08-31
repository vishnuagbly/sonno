import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';
import 'package:sonno/main_profile.dart';
import 'package:sonno/objects/objects.dart';
import 'loading_screen.dart';
import 'sign_up.dart';
import 'aqi_info_page.dart';
import 'package:sonno/dialogs/dialogs.dart';
import 'package:sonno/network.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  HomePage({this.devices});

  final List<StationInfo> devices;

  @override
  _HomePageState createState() => _HomePageState(devices);
}

class _HomePageState extends State<HomePage> {
  List<StationInfo> _devices = [];
  Widget body;

  _HomePageState(List<StationInfo> devices) : _devices = devices ?? [];

  bool get _newData {
    return Network.checkIfDataUpdated();
  }

  @override
  void initState() {
    log('initiating state', name: initState.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (_devices.length > 0)
      body = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: InkWell(
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (_devices[i].name ?? 'Device ${_devices[i].id}')
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      Text(
                        'ID: ${_devices[i].id.toString()}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: kPrimaryTextColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoPage(_devices[i]),
                      ));
                },
                onLongPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) => BooleanDialog(
                      'Remove Device',
                      onPressedYes: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          removeDevice(i);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            );
          },
          itemCount: _devices.length,
        ),
      );
    else
      body = Center(
        child: Text('No Device Connected'),
      );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Center(
            child: InkWell(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: kPrimaryBgColor,
                child: Icon(
                  Icons.sync,
                  color: kPrimaryTextColor,
                  size: 30,
                ),
              ),
              onTap: () {
                Future future;
                if (_newData)
                  future = Network.uploadData();
                else
                  future = Network.syncData(_devices);
                showDialog(
                  context: context,
                  builder: (context) => FutureDialog<void>(
                    future: future,
                  ),
                );
              },
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            color: kPrimarySelectionColor,
            iconSize: 35,
            onPressed: () {
              showSearchDialog();
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  void removeDevice(int i) async {
    await showDialog(
      context: context,
      builder: (context) => FutureDialog<void>(
        future: MainProfile.removeConnectedDevice(_devices[i].id),
        hasData: (_) => CommonAlertDialog(
          'Removed Device',
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _devices.removeLast();
              });
            });
            Navigator.pop(context);
          },
        ),
        loadingText: 'Removing...',
      ),
    );
  }

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool _loading = true;
        List<Widget> deviceTiles = [];
        Network.searchDevices();
        Future.delayed(Duration(seconds: 4, milliseconds: 500))
            .then((value) => _loading = false);
        return StreamBuilder<List<StationInfo>>(
          stream: Network.availableDevicesSnapshot,
          builder: (context, snapshot) {
            if (snapshot.hasData && _loading) {
              deviceTiles = [];
              for (var device in snapshot.data) {
                if (!_devices.contains(device))
                  deviceTiles.add(
                    InkWell(
                      child: Container(
                        width: screenWidth * 0.5,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(device.name),
                          ],
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          if (!_devices.contains(device)) {
                            _devices.add(device);
                          }
                        });
                        await showDialog(
                          context: context,
                          builder: (context) => FutureDialog(
                            future: MainProfile.setDevices(_devices),
                            hasData: (_) {
                              return CommonAlertDialog(
                                'Device Added',
                              );
                            },
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  );
              }
            }
            List<Widget> content = [];
            if (!_loading && deviceTiles.length == 0)
              content.add(Text('NO DEVICE FOUND'));
            for (var deviceTile in deviceTiles) {
              content.add(deviceTile);
              content.add(Divider());
            }
            if (_loading) {
              content.add(
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: screenWidth * 0.5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Searching...'),
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: FittedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return AlertDialog(
              title: Text(
                'Devices',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: content,
              ),
              actions: [
                FlatButton(
                  child: Text('Search'),
                  onPressed: () {
                    _loading = true;
                    Network.searchDevices();
                    Future.delayed(Duration(seconds: 5))
                        .then((value) => _loading = false);
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Widget loadHomePageData() {
  log('loading home page', name: 'loadHomePageData');
  return LoadingScreen<List<StationInfo>>(
    future: MainProfile.getConnectedDevice(),
    func: (connectedDevices) {
      List<StationInfo> devices = [];
      devices.addAll(connectedDevices);
      return HomePage(devices: devices);
    },
  );
}

Widget openHomePage() {
  log('opening home page', name: 'openHomePage');
  return LoadingScreen<String>(
      future: MainProfile.name,
      func: (name) {
        if (name != null) return loadHomePageData();
        return SignUpPage();
      });
}

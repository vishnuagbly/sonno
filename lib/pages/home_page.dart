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

  final List<DeviceInfo> devices;

  @override
  _HomePageState createState() => _HomePageState(devices);
}

class _HomePageState extends State<HomePage> {
  List<DeviceInfo> _devices = [];
  Widget body;

  _HomePageState(List<DeviceInfo> devices) : _devices = devices ?? [];

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
                        (_devices[i].name).toUpperCase(),
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
                    builder: (context) => AlertDialog(
                      title: Text(
                        'What do you want',
                        style: TextStyle(
                          fontSize: alertDialogTitleTextSize(screenWidth),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Color(kAlertDialogBackgroundColorCode),
                      elevation: kAlertDialogElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(kAlertDialogBorderRadius),
                      ),
                      actions: [
                        FlatButton(
                          child: Text('Rename'),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showRenameDeviceDialog(i);
                            });
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('Delete'),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              removeDevice(i);
                            });
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
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
                    loadingText: 'Uploading to Cloud...',
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
              icon: Icon(Icons.invert_colors),
              color: kPrimaryTextColor,
              iconSize: 35,
              onPressed: () {
                showColorBlindDialog();
              }),
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

  void showRenameDeviceDialog(int i) async {
    double screenWidth = MediaQuery.of(context).size.width;
    String deviceName = _devices[i].name;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(kAlertDialogBackgroundColorCode),
        title: Text(
          'Rename Device',
          style: TextStyle(
            fontSize: alertDialogTitleTextSize(screenWidth),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kAlertDialogBorderRadius)),
        elevation: kAlertDialogElevation,
        content: TextField(
          style: TextStyle(
            fontSize: screenWidth * 0.05,
          ),
          decoration: InputDecoration(
            fillColor: Color(0x10ffffff),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            hintText: _devices[i].name,
          ),
          onChanged: (value) => deviceName = value,
          onSubmitted: (value) => renameDevice(_devices[i].id, value, context),
        ),
        actions: [
          FlatButton(
            child: Text('Submit'),
            onPressed: () => renameDevice(_devices[i].id, deviceName, context),
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> renameDevice(
      String id, String name, BuildContext context) async {
    setStationName(id, name);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => FutureDialog(
          future: MainProfile.setDevices(_devices),
          hasData: (_) => CommonAlertDialog(
            'Renamed Successfully',
          ),
        ),
      );
    });
    Navigator.pop(context);
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
                _devices.removeAt(i);
              });
            });
            Navigator.pop(context);
          },
        ),
        loadingText: 'Removing...',
      ),
    );
  }

  void showColorBlindDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: Text('Are you color blind?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: List.generate(
                        ColorBlindTypes.all.length - 1,
                        (index) => RadioListTile<ColorBlindType>(
                          value: ColorBlindTypes.all[index],
                          groupValue: MainProfile.colorBlindType,
                          onChanged: (type) {
                            setDialogState(() {
                              MainProfile.colorBlindType = type;
                            });
                          },
                          title: Text(
                              'Yes I have ${ColorBlindTypes.all[index].text} Color Blindness.'),
                        ),
                      ),
                    ),
                    RadioListTile<ColorBlindType>(
                      value: ColorBlindTypes.normal,
                      groupValue: MainProfile.colorBlindType,
                      onChanged: (type) {
                        setDialogState(() {
                          MainProfile.colorBlindType = type;
                        });
                      },
                      title: Text('No, I have Normal Eyes.'),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        bool _loading = true;
        bool dialogOpened = true;
        List<Widget> deviceTiles = [];
        return StatefulBuilder(
          builder: (context, setDialogState) {
            double screenWidth = MediaQuery.of(context).size.width;
            Network.searchDevices();
            Future.delayed(Duration(seconds: 4, milliseconds: 500))
                .then((value) {
              if (dialogOpened) setDialogState(() => _loading = false);
            });
            return StreamBuilder<List<DeviceInfo>>(
              stream: Network.availableDevicesSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData && _loading) {
                  deviceTiles = [];
                  for (int i = 0; i < snapshot.data.length; i++) {
                    var device = snapshot.data[i];
                    if (!_devices.contains(device)) {
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
                            log('adding device', name: 'onTap/deviceTile');
                            setState(() {
                              if (!_devices.contains(device)) {
                                _devices.add(device);
                              }
                            });
                            log('showing dialog', name: 'onTap/deviceTile');
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
                            log('popping searchDialog',
                                name: 'onTap/deviceTile');
                            dialogOpened = false;
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }
                  }
                }
                List<Widget> content = [];
                if (!_loading && deviceTiles.length == 0)
                  content.add(FutureBuilder<bool>(
                    future: Network.checkWifi(),
                    builder: (context, snapshot) {
                      String text = 'NO DEVICE FOUND';
                      if (snapshot.hasData) if (!snapshot.data)
                        text = 'NO WIFI FOUND';
                      return Text(text);
                    },
                  ));
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
      },
    );
  }
}

Widget loadHomePageData() {
  log('loading home page', name: 'loadHomePageData');
  return LoadingScreen<List<DeviceInfo>>(
    future: MainProfile.getConnectedDevice(),
    func: (connectedDevices) {
      List<DeviceInfo> devices = [];
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

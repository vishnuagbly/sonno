import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonno/aqi_info_page.dart';
import 'package:sonno/network.dart';
import 'constants.dart';
import 'objects/device.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Device> _devices = [];
  Widget body;

  @override
  void dispose() {
    Network.close();
    super.dispose();
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
                        _devices[i].name.toUpperCase(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      Text(
                        'ID: 000${_devices[i].id.toString()}',
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
                        builder: (context) => InfoPage(_devices[i].name),
                      ));
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
            child: CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryBgColor,
              child: Icon(
                Icons.person_outline,
                color: kPrimaryTextColor,
                size: 30,
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Me'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
        Future.delayed(Duration(seconds: 5)).then((value) => _loading = false);
        return StreamBuilder<List<Device>>(
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
                            Text('${device.name}'),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (!_devices.contains(device)) _devices.add(device);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
              }
            }
            List<Widget> content = [];
            if (!_loading && deviceTiles.length == 0)
              content.add(Text('WE GOT NOTHING'));
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

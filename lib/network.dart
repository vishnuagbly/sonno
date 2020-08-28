import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sonno/objects/connecting_dummy_data.dart';
import 'package:sonno/objects/dummy_data.dart';
import 'package:firebase_core/firebase_core.dart';

import 'objects/device.dart';

class Network {
  static var _firestore = FirebaseFirestore.instance;
  static var _dataMap = dummyMap;

  static List<Device> _devices = [];

  static StreamController<List<Device>> _devicesController =
      StreamController<List<Device>>.broadcast();

  static close() => _devicesController.close();

  static Stream<List<Device>> get availableDevicesSnapshot =>
      _devicesController.stream;

  static Future<void> uploadData() async {
    await _firestore.collection('allData').doc('data').set(_dataMap);
  }

  static Future<bool> checkWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.wifi)
      return true;
    return false;
  }

  static void initApp() async {
    await Firebase.initializeApp();
  }

  static void searchDevices() async {
    await checkWifi();
    clearDevices();
    List<Device> devices = [
      Device(1, stations[0], name: 'Anand Bihar'),
      Device(2, stations[1]),
      Device(3, stations[2], name: 'Rampur'),
    ];

    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(seconds: 2))
          .then((value) {
            if(!_devices.contains(devices[i])){
              _devices.add(devices[i]);
              _devicesController.add(_devices);
            }
          });
    }
  }

  static void clearDevices() {
    _devices.clear();
    _devicesController.add(_devices);
  }

  static bool checkIfDataUpdated() => false;
}

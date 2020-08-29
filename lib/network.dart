import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/connecting_dummy_data.dart';
import 'package:firebase_core/firebase_core.dart';

import 'objects/device.dart';

class Network {
  static var _firestore = FirebaseFirestore.instance;
  static String _authId;
  static List<Device> _devices = [];

  static StreamController<List<Device>> _devicesController =
      StreamController<List<Device>>.broadcast();

  static close() => _devicesController.close();

  static Stream<List<Device>> get availableDevicesSnapshot =>
      _devicesController.stream;

  static Future<void> uploadData() async {
    for (var station in stations) {
      await _firestore
          .collection(kStationsCollectionName)
          .doc(station.id)
          .set(station.toMap());
      for (var aqiInfo in station.data) {
        await _firestore
            .doc(
                '${pathToDataSubCollection(station.id)}/${aqiInfo.dateTime.toIso8601String()}')
            .set(aqiInfo.toMap());
      }
    }
  }

  static Future<void> syncData() async {
    for (var device in _devices) {
      var station = device.stationInfo;
      await _firestore
          .collection(kStationsCollectionName)
          .doc(station.id)
          .set(station.toMap());
    }
  }

  static setAuthId(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    _authId = uuid;
    await prefs.setString('uuid', uuid);
  }

  static Future<bool> get signedIn async {
    if (_authId == null) {
      await getAndSetAuthId();
      if (_authId == null) return false;
    }
    return true;
  }

  static Future<void> getAndSetAuthId() async {
    final prefs = await SharedPreferences.getInstance();
    _authId = prefs.getString('uuid');
  }

  static Future<bool> checkWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) return true;
    return false;
  }

  static void initApp() async {
    await Firebase.initializeApp();
  }

  static void searchDevices() async {
    await checkWifi();
    clearDevices();
    List<Device> devices = [
      Device(1, stations.firstWhere((element) => element.id == 'MP001')),
      Device(2, stations.firstWhere((element) => element.id == 'AS001')),
      Device(3, stations.firstWhere((element) => element.id == 'DL008')),
    ];

    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(seconds: 2)).then((value) {
        if (!_devices.contains(devices[i])) {
          _devices.add(devices[i]);
          _devicesController.add(_devices);
        }
      });
    }
  }

  static void clearDevices() {
    if (_devices.length > 0) _devices.clear();
    _devicesController.add(_devices);
  }

  static bool checkIfDataUpdated() => false;
}

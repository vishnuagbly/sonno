import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/connecting_dummy_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sonno/objects/objects.dart';

class Network {
  static var _firestore = FirebaseFirestore.instance;
  static List<StationInfo> _devices = [];

  static StreamController<List<StationInfo>> _devicesController =
      StreamController<List<StationInfo>>.broadcast();

  static close() => _devicesController.close();

  static Stream<List<StationInfo>> get availableDevicesSnapshot =>
      _devicesController.stream;

  static Future<void> uploadData() async {
    log('running transaction to upload all data', name: uploadData.toString());
    await _firestore.runTransaction((txn) async {
      for (var station in stations) {
        if (station.id == null) throw 'station id is null';
        txn.set(_firestore.collection(kStationsCollectionName).doc(station.id),
            station.toMap());
      }
    });
    var batch = _firestore.batch();
    for (var station in stations) {
      for (var aqiInfo in station.data) {
        batch.set(
            _firestore.doc(
                '${pathToDataSubCollection(station.id)}/${aqiInfo.dateTime.toIso8601String()}'),
            aqiInfo.toMap());
      }
    }
    await batch.commit();
  }

  static Future<void> syncData(List<StationInfo> devices) async {
    for (var device in devices) {
      await _firestore
          .collection(kStationsCollectionName)
          .doc(device.id)
          .set(device.toMap());
    }
  }

  static Future<List<String>> getStationsNames(List<String> ids) async {
    List<String> res = [];
    for (var id in ids) res.add(await getStationName(id));
    return res;
  }

  static Future<String> getStationName(String id) async {
    return (await _firestore.collection(kStationsCollectionName).doc(id).get())
        .data()['StationName'];
  }

  static Future<bool> checkWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) return true;
    return false;
  }

  static Future<void> initApp() async {
    await Firebase.initializeApp();
  }

  static void searchDevices() async {
    await checkWifi();
    clearDevices();
    List<StationInfo> devices = [
      stations.firstWhere((element) => element.id == 'MP001'),
      stations.firstWhere((element) => element.id == 'AS001'),
      stations.firstWhere((element) => element.id == 'DL008')
    ];

    devices[0].name = null;

    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(seconds: 1)).then((value) {
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

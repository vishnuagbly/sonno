import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonno/objects/objects.dart';

class MainProfile {
  static String _name;
  static String _authId;
  static List<StationInfo> _connectedDevices;

  static String get email => FirebaseAuth.instance.currentUser.email;

  static Future<String> get name async {
    if (_name == null) {
      final prefs = await SharedPreferences.getInstance();
      _name = prefs.getString('name');
    }
    return _name;
  }

  static Future<List<StationInfo>> getConnectedDevice() async {
    String logName = 'connectedDevice';
    log('getting connected Devices', name: logName);
    if (_connectedDevices == null || _connectedDevices.length == 0) {
      final prefs = await SharedPreferences.getInstance();
      int totalConnectedDevices = prefs.getInt('totalConnectedDevices') ?? 0;
      log('total devices: $totalConnectedDevices', name: logName);
      _connectedDevices = [];
      for (int i = 0; i < totalConnectedDevices; i++) {
        String id = prefs.getString('device[$i]_id');
        log('$i device id = $id', name: logName);
        _connectedDevices.add(stations.firstWhere((e) => e.id == id));
        log('  old name = ${_connectedDevices.last.name}', name: logName);
        _connectedDevices.last.name = prefs.getString('device[$i]_name');
        log('  new name = ${_connectedDevices.last.name}', name: logName);
        setStationName(id, _connectedDevices.last.name);
      }
    }
    return _connectedDevices;
  }

  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _name = name;
    await prefs.setString('name', _name);
  }

  static setDevices(List<StationInfo> connectedDevices) async {
    await _deleteAllConnectedDevicesFromCache();
    _connectedDevices = [];
    _connectedDevices.addAll(connectedDevices);
    _setConnectedDevicesInCache();
  }

  static Future<void> removeConnectedDevice(String id) async {
    await _deleteAllConnectedDevicesFromCache();
    for(int i = 0; i < _connectedDevices.length; i++){
      if(_connectedDevices[i].id == id){
        _connectedDevices.removeAt(i);
        break;
      }
    }
    _setConnectedDevicesInCache();
  }

  static Future<void> _deleteAllConnectedDevicesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    int totalDevices = prefs.getInt('totalConnectedDevices');
    for(int i = 0; i < totalDevices; i++){
      prefs.remove('device[$i]_id');
      prefs.remove('device[$i]_name');
    }
  }

  static Future<void> _setConnectedDevicesInCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalConnectedDevices', _connectedDevices.length);
    for (int i = 0; i < _connectedDevices.length; i++) {
      await prefs.setString('device[$i]_id', _connectedDevices[i].id);
      await prefs.setString('device[$i]_name', _connectedDevices[i].name);
    }
  }

  static setAuthId(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    _authId = uuid;
    await prefs.setString('uuid', uuid);
  }

  static Future<bool> get signedIn async {
    if (_authId == null) {
      await MainProfile.getAndSetAuthId();
      if (_authId == null) return false;
    }
    return true;
  }

  static Future<void> getAndSetAuthId() async {
    final prefs = await SharedPreferences.getInstance();
    _authId = prefs.getString('uuid');
  }

  static String get authId => _authId;
}

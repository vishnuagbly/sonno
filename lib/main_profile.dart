import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonno/network.dart';
import 'package:sonno/objects/objects.dart';

class MainProfile {
  static String _name;
  static String _authId;
  static List<StationInfo> _connectedDevices;

  static setProfile(String name, String uuid, List<StationInfo> connectedDevices) {

  }

  static Future<String> get name async {
    if(_name == null) {
      final prefs = await SharedPreferences.getInstance();
      _name = prefs.getString('name');
    }
    return _name;
  }

  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _name = name;
    await prefs.setString('name', _name);
  }

  static setDevices(List<StationInfo> connectedDevices) async {
    final prefs = await SharedPreferences.getInstance();
    _connectedDevices = connectedDevices;
    await Network.syncData();
    await prefs.setInt('totalConnectedDevices', _connectedDevices.length);
    for(int i = 0; i < _connectedDevices.length; i++) {
      await prefs.setString('device[$i]', _connectedDevices[i].id);
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
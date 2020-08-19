import 'dart:async';

import 'objects/device.dart';

class Network {

  static List<Device> _devices = [];

  static StreamController<List<Device>> _devicesController =
      StreamController<List<Device>>.broadcast();

  static close() => _devicesController.close();

  static Stream<List<Device>> get availableDevicesSnapshot =>
      _devicesController.stream;

  static void searchDevices() async {
    clearDevices();
    List<Device> devices = [
      Device('Anand Vihar', 1),
      Device('Device 1', 2),
      Device('Rampur', 3),
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
}

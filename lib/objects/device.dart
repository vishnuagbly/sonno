import 'package:sonno/objects/station_info.dart';

class Device {
  String name;
  int id;
  StationInfo stationInfo;

  Device(
    this.id,
    this.stationInfo, {
    this.name,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Device && other.id == this.id;
}

import '../constants.dart';

enum Parameter {
  pm25,
  pm10,
  no2,
  nh3,
  co,
  so3,
  o3,
  aqi,
}

extension names on Parameter {
  String get name => parameters[this.index];
}
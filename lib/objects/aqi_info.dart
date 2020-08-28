import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';

import 'parameter.dart';

class AqiInfo {
  final DateTime dateTime;
  final double pm25;
  final double pm10;
  final double no2;
  final double nh3;
  final double co;
  final double so2;
  final double o3;
  final double aqi;
  final String aqiBucket;

  AqiInfo({
    this.dateTime,
    this.pm25,
    this.pm10,
    this.nh3,
    this.no2,
    this.co,
    this.aqi,
    this.aqiBucket,
    this.o3,
    this.so2,
  });

  factory AqiInfo.fromMap(Map<String, dynamic> map) {
    return AqiInfo(
      dateTime: DateTime.parse(map['Datetime']),
      pm10: map['PM10'],
      pm25: map['PM2.5'],
      no2: map['NO2'],
      nh3: map['NH3'],
      co: map['CO'],
      so2: map['SO2'],
      o3: map['O3'],
      aqi: map['AQI'],
      aqiBucket: map['AQI_Bucket'],
    );
  }

  static List<AqiInfo> fromListOfMaps(List<dynamic> maps) {
    List<AqiInfo> res = [];
    for (var map in maps) res.add(AqiInfo.fromMap(map));
    return res;
  }

  static String getStatusFromAqi(double aqi) {
    if (aqi > 400) return 'Hazardous';
    if (aqi > 300) return 'Severe';
    if (aqi > 200) return 'Unhealthy';
    if (aqi > 100) return 'Poor';
    if (aqi > 50) return 'Moderate';
    return 'Good';
  }

  double getValueFromParameter(Parameter parameter) =>
      getValueFromParameterIndex(parameter.index);

  double getValueFromParameterIndex(int index) {
    if (index < 0 || index >= parameters.length) return 0;
    if (index == 0) return pm25;
    if (index == 1) return pm10;
    if (index == 2) return no2;
    if (index == 3) return nh3;
    if (index == 4) return co;
    if (index == 5) return so2;
    if (index == 6) return o3;
    return aqi;
  }

  static Color getColorForValue(double value) {
    if (value > 400) return Colors.red;
    if (value > 300) return Colors.deepPurple;
    if (value > 200) return Colors.pink;
    if (value > 100) return Colors.orange;
    if (value > 50) return Colors.yellow;
    return Colors.green;
  }
}

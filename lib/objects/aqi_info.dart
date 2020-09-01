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

  Map<String, dynamic> toMap() => {
    'Datetime': dateTime.toIso8601String(),
    'PM10': pm10,
    'NO2': no2,
    'PM2.5': pm25,
    'NH3': nh3,
    'CO': co,
    'SO2': so2,
    'O3': o3,
    'AQI': aqi,
    'AQI_Bucket': aqiBucket,
  };

  static List<AqiInfo> fromListOfMaps(List<dynamic> maps) {
    List<AqiInfo> res = [];
    for (var map in maps) res.add(AqiInfo.fromMap(map));
    return res;
  }

  static String getStatusFromAqi(double aqi) {
    if (aqi > 400) return statuses[5].text;
    if (aqi > 300) return statuses[4].text;
    if (aqi > 200) return statuses[3].text;
    if (aqi > 100) return statuses[2].text;
    if (aqi > 50) return statuses[1].text;
    return statuses[0].text;
  }

  double getValueFromParameter(Parameter parameter) {
    if(parameter == Parameters.aqi) return aqi;
    else if(parameter == Parameters.co) return co;
    else if(parameter == Parameters.pm25) return pm25;
    else if(parameter == Parameters.nh3) return nh3;
    else if(parameter == Parameters.no2) return no2;
    else if(parameter == Parameters.pm10) return pm10;
    else if(parameter == Parameters.o3) return o3;
    else return so2;
  }
}

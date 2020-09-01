import 'package:sonno/components/bar_chart.dart';
import 'package:sonno/objects/aqi_info.dart';

import 'parameter.dart';

class StationInfo {
  final String id;
  final int _hashCode;
  final double lat;
  final double lng;
  final String status;
  final String city;
  final String state;
  String _name;
  List<AqiInfo> data;

  set name(String name) => _name = name;

  String get name {
    if(_name != null) return _name;
    return 'Device $_hashCode';
  }

  @override
  int get hashCode => _hashCode;

  @override
  bool operator ==(Object other) => other is StationInfo && other.id == this.id;

  StationInfo.raw(
    this._hashCode, {
    this.id,
    this.lat,
    this.lng,
    this.status,
    this.state,
    String name,
    this.data,
    this.city,
  }) : _name = name;

  factory StationInfo.fromMap(Map<String, dynamic> map, int hashCode) {
    var tempDataMap = map['data'];
    var tempData;
    if (tempDataMap != null) tempData = AqiInfo.fromListOfMaps(tempDataMap);

    return StationInfo.raw(
      hashCode,
      id: map['StationId'],
      name: map['StationName'],
      city: map['City'],
      state: map['State'],
      status: map['Status'],
      lat: map['lat'],
      lng: map['lng'],
      data: tempData,
    );
  }

  Map<String, dynamic> toMap() => {
        'StationId': id,
        'StationName': name,
        'City': city,
        'State': state,
        'lat': lat,
        'lng': lng,
      };

  static List<StationInfo> fromListOfMaps(List<dynamic> maps) {
    List<StationInfo> res = [];
    for (int i = 0; i < maps.length; i++) {
      var stationInfoMap = maps[i];
      res.add(StationInfo.fromMap(stationInfoMap, i));
    }
    return res;
  }

  List<double> get allAvgParameters {
    List<double> res = [];
    Parameters.values.forEach((element) {
      res.add(getAvg(element));
    });
    return res;
  }

  List<double> allMaxParameters({int lastHours = 24}) {
    List<double> res = [];
    Parameters.values.forEach((element) {
      res.add(getMax(element, lastHours: lastHours));
    });
    return res;
  }

  List<BarChartData> getAllBarChartData(Parameter parameter, int lastHours) {
    return [
      BarChartData('Min', getMin(parameter, lastHours: lastHours)),
      BarChartData('Max', getMax(parameter, lastHours: lastHours)),
      BarChartData('Avg', getAvg(parameter, lastHours: lastHours)),
    ];
  }

  double getAvg(Parameter parameter, {int lastHours = 24}) {
    if (data == null) return 0;
    double res = 0;
    int totalDataConsidered = 0;
    for (var info in data) {
      if (info.dateTime.difference(data[0].dateTime).inHours <= lastHours) {
        res += info.getValueFromParameter(parameter);
        totalDataConsidered++;
      }
    }
    return res / totalDataConsidered;
  }

  double getMin(Parameter parameter, {int lastHours = 24}) {
    if (data == null || data.length == 0) return 0;
    double res = data[0].getValueFromParameter(parameter);
    for (var info in data)
      if (info.getValueFromParameter(parameter) < res &&
          info.dateTime.difference(data[0].dateTime).inHours <= lastHours)
        res = info.getValueFromParameter(parameter);
    return res;
  }

  double getMax(Parameter parameter, {int lastHours = 24}) {
    if (data == null || data.length == 0) return 0;
    double res = data[0].getValueFromParameter(parameter);
    for (var info in data)
      if (info.getValueFromParameter(parameter) > res &&
          info.dateTime.difference(data[0].dateTime).inHours <= lastHours)
        res = info.getValueFromParameter(parameter);
    return res;
  }
}

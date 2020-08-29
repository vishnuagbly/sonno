import 'package:sonno/bar_chart.dart';
import 'package:sonno/objects/aqi_info.dart';

import 'parameter.dart';

class StationInfo {
  final String id;
  final double lat;
  final double lng;
  final String status;
  final String city;
  final String state;
  final String stationName;
  List<AqiInfo> data;

  StationInfo.raw({
    this.id,
    this.lat,
    this.lng,
    this.status,
    this.state,
    this.stationName,
    this.data,
    this.city,
  });

  factory StationInfo.fromMap(Map<String, dynamic> map) {
    var tempDataMap = map['data'];
    var tempData;
    if(tempDataMap != null)
      tempData = AqiInfo.fromListOfMaps(tempDataMap);

    return StationInfo.raw(
      id: map['StationId'],
      stationName: map['StationName'],
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
    'StationName': stationName,
    'City': city,
    'State': state,
    'lat': lat,
    'lng': lng,
  };

  static List<StationInfo> fromListOfMaps(List<dynamic> maps) {
    List<StationInfo> res = [];
    for (var stationInfoMap in maps) {
      res.add(StationInfo.fromMap(stationInfoMap));
    }
    return res;
  }

  List<double> get allAvgParameters {
    List<double> res = [];
    Parameter.values.forEach((element) {
      res.add(getAvg(element));
    });
    return res;
  }

  List<double> allMaxParameters({int lastHours = 24}) {
    List<double> res = [];
    Parameter.values.forEach((element) {
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

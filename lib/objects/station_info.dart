import 'package:sonno/bar_chart.dart';
import 'package:sonno/objects/aqi_info.dart';

import 'Parameter.dart';

class StationInfo {
  final String stationId;
  final double lat;
  final double lng;
  final String status;
  final String city;
  final String state;
  final String stationName;
  final List<AqiInfo> data;

  StationInfo.raw({
    this.stationId,
    this.lat,
    this.lng,
    this.status,
    this.state,
    this.stationName,
    this.data,
    this.city,
  });

  factory StationInfo.fromMap(Map<String, dynamic> map) {
    return StationInfo.raw(
      stationId: map['StationId'],
      stationName: map['StationName'],
      city: map['City'],
      state: map['State'],
      status: map['Status'],
      lat: map['lat'],
      lng: map['lng'],
      data: AqiInfo.fromListOfMaps(map['data']),
    );
  }

  static List<StationInfo> fromListOfMaps(List<dynamic> maps) {
    List<StationInfo> res = [];
    for (var stationInfoMap in maps) {
      res.add(StationInfo.fromMap(stationInfoMap));
    }
    return res;
  }

  List<double> get allAvgAqi {
    List<double> res = [];
    Parameter.values.forEach((element) {
      res.add(getAvg(element));
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
    for (var info in data)
      if (info.dateTime.difference(data[0].dateTime).inHours <= lastHours)
        res += info.getValueFromParameter(parameter);
    return res / data.length;
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

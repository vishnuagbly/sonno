import 'package:sonno/objects/dummy_data.dart';

import 'station_info.dart';

List<StationInfo> allStationDummyData = [];

List<StationInfo> get stations {
  if (allStationDummyData.length > 50) return allStationDummyData;
  List<StationInfo> res = [];
  res.addAll(StationInfo.fromListOfMaps(dummyMap['Stations']));
  return res;
}

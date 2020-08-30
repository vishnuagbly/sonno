import 'package:sonno/objects/dummy_data.dart';

import 'station_info.dart';

List<StationInfo> allStationDummyData = [];

List<StationInfo> get stations {
  if (allStationDummyData.length < 50)
    allStationDummyData = StationInfo.fromListOfMaps(dummyMap['Stations']);
  return allStationDummyData;
}

void setStationName(String id, String name) {
  for(int i = 0; i < allStationDummyData.length; i++)
    if(allStationDummyData[i].id == id)
      allStationDummyData[i].name = name;
}

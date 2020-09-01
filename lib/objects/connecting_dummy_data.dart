import 'package:sonno/objects/dummy_data.dart';

import 'station_info.dart';

List<DeviceInfo> allStationDummyData = [];

List<DeviceInfo> get stations {
  if (allStationDummyData.length < 50)
    allStationDummyData = DeviceInfo.fromListOfMaps(dummyMap['Stations']);
  return allStationDummyData;
}

void setStationName(String id, String name) {
  for(int i = 0; i < allStationDummyData.length; i++)
    if(allStationDummyData[i].id == id)
      allStationDummyData[i].name = name;
}

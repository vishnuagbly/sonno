import 'package:sonno/objects/dummy_data.dart';

import 'device_info.dart';

List<DeviceInfo> allStationDummyData = [];

List<DeviceInfo> get stations {
  if (allStationDummyData == null || allStationDummyData.length == 0) {
    allStationDummyData = DeviceInfo.fromListOfMaps(dummyMap['Stations']);
    stations.forEach((element) {
      if(element.id == 'MP001' || element.id == 'AS001' || element.id == 'DL008')
        element.name = null;
    });
  }
  return allStationDummyData;
}

void setStationName(String id, String name) {
  for (int i = 0; i < allStationDummyData.length; i++)
    if (allStationDummyData[i].id == id) allStationDummyData[i].name = name;
}

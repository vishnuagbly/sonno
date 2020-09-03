import 'package:flutter/material.dart';
import 'package:sonno/objects/objects.dart';

class HealthAdvice extends StatelessWidget {
  HealthAdvice(this.stationInfo);

  final DeviceInfo stationInfo;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Status aqiStatus = Parameters.aqi.status(stationInfo.data.last.aqi);
    return Container(
      height: screenHeight * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(screenHeight * 0.04),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(screenHeight * 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Advices.airPurifier.build(aqiStatus),
                    Advices.pollutionMask.build(aqiStatus),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Advices.outdoorActivities.build(aqiStatus),
                    Advices.ventilation.build(aqiStatus),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Advices.kids.build(aqiStatus),
        ],
      ),
    );
  }
}
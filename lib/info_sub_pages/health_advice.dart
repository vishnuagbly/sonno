import 'package:flutter/material.dart';
import 'package:sonno/objects/parameter.dart';
import 'package:sonno/objects/station_info.dart';

class HealthAdvice extends StatelessWidget {
  HealthAdvice(this.stationInfo);

  final StationInfo stationInfo;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool ventilation = true;
    if(stationInfo.getAvg(Parameter.aqi) > 100)
      ventilation = false;
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
                    Advice(
                      imageProvider: AssetImage('assets/air-filter.png'),
                      name: 'Air Purifier',
                      adviceText: 'Corona No need',
                    ),
                    Advice(
                      imageProvider: AssetImage('assets/face-mask.png'),
                      name: 'Pollution Mask',
                      adviceText: 'Covid 19',
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Advice(
                      imageProvider: AssetImage('assets/hiking.png'),
                      name: 'Outdoor Activities',
                      adviceText: 'Covid 19',
                    ),
                    Advice(
                      imageProvider: AssetImage('assets/ventilation.png'),
                      name: 'Ventilation',
                      adviceText: ventilation ? 'Ichha Annusar': 'Not Recommended',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Advice(
            imageProvider: AssetImage('assets/family.png'),
            name: 'Kids, Pregnant Woman & Senior Citizen',
            adviceText: ventilation ? 'Do whatever they want' : 'Not Recommend outside',
          ),
        ],
      ),
    );
  }
}

class Advice extends StatelessWidget {
  Advice({
    @required this.imageProvider,
    @required this.name,
    @required this.adviceText,
  });

  final ImageProvider imageProvider;
  final String name;
  final String adviceText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Image(
          image: imageProvider,
          width: screenWidth * 0.1,
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          name,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(adviceText),
      ],
    );
  }
}

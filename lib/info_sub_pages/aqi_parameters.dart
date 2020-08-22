import 'package:flutter/material.dart';
import 'package:sonno/extensions/double_extensions.dart';
import 'package:sonno/objects/Parameter.dart';
import 'package:sonno/objects/aqi_info.dart';
import 'package:sonno/objects/station_info.dart';

import '../constants.dart';

class AqiParameters extends StatelessWidget {
  AqiParameters(this.stationInfo);

  final StationInfo stationInfo;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          child: Column(
            children: List.generate(
              5,
              (index) {
                int flex = stationInfo.allAvgAqi[index].toInt();
                int max = stationInfo.allAvgAqi.getMax(
                  exclude: [stationInfo.getAvg(Parameter.aqi)],
                ).toInt();
                max += max ~/ 10;
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    flex.toString(),
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.06,
                                    ),
                                  ),
                                  Text(' ug/m3'),
                                ],
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              Text(
                                '${parameters[index]}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 15,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: flex,
                                  child: Container(
                                    color: AqiInfo.getColorForValue(
                                        flex.toDouble()),
                                  ),
                                ),
                                Expanded(
                                  flex: max - flex,
                                  child: Container(
                                    color: Colors.white12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

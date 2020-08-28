import 'package:flutter/material.dart';
import 'package:sonno/bar_chart.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/parameter.dart';
import 'package:sonno/objects/aqi_info.dart';
import 'package:sonno/objects/station_info.dart';

class DashBoard extends StatefulWidget {
  DashBoard(this.stationInfo);

  final StationInfo stationInfo;

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Parameter _parameter = Parameter.aqi;
  int _lastHours = 24;

  static const List<int> _lastHoursOpts = [
    24,
    15,
    10,
    5,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      height: screenWidth - 80,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<Parameter>(
                value: _parameter,
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    _parameter = value;
                  });
                },
                items: List.generate(
                  parameters.length,
                  (index) => DropdownMenuItem(
                    value: Parameter.values.elementAt(index),
                    child: Text(
                      parameters[index],
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
              DropdownButton<int>(
                value: _lastHours,
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    _lastHours = value;
                  });
                },
                items: List.generate(
                  _lastHoursOpts.length,
                  (index) => DropdownMenuItem(
                    value: _lastHoursOpts[index],
                    child: Text(
                      'last ${_lastHoursOpts[index].toString()} hours',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Flexible(
            child: BarChart(
              barChartDataGenerator(
                widget.stationInfo.getAllBarChartData(_parameter, _lastHours),
                color: AqiInfo.getColorForValue(
                  widget.stationInfo.getAvg(_parameter),
                ),
              ),
              true,
              MediaQuery.of(context),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sonno/extensions/double_extensions.dart';
import 'package:sonno/objects/parameter.dart';
import 'package:sonno/objects/station_info.dart';

class AqiParameters extends StatefulWidget {
  AqiParameters(this.stationInfo);

  final StationInfo stationInfo;

  @override
  _AqiParametersState createState() => _AqiParametersState();
}

class _AqiParametersState extends State<AqiParameters> {
  Parameter _parameter = Parameters.aqi;
  int _lastHours = 24;

  static const List<int> _lastHoursOpts = [
    24,
    15,
    10,
    5,
  ];

  static const List<String> _type = [
    'Avg',
    'Max',
    'Min',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
                  Parameters.values.length,
                  (index) => DropdownMenuItem(
                    value: Parameters.values.elementAt(index),
                    child: Text(
                      Parameters.values[index].name,
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
          Column(
            children: List.generate(
              3,
              (index) {
                double flex = getFlex(index);
                int max = widget.stationInfo
                    .allMaxParameters(lastHours: _lastHours)
                    .getMax(
                  exclude: [widget.stationInfo.getAvg(Parameters.aqi)],
                ).toInt();
                String text = ' \u03bcg/m\u00B3';
                if (_parameter == Parameters.aqi)
                  text = '';
                else if (_parameter == Parameters.co) text = ' mg/m\u00B3';
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
                                    flex.toInt().toString(),
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.06,
                                    ),
                                  ),
                                  Text(text, style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                  ),),
                                ],
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              Text(
                                _type[index],
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
                                  flex: flex.toInt(),
                                  child: Container(
                                    color: _parameter.status(flex).color,
                                  ),
                                ),
                                Expanded(
                                  flex: max - flex.toInt(),
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
        ],
      ),
    );
  }

  double getFlex(int index) {
    if (index == 0)
      return widget.stationInfo
          .getAvg(_parameter, lastHours: _lastHours);
    if (index == 1)
      return widget.stationInfo
          .getMax(_parameter, lastHours: _lastHours);
    return widget.stationInfo.getMin(_parameter, lastHours: _lastHours);
  }
}

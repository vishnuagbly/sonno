import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/info_sub_pages/aqi_parameters.dart';
import 'package:sonno/info_sub_pages/dashboard.dart';
import 'package:sonno/objects/aqi_info.dart';
import 'package:sonno/objects/station_info.dart';

import 'color_guide.dart';
import 'objects/Parameter.dart';

class InfoPage extends StatefulWidget {
  InfoPage(this.stationInfo);

  final StationInfo stationInfo;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.stationInfo.stationName,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.stationInfo.city}, ${widget.stationInfo.state}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.white54,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Air Quality Index',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                                Text(
                                  widget.stationInfo
                                      .getAvg(Parameter.aqi)
                                      .toInt()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.25,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                Text(
                                  AqiInfo.getStatusFromAqi(
                                      widget.stationInfo.getAvg(Parameter.aqi)),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ColorGuide(),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: screenWidth * 0.12,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TabBar(
                    controller: _controller,
                    indicatorColor: kPrimarySelectionColor,
                    indicator: BoxDecoration(
                      color: kPrimarySelectionColor,
                      border: Border.all(
                        color: kPrimarySelectionColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          'Health Advice',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'AQI Parameters',
                          style: TextStyle(
                            fontSize: screenWidth * 0.033,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              ListView(
                children: [
                  Container(
                    height: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        'GIVE US MONEY\nLOTS AND LOTS OF MONEY',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              AqiParameters(widget.stationInfo),
              DashBoard(widget.stationInfo),
            ],
          ),
        ),
      ),
    );
  }
}

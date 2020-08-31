import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/pages/info_sub_pages/info_sub_pages.dart';
import '../objects/objects.dart';

import '../components/color_guide.dart';
import '../objects/parameter.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: screenHeight * 0.5,
                  collapsedHeight: screenHeight * 0.5,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.stationInfo.name,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Air Quality Index',
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.025,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    widget.stationInfo.data.last.aqi
                                        .toInt()
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.125,
                                      fontWeight: FontWeight.w100,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    AqiInfo.getStatusFromAqi(widget
                                        .stationInfo
                                        .getAvg(Parameter.aqi)),
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.025,
                                      height: 1,
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
                      SizedBox(height: screenHeight * 0.01),
                      ColorGuide(),
                      Container(
                        height: screenHeight * 0.065,
                        margin: EdgeInsets.all(screenHeight * 0.01),
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
                                  fontSize: screenHeight * 0.0175,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'AQI Parameters',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.0165,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.0175,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              Builder(
                builder: (context) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                    ),
                    SliverToBoxAdapter(
                      child: HealthAdvice(widget.stationInfo),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                    ),
                    SliverToBoxAdapter(
                        child: AqiParameters(widget.stationInfo)),
                  ],
                ),
              ),
              Builder(
                builder: (context) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                    ),
                    SliverToBoxAdapter(
                        child: DashBoard(widget.stationInfo)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

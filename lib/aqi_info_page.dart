import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';

import 'color_guide.dart';

class InfoPage extends StatefulWidget {
  InfoPage(this.name);

  final String name;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
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
                                  'Rajiv Nagar',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'New Delhi, Delhi',
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
                                  '323',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.25,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                Text(
                                  'SEVERE',
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
                    ColorGuide(screenWidth: screenWidth),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TabBar(
                    controller: _controller,
                    tabs: [
                      Tab(

                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );
  }
}

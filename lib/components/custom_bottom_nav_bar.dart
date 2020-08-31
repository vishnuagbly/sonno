import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/pages/home_page.dart';

import '../pages/profile_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  static int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Me'),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        Widget page = loadHomePageData();
        if (index == 1) page = ProfilePage();
        Navigator.pushReplacement(
          context,
          createSlidingRoute(
            page,
            Offset(-1 + (2 * index.toDouble()), 0),
          ),
        );
      },
    );
  }
}

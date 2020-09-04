import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/pages/pages.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();

  static void reset() => _CustomBottomNavigationBarState.reset();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  static int _selectedIndex = 0;

  static void reset() {
    _selectedIndex = 0;
  }

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
          icon: Icon(Icons.blur_on),
          title: Text('Visuals'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Me'),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (_selectedIndex == index) return;
        int dx = index - _selectedIndex;
        setState(() {
          _selectedIndex = index;
        });
        Widget page = loadHomePageData();
        if(index == 1) page = VisualsPage();
        else if (index == 2) page = ProfilePage();
        Navigator.pushReplacement(
          context,
          createSlidingRoute(
            page,
            Offset(dx.toDouble(), 0),
          ),
        );
      },
    );
  }
}

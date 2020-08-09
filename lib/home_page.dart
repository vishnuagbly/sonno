import 'package:flutter/material.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            color: kPrimarySelectionColor,
            iconSize: 23,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: kSecondaryColor,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: kPrimaryTextColor,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: kPrimaryTextColor,
            ),
            title: Text('Me'),
          ),
        ],
        selectedItemColor: kPrimarySelectionColor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

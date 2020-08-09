import 'package:flutter/material.dart';
import 'dialogs/dialogs.dart';
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
        leading: Container(
          child: Center(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryBgColor,
              child: Icon(
                Icons.person_outline,
                color: kPrimaryTextColor,
                size: 30,
              ),
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            color: kPrimarySelectionColor,
            iconSize: 35,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FutureDialog(
                  future: Future.delayed(Duration(seconds: 3)),
                  hasData: (_) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context)
                          .pushReplacementNamed(kInfoPageRoute);
                    });
                    return CommonAlertDialog(
                        'Successfully connected to a device.');
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        },
      ),
    );
  }
}

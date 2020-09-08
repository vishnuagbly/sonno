import 'package:flutter/material.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';

class HeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/heat_map.png"),
          fit: BoxFit.cover,
        )),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

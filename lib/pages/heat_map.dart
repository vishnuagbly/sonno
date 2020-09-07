import 'package:flutter/material.dart';
import 'package:sonno/components/custom_bottom_nav_bar.dart';

class HeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/heat_map.png"),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FittedBox(
              child: Container(
                child: Text(
                  "Note:- This feature is currently under construction.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

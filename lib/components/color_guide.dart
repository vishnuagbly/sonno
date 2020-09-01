import 'package:flutter/material.dart';
import 'package:sonno/objects/objects.dart';
import '../constants.dart';

///height = screenHeight * 0.1
class ColorGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.1,
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.1,
        maxHeight: screenHeight * 0.1,
      ),
      color: Colors.white12,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(
          children: List.generate(
            statuses.length,
            (index) {
              List<Widget> range = [];
              if (index == 0)
                range.add(Text(Parameters.aqi.min(statuses[index]).toString()));
              range.add(Spacer());
              String max = Parameters.aqi.max(statuses[index]).toString();
              if (index == statuses.length - 1) max += '+';
              range.add(Text(max));
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      statuses[index].text,
                      style: TextStyle(
                        fontSize: screenHeight * 0.0125,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      height: screenHeight * 0.012,
                      decoration: BoxDecoration(
                        color: statuses[index].color,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              index == 0 ? Radius.circular(50) : Radius.zero,
                          bottomLeft:
                              index == 0 ? Radius.circular(50) : Radius.zero,
                          topRight: index == statuses.length - 1
                              ? Radius.circular(50)
                              : Radius.zero,
                          bottomRight: index == statuses.length - 1
                              ? Radius.circular(50)
                              : Radius.zero,
                        ),
                      ),
                    ),
                    Row(
                      children: range,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

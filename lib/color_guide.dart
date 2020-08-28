import 'package:flutter/material.dart';
import 'constants.dart';

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
            colorIndicators.length,
                (index) {
              List<Widget> range = [];
              if(index == 0)
                range.add(Text(colorIndicators[index].min.toString()));
              range.add(Spacer());
              String max = colorIndicators[index].max.toString();
              if(index == colorIndicators.length - 1)
                max += '+';
              range.add(Text(max));
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      colorIndicators[index].status,
                      style: TextStyle(
                        fontSize: screenHeight * 0.0125,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      height: screenHeight * 0.012,
                      decoration: BoxDecoration(
                        color: colorIndicators[index].color,
                        borderRadius: BorderRadius.only(
                          topLeft: index == 0
                              ? Radius.circular(50)
                              : Radius.zero,
                          bottomLeft: index == 0
                              ? Radius.circular(50)
                              : Radius.zero,
                          topRight: index ==
                              colorIndicators.length - 1
                              ? Radius.circular(50)
                              : Radius.zero,
                          bottomRight: index ==
                              colorIndicators.length - 1
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
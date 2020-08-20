import 'package:flutter/material.dart';
import 'constants.dart';

class ColorGuide extends StatelessWidget {
  const ColorGuide({
    Key key,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
                        fontSize: screenWidth * 0.025,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
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
import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/status.dart';

class AdviceObj {
  final String name;
  final ImageProvider imageProvider;
  final List<String> advices;

  AdviceObj({
    @required this.name,
    @required this.imageProvider,
    @required this.advices,
  }) : assert(imageProvider != null && name != null && advices != null);

  String adviceText(Status status) {
    int index = -1;
    for (int i = 0; i < statuses.length; i++)
      if (statuses[i] == status) index = i;
    if (index == -1) throw 'Status not valid';
    if (advices == null || advices.length == 0)
      throw 'advices not valid: $advices';
    if (advices.length > index) return advices[index];
    return advices.last;
  }

  Widget build(Status status) => Advice(
    name: name,
    imageProvider: imageProvider,
    adviceText: adviceText(status),
  );
}

class Advices {
  Advices._();

  static AdviceObj get airPurifier => AdviceObj(
        name: 'Air Purifier',
        imageProvider: AssetImage('assets/air-filter.png'),
        advices: ['Not Required', 'Required'],
      );

  static AdviceObj get outdoorActivities => AdviceObj(
        name: 'Outdoor Activities',
        imageProvider: AssetImage('assets/hiking.png'),
        advices: ['Recommended', 'Recommended', 'Not Recommended'],
      );

  static AdviceObj get pollutionMask => AdviceObj(
        name: 'Pollution Mask',
        imageProvider: AssetImage('assets/face-mask.png'),
        advices: ['Not Required', 'Required'],
      );

  static AdviceObj get ventilation => AdviceObj(
        name: 'Ventilation',
        imageProvider: AssetImage('assets/ventilation.png'),
        advices: ['Open Windows', 'Close Windows'],
      );

  static AdviceObj get kids => AdviceObj(
        name: 'Kids, Pregnant Woman & Senior Citizen',
        imageProvider: AssetImage('assets/family.png'),
        advices: [
          'Suitable for Outdoor Activities',
          'Avoid Physical Exertion & Outdoor Activities',
          'Avoid Being Outdoors',
          'Must Avoid Outdoor Activities',
          'Remain Indoors, No Physical Exertion',
        ],
      );
}

class Advice extends StatelessWidget {
  Advice({
    @required this.imageProvider,
    @required this.name,
    @required this.adviceText,
  });

  final ImageProvider imageProvider;
  final String name;
  final String adviceText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Image(
          image: imageProvider,
          width: screenWidth * 0.1,
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          name,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(adviceText),
      ],
    );
  }
}

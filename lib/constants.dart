import 'package:flutter/material.dart';

import 'objects/color_indicator.dart';

const kHomePageRoute = '/home_page';
const kInfoPageRoute = '/info_page';
const kProfilePageRoute = '/profile_page';
const kLoginPageRoute = '/';

const kStationsCollectionName = 'stations';
const kStationDataSubCollectionName = 'data';
String pathToDataSubCollection(String stationId) =>
    '$kStationsCollectionName/$stationId/$kStationDataSubCollectionName';

const kPrimaryColor = Color(0xff202020);
const kPrimaryBgColor = Color(0xff121212);
const kPrimarySelectionColor = Colors.deepPurple;
const kPrimaryTextColor = Color(0xfff0f0f0);
const kAlertDialogBackgroundColorCode = 0xFF202020;

const kAlertDialogBorderRadius = 10.0;
const kAlertDialogElevation = 30.0;
double alertDialogTitleTextSize(double screenWidth) => screenWidth * 0.06;
double alertDialogButtonTextSize(double screenWidth) => screenWidth * 0.04;

List<ColorIndicator> colorIndicators = [
  ColorIndicator(Colors.green, 'Good', 0, 50),
  ColorIndicator(Colors.amber, 'Satisfactory', 50, 100),
  ColorIndicator(Colors.deepOrange, 'Moderate', 100, 200),
  ColorIndicator(Colors.pink, 'Poor', 200, 300),
  ColorIndicator(Colors.deepPurple, 'Very Poor', 300, 400),
  ColorIndicator(Colors.red, 'Severe', 400, 500),
];

const List<String> parameters = [
  'PM\u2082.\u2085',
  'PM\u2081\u2080',
  'NO\u2082',
  'NH\u2083',
  'CO',
  'SO\u2082',
  'O\u2083',
  'AQI',
];

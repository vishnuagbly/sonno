import 'package:flutter/material.dart';

import 'objects/status.dart';

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

List<Status> statuses = [
  Status(Colors.lightBlueAccent, Color(0xff846401), 'Good'),
  Status(Colors.green, Color(0xffd8a202),  'Satisfactory'),
  Status(Colors.yellow, Color(0xfffff3e5),  'Moderate'),
  Status(Colors.orange, Color(0xfffed597),  'Poor'),
  Status(Colors.red, Color(0xff3d97fb),  'Very Poor'),
  Status(Colors.red[900], Color(0xff004d83),  'Severe'),
];

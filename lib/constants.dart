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
  Status(Colors.lightBlueAccent, 'Good'),
  Status(Colors.green, 'Satisfactory'),
  Status(Colors.yellow, 'Moderate'),
  Status(Colors.orange, 'Poor'),
  Status(Colors.red, 'Very Poor'),
  Status(Colors.red[900], 'Severe'),
];

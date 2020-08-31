import 'package:flutter/material.dart';

Route createSlidingRoute(
  Widget page,
  Offset begin, {
  Curve curve = Curves.elasticOut,
  Duration duration = const Duration(seconds: 1),
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

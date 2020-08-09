import 'package:flutter/material.dart';
import 'package:sonno/constants.dart';

class CommonAlertDialog extends AlertDialog {
  final String titleString;
  final Widget content;
  final Icon icon;
  final Function onPressed;

  CommonAlertDialog(this.titleString, {this.icon, this.onPressed, this.content});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      elevation: kAlertDialogElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kAlertDialogBorderRadius),
        ),
      ),
      backgroundColor: Color(kAlertDialogBackgroundColorCode),
      content: content,
      title: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Text(
              titleString,
              style: TextStyle(
                fontSize: alertDialogTitleTextSize(screenWidth),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: FittedBox(
                child: icon ??
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.lightGreen,
                    ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
            color: Colors.transparent,
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: alertDialogButtonTextSize(screenWidth),
              ),
            ),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BooleanDialog extends StatelessWidget {
  BooleanDialog(this.text, {this.onPressedNo, this.onPressedYes, this.content});

  final String text;
  final Widget content;
  final Function onPressedYes;
  final Function onPressedNo;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: Container(
        width: screenWidth * 0.5,
        child: Text(
          text,
          style: TextStyle(fontSize: screenWidth * 0.05),
          maxLines: null,
        ),
      ),
      content: content,
      actions: [
        FlatButton(
          child: Text("YES"),
          onPressed: onPressedYes ??
              () => Navigator.pop(
                    context,
                    true,
                  ),
        ),
        FlatButton(
          child: Text("NO"),
          onPressed: onPressedNo ??
              () => Navigator.pop(
                    context,
                    false,
                  ),
        )
      ],
    );
  }
}

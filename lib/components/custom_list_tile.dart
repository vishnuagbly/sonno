import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';

class CustomListTile extends StatelessWidget {
  ///if both page and onTap are provided than onTap is given priority.
  CustomListTile({
    IconData iconData,
    this.page,
    String title,
    this.trailing = const Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey,
    ),
    this.onTap,
  })  : icon = Icon(iconData ?? Icons.label),
        title = title ?? "";

  final Icon icon;
  final Widget trailing;
  final String title;
  final Widget page;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
        ),
      ),
      trailing: trailing,
      onTap: onTap ??
              () {
            if (page != null)
              Navigator.push(
                context,
                createSlidingRoute(
                  page,
                  Offset(1.0, 0.0),
                ),
              );
          },
    );
  }
}
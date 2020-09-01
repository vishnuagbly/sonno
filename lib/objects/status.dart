import 'package:flutter/material.dart';

class Status {
  final Color color;
  final String text;

  String get hashString => '${color.value.toString()}$text';

  @override
  int get hashCode => hashString.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Status && other.hashCode == this.hashCode;

  Status(this.color, this.text);
}

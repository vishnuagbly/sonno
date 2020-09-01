import 'package:flutter/material.dart';

class Status {
  final Color color;
  final String text;

  @override
  int get hashCode => '${color.value.toString()}$text'.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Status && other.hashCode == text.hashCode;

  Status(this.color, this.text);
}

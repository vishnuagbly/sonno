import 'package:flutter/material.dart';
import 'package:sonno/main_profile.dart';

class Status {
  final int _index;
  final String text;

  Color get color => MainProfile.colorBlindType.graphColors[_index];

  String get hashString => '${color.value.toString()}$text';

  @override
  int get hashCode => hashString.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Status && other.hashCode == this.hashCode;

  Status(this.text, this._index);
}

import 'package:flutter/material.dart';
import 'package:sonno/main_profile.dart';

class Status {
  final Color _color;
  final Color _colorBlind;
  final String text;

  Color get color {
    if(MainProfile.colorBlind)
      return _colorBlind;
    return _color;
  }

  String get hashString => '${color.value.toString()}$text';

  @override
  int get hashCode => hashString.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Status && other.hashCode == this.hashCode;

  Status(this._color, this._colorBlind, this.text);
}

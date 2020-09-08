import 'package:flutter/services.dart';

class ColorBlindType {
  ColorBlindType(this._value, this._text);

  final bool _value;
  final String _text;

  bool get value => _value;

  String get text => _text;

  @override
  int get hashCode => _text.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ColorBlindType && other.hashCode == this.hashCode;
}

class ColorBlindTypes {
  static ColorBlindType get redGreen => ColorBlindType(true, "Red-Green");

  static ColorBlindType get blueYellow => ColorBlindType(false, "Blue-Yellow");

  static ColorBlindType get complete => ColorBlindType(false, "Complete");

  static ColorBlindType get normal => ColorBlindType(false, "Normal");

  static List<ColorBlindType> get all => [
        redGreen,
        blueYellow,
        complete,
        normal,
      ];

  static getIndex(ColorBlindType colorBlindType) {
    for (int i = 0; i < all.length; i++)
      if (all[i].text == colorBlindType.text) return i;
    throw PlatformException(code: 'DOES_NOT_EXIST');
  }
}

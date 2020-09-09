import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorBlindType {
  ColorBlindType(
      this._value, this._text, this._primarySelectionColor, this._graphColors);

  final bool _value;
  final String _text;
  final Color _primarySelectionColor;
  final List<Color> _graphColors;

  bool get value => _value;

  Color get primarySelectionColor => _primarySelectionColor;
  List<Color> get graphColors => _graphColors;

  String get text => _text;

  @override
  int get hashCode => _text.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ColorBlindType && other.hashCode == this.hashCode;
}

class ColorBlindTypes {
  static ColorBlindType get redGreen =>
      ColorBlindType(true, "Deuteranopia (Red-Green)", Color(0xffd8a202), [
        Color(0xff846401),
        Color(0xffd8a202),
        Color(0xfffff3e5),
        Color(0xfffed597),
        Color(0xff3d97fb),
        Color(0xff004d83),
      ]);

  static ColorBlindType get blueYellow =>
      ColorBlindType(false, "Tritanopia (Blue-Yellow)", Color(0xfff44043), [
        Color(0xff17cbdc),
        Color(0xff62a5b3),
        Color(0xfffee0ea),
        Color(0xfffe9099),
        Color(0xfff44043),
        Color(0xffb71c19),
      ]);

  static ColorBlindType get normal =>
      ColorBlindType(false, "Normal", Colors.green, [
        Colors.lightBlueAccent,
        Colors.green,
        Colors.yellow,
        Colors.orange,
        Colors.red,
        Colors.red[900],
      ]);

  static List<ColorBlindType> get all => [
        redGreen,
        blueYellow,
        normal,
      ];

  static getIndex(ColorBlindType colorBlindType) {
    for (int i = 0; i < all.length; i++)
      if (all[i].text == colorBlindType.text) return i;
    throw PlatformException(code: 'DOES_NOT_EXIST');
  }
}

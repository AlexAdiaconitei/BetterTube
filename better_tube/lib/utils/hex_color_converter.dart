import 'package:flutter/material.dart';

class HexColorConverter {
  
  static String colorToHex(Color color) {
    return color.toString().split('(')[1].split(')')[0];
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}
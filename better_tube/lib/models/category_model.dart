
import 'package:flutter/material.dart';

class Category {

  String name;
  List<String> channels;
  Color color;
  int numberOfChannels;

  Category({this.name, this.channels, String colorString}) {
    numberOfChannels = channels.length;
    color = _hexToColor(colorString);
  }

  Color _hexToColor(String code) {
    if(code == null) {
      return Color(0xFFFF0000);
    } 
    return new Color(int.parse(code));
  }

}
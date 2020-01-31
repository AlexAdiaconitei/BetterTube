import 'package:flutter/cupertino.dart';

class Category {

  String name;
  List<String> channels;
  Color color;
  int numberOfVideos;

  Category({this.name, this.channels, String colorString}) {
    numberOfVideos = channels.length;
    color = _hexToColor(colorString);
  }

  Color _hexToColor(String code) {
    if(code == null) {
      color = Color(0xFFFF0000);
    } else {
      return new Color(int.parse(code));
    }
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class ColorPickerDialog extends StatefulWidget {

  final Color color;
  ColorPickerDialog(this.color);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState(color);
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  
  Color color;
  _ColorPickerDialogState(this.color);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Container(
            height: 290.0,
            child: Column(
              children: <Widget>[
                CircleColorPicker(
                  initialColor: color,
                  onChanged: (colorPicked) {
                    setState(() {
                      color = colorPicked;
                    });
                  },
                  size: const Size(240, 240),
                  strokeWidth: 4,
                  thumbSize: 36,
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, color);
                    });
                  },
                  child: Text(
                    "Pick",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
              ],
            ),
          ),
        );
  }

}

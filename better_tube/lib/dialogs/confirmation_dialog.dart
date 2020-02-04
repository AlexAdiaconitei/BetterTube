import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      content: 
        Container(
          height: 50.0,
          width: 50.0,
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 50.0,
            ),
          ),
        ),
    );
  }
}

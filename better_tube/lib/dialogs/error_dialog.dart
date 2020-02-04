import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String errorMessage;
  ErrorDialog(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      content: Container(
        height: 100.0,
        width: 50.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.close,
              color: Colors.red,
              size: 50.0,
            ),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 15.0,                        
              ),
            ),
          ],
        ),
      ),
    );
  }
}

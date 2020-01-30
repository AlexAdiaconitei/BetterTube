import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  String text;
  Loading(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCubeGrid(
              color: Colors.red,
              size: 50.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Quicksand',
                  fontSize: 20.0,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
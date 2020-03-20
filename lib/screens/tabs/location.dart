import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "This tab will be a web view. Under development",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

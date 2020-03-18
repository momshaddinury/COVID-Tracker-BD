import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String label;
  final String value;
  final colorValue;

  Cards(this.label, this.value, {this.colorValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      width: double.maxFinite,
      child: Card(
        color: colorValue,
        child: Center(
          child: Text(
            "$label: $value",
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InfoShow extends StatelessWidget {
  final String top, left, right;
  final double size;

  InfoShow({
    this.top,
    this.left,
    this.right,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getInfo('Total Cases:', top, true, Colors.orange),
            SizedBox(
              height: size,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getInfo('Deaths', left, false, Colors.red),
                getInfo('Recovered:', right, false, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getInfo(String text, String number, bool top, final color) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: size * (top ? 1 : 0.8),
              ),
            ),
            Text(
              number,
              style: TextStyle(
                color: color,
                fontSize: size * (top ? 1 : 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

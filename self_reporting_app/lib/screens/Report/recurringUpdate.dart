import 'package:flutter/material.dart';

class RecurringUpdate extends StatefulWidget {
  @override
  _RecurringUpdateState createState() => _RecurringUpdateState();
}

class _RecurringUpdateState extends State<RecurringUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
      ),
      body: Container(
        child: Center(
          child: Text("Works"),
        ),
      ),
    );
  }
}

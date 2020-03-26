import 'package:flutter/material.dart';

class SnackPage extends StatefulWidget {
  @override
  _SnackState createState() => _SnackState();
}

class _SnackState extends State<SnackPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();



  Widget snackDuration() => SnackBar(
    content: Text(
      "You have a message!",
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blueAccent,
    duration: Duration(milliseconds: 10),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text("PageName.SNACK_BAR"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              final bar = snackDuration();
              _key.currentState.showSnackBar(bar);
            },
            child: Text("Show the snack bar"),
            color: Colors.red,
          ),
        ));
  }
}


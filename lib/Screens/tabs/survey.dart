import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
            margin: EdgeInsets.all(20),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              child: Text(
                'Start Online COVID Test',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              color: Colors.red[400],
              textColor: Colors.white,
              onPressed: () async {
                dynamic result = await auth.signInAnon();
                if (result.uid != null) {
                  print(result.uid);
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

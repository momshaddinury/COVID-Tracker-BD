import 'package:flutter/material.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoggedOut extends StatefulWidget {
  @override
  _LoggedOutState createState() => _LoggedOutState();
}

class _LoggedOutState extends State<LoggedOut> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            COVIDTestStartButton(auth: auth),
          ],
        ),
      ),
    );
  }
}

class COVIDTestStartButton extends StatelessWidget {
  const COVIDTestStartButton({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final AuthService auth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/3337528.jpg',
            fit: BoxFit.contain,
            height: 250,
            width: 250,
          ),
        ),
        SizedBox(height: 40,),
        Center(
          child: Text(
            "Am I Infected With Coronavirus?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
              ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.all(20),
          child: FlatButton(
            padding: EdgeInsets.all(20),
            child: Text(
              'COVID-19 Report Submission',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            color: Colors.red[400],
            textColor: Colors.white,
            onPressed: () async {
              await auth.signInAnon();
              SpinKitPulse(
                color: Colors.redAccent,
                size: 60.0,
              );
            },
          ),
        ),
      ],
    );
  }
}

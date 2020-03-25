import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/screens/tabs/home/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoggedOut extends StatefulWidget {
  @override
  _LoggedOutState createState() => _LoggedOutState();
}

bool isLoading = false;

class _LoggedOutState extends State<LoggedOut> {
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    task();
  }

  task() async {
    auth.signOut();
  }

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

class COVIDTestStartButton extends StatefulWidget {
  const COVIDTestStartButton({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final AuthService auth;

  @override
  _COVIDTestStartButtonState createState() => _COVIDTestStartButtonState();
}

class _COVIDTestStartButtonState extends State<COVIDTestStartButton> {
  showSpinKit() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                "If you are feeling sick and want to let the authority know about your health condition please fill up the form and wait. A health expert will contact you soon.",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.all(10.0),
            color: kMLight,
            child: Text(
              "Click to Submit Report",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            onPressed: () async {
              showSpinKit();
              await widget.auth.signInAnon();
              isLoading = false;
            },
          ),
          isLoading
              ? SpinKitPulse(
                  color: Colors.blueAccent,
                  size: 60.0,
                )
              : Container(),
        ],
      ),
    );
  }
}

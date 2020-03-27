import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covidtrackerbd/screens/tabs/survey/self_reporting_page.dart';

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
    //task();
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
              'assets/doc.png',
              fit: BoxFit.cover,
              height: 250,
              width: 400,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                "আপনি কি করোনা ভাইরাসে ( কোভিড-১৯) আক্রান্ত ?",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.all(10.0),
            minWidth: 50,
            color: Color(0xFF4575CB),
            child: AutoSizeText(
              "শুরু করুন",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelfReportingPage()));
              /*showSpinKit();
              await widget.auth.signInAnon();
              isLoading = false;*/
            },
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.all(10.0),
            minWidth: 50,
            color: Colors.lightBlueAccent,
            child: AutoSizeText(
              "নিয়মিত আপডেট",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            onPressed: () async {
              showSpinKit();
              await widget.auth.signInAnon();
              isLoading = false;
            },
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.all(10.0),
            minWidth: 50,
            color: Color(0xFF40BD45),
            child: AutoSizeText(
              "সম্ভাব্য করোনা আক্রান্তের তথ্য দিন",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
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

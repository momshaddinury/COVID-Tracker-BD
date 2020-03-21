import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/screens/tabs/survey/formSubmissionPage.dart';
import 'package:covidtrackerbd/screens/tabs/survey/loggedIn.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Scaffold(
        body: LogInToSubmit(),
      ),
    );
  }
}

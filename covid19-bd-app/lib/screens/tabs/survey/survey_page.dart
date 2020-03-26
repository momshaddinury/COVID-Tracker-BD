import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/screens/tabs/survey/formSubmissionPage.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
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

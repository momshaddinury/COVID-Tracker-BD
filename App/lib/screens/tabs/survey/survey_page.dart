import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/screens/tabs/survey/formSubmissionPage.dart';
import 'package:covidtrackerbd/screens/tabs/survey/self_reporting_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
      ),
      body: SelfReportingPage(),
    );
  }
}

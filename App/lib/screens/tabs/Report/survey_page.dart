import 'package:covidtrackerbd/screens/tabs/Report//self_reporting_page.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/screens/tabs/Report//recurringUpdate.dart';
import 'package:covidtrackerbd/screens/tabs/Report//possible_affected.dart';

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
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
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
                    // Self Report
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
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Recurring Update
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecurringUpdate()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Possible Affected
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PossibleAffected()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

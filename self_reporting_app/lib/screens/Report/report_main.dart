import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:selfreportingapp/screens/Report/possible_affected.dart';
import 'package:selfreportingapp/screens/Report/main_case_report_submission_page.dart';
import 'package:selfreportingapp/screens/Report/volunteer_report_submission.dart';

import 'neighbours_report.dart';

class ReportMain extends StatefulWidget {
  @override
  _ReportMainState createState() => _ReportMainState();
}

class _ReportMainState extends State<ReportMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/doc.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: AutoSizeText(
                      "আপনি কি করোনা ভাইরাসে ( কোভিড-১৯) আক্রান্ত ?",
                      textScaleFactor: 1,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Self Report
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Main Case Report
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            //minWidth: 50,
                            color: Color(0xFF4575CB),
                            shape: StadiumBorder(),
                            child: AutoSizeText(
                              "শুরু করুন",
                              style: reportButtonTextStyle(),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainCaseReport()));
                            },
                          ),
                        ),
                      ),
                      // Community Service
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            //minWidth: 50,
                            color: Colors.redAccent,
                            shape: StadiumBorder(),
                            child: AutoSizeText(
                              "কমিউনিটি সার্ভিস",
                              style: reportButtonTextStyle(),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VolunteerUpdate()));
                            },
                          ),
                        ),
                      ),
                      // Possible Affected
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            //minWidth: 50,
                            color: Color(0xFF40BD45),
                            shape: StadiumBorder(),
                            child: AutoSizeText(
                              "সম্ভাব্য করোনা আক্রান্ত ব্যাক্তির তথ্য দিন",
                              textAlign: TextAlign.center,
                              style: reportButtonTextStyle(),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NeighboursReport()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle reportButtonTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 25,
    );
  }
}

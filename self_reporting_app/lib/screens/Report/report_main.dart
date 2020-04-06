import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:selfreportingapp/screens/Report/possible_affected.dart';
import 'package:selfreportingapp/screens/Report/choose_report_type_page.dart';
import 'package:selfreportingapp/screens/Report/volunteer_report_submission.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70),
              Container(
                child: Image.asset(
                  'assets/checkPatient.jpg',
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
                    textScaleFactor: 1,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 35.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Self Report
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      //minWidth: 50,
                      color: Color(0xFF4575CB),
                      shape: StadiumBorder(),
                      child: AutoSizeText(
                        "শুরু করুন",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      //minWidth: 50,
                      color: Colors.lightBlueAccent,
                      shape: StadiumBorder(),
                      child: AutoSizeText(
                        "কমিউনিটি সার্ভিস",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VolunteerUpdate()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Possible Affected
                    MaterialButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      //minWidth: 50,
                      color: Color(0xFF40BD45),
                      shape: StadiumBorder(),
                      child: AutoSizeText(
                        "সম্ভাব্য করোনা আক্রান্তের তথ্য দিন",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

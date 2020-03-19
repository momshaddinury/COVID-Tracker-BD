import 'package:covidtrackerbd/Screens/homeScreen.dart';
import 'package:covidtrackerbd/Screens/tabs/survey.dart';
import 'package:covidtrackerbd/Screens/widgets/InfoShow.dart';
import 'package:covidtrackerbd/initialize.dart';
import 'package:covidtrackerbd/services/JSONHandler.dart';
import 'package:covidtrackerbd/services/globalDataHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    totalCases = '$infected';
    deaths = '$dead';
    recovered = '$recovery';
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: data.size.width * 0.1,
            vertical: data.size.height * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'LOCAL UPDATE',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: data.size.width * 0.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InfoShow(
                  top: totalCases,
                  left: deaths,
                  right: recovered,
                  size: data.size.width * 0.1,
                ),
                Container(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                          "Check to see if you have COVID, please click the button",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                          )),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: FlatButton(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Take Me To Online Test',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            print('Submit');
                            streamController.sink.add(3);
                          }
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

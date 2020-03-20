import 'package:covidtrackerbd/Screens/widgets/InfoShow.dart';
import 'package:covidtrackerbd/services/JSONHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home(this.goToOnlineTestTab);
  final Function goToOnlineTestTab;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  top: infected.toString(),
                  left: dead.toString(),
                  right: recovery.toString(),
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
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10.0, // soften the shadow
                            spreadRadius: 1.0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              2.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ]),
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
                          onPressed: widget.goToOnlineTestTab,
                        ),
                      )
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


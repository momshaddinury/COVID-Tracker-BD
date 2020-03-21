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
    return Container(
      width: double.maxFinite,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: data.size.width * 0.05,
              vertical: data.size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/3410006.jpg',
                    fit: BoxFit.contain,
                    height: 250,
                    width: 250,
                  ),
                ),
                Container(
                  child: Text(
                    'COVID STATUS IN BD',
                    style: TextStyle(
                      color: Colors.black87,
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
                /*Container(),*/
                GestureDetector(
                  onTap: widget.goToOnlineTestTab,
                  child: Container(
                    height: 135,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red[100],
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 0.5, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Image.asset(
                                  'assets/covid.png',
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                //padding: EdgeInsets.only(right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Coronavirus Test",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    Text(
                                      "CLICK HERE to submit a report if you think you are infected with Coronavirus. Also if you are serverly ill, you'll be contacted via phone. So give information carefully",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.black87,
                              size: 25,
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*
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
 */

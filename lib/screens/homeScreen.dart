import 'package:covidtrackerbd/Screens/tabs/home.dart';
import 'package:covidtrackerbd/Screens/tabs/global.dart';
import 'package:covidtrackerbd/Screens/tabs/location.dart';
import 'package:covidtrackerbd/screens/tabs/survey/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Current index of bottomNavigationBar item
  int cIndex = 0;

  @override
  void initState() {
    /*totalCases = '$infected';
    deaths = '$dead';
    recovered = '$recovery';*/
    super.initState();
  }

  void goToOnlineTestTab() {
    setState(() {
      cIndex = 3;
    });
  }

  ///List of all the tabs
  Widget tabs() {
    switch (cIndex) {
      case 0:
        return Home(goToOnlineTestTab);
        break;
      case 1:
        return Location();
        break;
      case 2:
        return Global();
        break;
      case 3:
        return Survey();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('homeScreen');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: Text(
            "COVID 19 - BD",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.white,

        ///Houses all the tabs and changes based on onTap of
        ///bottomNavigationBar items
        body: tabs(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.redAccent,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white),
          child: BottomNavigationBar(
            backgroundColor: Colors.redAccent,
            currentIndex: cIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.white),
                  title: new Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on, color: Colors.white),
                  title: new Text('Location')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.public, color: Colors.white),
                  title: new Text('Global')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.rate_review, color: Colors.white),
                  title: new Text('Online Test')),
            ],
            onTap: (index) {
              ///onTap change the index to move to respective tab
              setState(() {
                cIndex = index;
              });
            },
          ),
        ));
  }
}

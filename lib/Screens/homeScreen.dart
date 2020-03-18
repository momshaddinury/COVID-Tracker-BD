import 'package:covidtrackerbd/tabs//home.dart';
import 'package:covidtrackerbd/tabs/global.dart';
import 'package:covidtrackerbd/tabs/location.dart';
import 'package:covidtrackerbd/tabs/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

HomeScreen homeScreen = HomeScreen();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cIndex = 0;

  final tabs = [
    Home(),
    Location(),
    Global(),
    Survery(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "COVID19 Live Tracker (BETA)",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: tabs[_cIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.redAccent,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white),
          child: BottomNavigationBar(
            backgroundColor: Colors.redAccent,
            currentIndex: _cIndex,
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
                  icon: Icon(Icons.healing, color: Colors.white),
                  title: new Text('Recover')),
            ],
            onTap: (index) {
              setState(() {
                _cIndex = index;
              });
            },
          ),
        ));
  }
}

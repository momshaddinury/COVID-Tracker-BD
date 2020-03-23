import 'package:covidtrackerbd/Screens/tabs/location.dart';
import 'package:covidtrackerbd/screens/tabs/developerStory.dart';
import 'package:covidtrackerbd/screens/tabs/home/my_home_page.dart';
import 'package:covidtrackerbd/screens/tabs/survey/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Current index of bottomNavigationBar item
  int cIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  ///List of all the tabs
  Widget tabs() {
    switch (cIndex) {
      case 0:
        //return Home(goToOnlineTestTab);
        return MyHomePage();
        break;
      case 1:
        return Location();
        break;
      case 2:
        return Survey();
        break;
      case 3:
        return DeveloperStory();
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: AutoSizeText(
            "COVID 19 - BD",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      "Dashboard",
                      style: TextStyle(fontSize: 10.0),
                      minFontSize: 8,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      "Location",
                      style: TextStyle(fontSize: 10.0),
                      minFontSize: 8,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.rate_review,
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      "COVID Test",
                      style: TextStyle(fontSize: 10.0),
                      minFontSize: 8,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      "Dev Story",
                      style: TextStyle(fontSize: 10.0),
                      minFontSize: 8,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,

        ///Houses all the tabs and changes based on onTap of
        ///bottomNavigationBar items
        body: TabBarView(
          children: <Widget>[
            MyHomePage(),
            Location(),
            Survey(),
            DeveloperStory(),
          ],
        ),
      ),
    );
  }
}

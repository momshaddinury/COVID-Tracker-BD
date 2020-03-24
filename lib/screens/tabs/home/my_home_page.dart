import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/screens/tabs/developerStory.dart';
import 'package:covidtrackerbd/screens/tabs/home/repository.dart';
import 'package:covidtrackerbd/screens/tabs/location.dart';
import 'package:covidtrackerbd/screens/tabs/survey/survey_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import 'api_service.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import 'constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    /*with AutomaticKeepAliveClientMixin<MyHomePage>*/ {
  /*@override
  bool get wantKeepAlive => true;*/

  ApiService apiService;
  Map<String, double> dataMap = new Map();
  Map<String, double> dataMapAll = new Map();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1],
                  colors: [
                    kLight,
                  ],
                ),
              ),
            ),
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
                      ResizableTextWidget(title: "Dashboard")
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
                      ResizableTextWidget(title: "Location")
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
                      ResizableTextWidget(title: "COVID Test")
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
                      ResizableTextWidget(title: "Dev Story")
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            children: <Widget>[
              BlocProvider<CovidBloc>(
                  create: (BuildContext context) =>
                      CovidBloc(repository: Repository())
                        ..add(CovidBdDataEvent(
                            param: "countries/bangladesh", paramAll: "all")),
                  child: Container(
                    child: BlocBuilder<CovidBloc, CovidState>(
                      builder: (context, state) {
                        if (state is CovidLoadingState) {
                          return Align(
                            alignment: Alignment.center,

                            /// Loading Screen Here
                            child: SpinKitPulse(
                              color: Colors.blueAccent,
                              size: 60.0,
                            ),
                          );
                        } else if (state is CovidBdState) {
                          if (state.covidBdData != null &&
                              state.allData != null) {
                            dataMap.putIfAbsent("Confirmed",
                                () => state.covidBdData.cases.toDouble());
                            dataMap.putIfAbsent("Recovered",
                                () => state.covidBdData.recovered.toDouble());
                            dataMap.putIfAbsent("Deaths",
                                () => state.covidBdData.deaths.toDouble());
                            print("CovidBdState ${state.allData}");
                            dataMapAll.putIfAbsent("Confirmed ",
                                () => state.allData.cases.toDouble());
                            dataMapAll.putIfAbsent("Recovered",
                                () => state.allData.recovered.toDouble());
                            dataMapAll.putIfAbsent("Deaths",
                                () => state.allData.deaths.toDouble());
                            return dashBoard(state);
                          }
                          return Container();
                        } else if (state is CovidErrorState) {
                          return Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                    "Something is Wrong, Check your Data Connection."),
                              ));
                        }

                        return SpinKitPulse(
                          color: Colors.blueAccent,
                          size: 60.0,
                        );
                      },
                    ),
                  )),
              Location(),
              SurveyPage(),
              DeveloperStory(),
            ],
          )),
    );
  }

  SingleChildScrollView dashBoard(CovidBdState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Bangladesh Covid 19",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: getChart(dataMap,
                            [confirmedColor, recoveredColor, deathColor])),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _getItem(state.covidBdData.todayCases,
                                "Today Confirmed"),
                            SizedBox(
                              height: 10,
                            ),
                            _getItem(state.covidBdData.active, "Active Cases"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _getItem(
                                state.covidBdData.todayDeaths, "Today Deaths"),
                            SizedBox(
                              height: 10,
                            ),
                            _getItem(
                                state.covidBdData.critical, "Critical Cases"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _getItem(
                                state.covidBdData.deaths +
                                    state.covidBdData.recovered +
                                    state.covidBdData.cases,
                                "Reported cases"),
                            SizedBox(
                              height: 10,
                            ),
                            _getItem(state.covidBdData.casesPerOneMillion,
                                "Cases Per Million"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "World Covid 19 ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Updated on",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " ${formatTimestamp(state.allData.updated)}",
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: getChart(dataMapAll,
                            [confirmedColor, recoveredColor, deathColor])),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _getItem(state.allData.deaths, "Total Deaths"),
                        _getItem(state.allData.recovered, "Total Recovered"),
                        _getItem(
                            state.allData.deaths +
                                state.allData.recovered +
                                state.allData.cases,
                            "Total Cases"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getItem(final data, String level) {
    return Column(
      children: <Widget>[
        AutoSizeText(
          "$data",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "$level",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87),
        )
      ],
    );
  }

  getChart(var data, var color) {
    return PieChart(
      dataMap: data,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 2.7,
      showChartValuesInPercentage: false,
      showChartValues: true,
      showChartValuesOutside: false,
      chartValueBackgroundColor: Colors.transparent,
      colorList: color,
      showLegends: true,
      legendPosition: LegendPosition.right,
      decimalPlaces: 0,
      showChartValueLabel: true,
      initialAngle: 0,
      chartValueStyle: defaultChartValueStyle.copyWith(color: Colors.black),
      chartType: ChartType.ring,
    );
  }

  String formatTimestamp(int timestamp) {
    var format = new DateFormat("MMM d, yyyy");
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }
}

class ResizableTextWidget extends StatelessWidget {
  const ResizableTextWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      "$title",
      style: TextStyle(fontSize: 13.0),
      minFontSize: 10,
      overflow: TextOverflow.ellipsis,
    );
  }
}

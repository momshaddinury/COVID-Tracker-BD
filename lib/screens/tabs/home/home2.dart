import 'package:covidtrackerbd/screens/tabs/home/repository.dart';
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService;
  Map<String, double> dataMap = new Map();
  Map<String, double> dataMapAll = new Map();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<CovidBloc>(
          create: (BuildContext context) => CovidBloc(repository: Repository())
            ..add(CovidBdDataEvent(
                param: "countries/bangladesh", paramAll: "all")),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BlocBuilder<CovidBloc, CovidState>(
                  builder: (context, state) {
                    if (state is CovidLoadingState) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: SpinKitPulse(
                              color: Colors.redAccent,
                              size: 60.0,
                            ),
                          ),
                        ),
                      );
                    } else if (state is CovidBdState) {
                      if (state.covidBdData != null && state.allData != null) {
                        dataMap.putIfAbsent("Confirmed",
                            () => state.covidBdData.cases.toDouble());
                        dataMap.putIfAbsent("Recovered",
                            () => state.covidBdData.recovered.toDouble());
                        dataMap.putIfAbsent("Deaths",
                            () => state.covidBdData.deaths.toDouble());
                        print("CovidBdState ${state.allData}");
                        dataMapAll.putIfAbsent(
                            "Confirmed ", () => state.allData.cases.toDouble());
                        dataMapAll.putIfAbsent("Recovered",
                            () => state.allData.recovered.toDouble());
                        dataMapAll.putIfAbsent(
                            "Deaths", () => state.allData.deaths.toDouble());
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Card(
                                color: Colors.red[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Bangladesh Covid 19",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: getChart(dataMap, [
                                            confirmedColor,
                                            recoveredColor,
                                            deathColor
                                          ])),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              _getItem(
                                                  state.covidBdData.todayCases,
                                                  "Today Confirmed"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              _getItem(state.covidBdData.active,
                                                  "Active Cases"),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              _getItem(
                                                  state.covidBdData.todayDeaths,
                                                  "Today Deaths"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              _getItem(
                                                  state.covidBdData.critical,
                                                  "Critical Cases"),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              _getItem(
                                                  state.covidBdData.deaths +
                                                      state.covidBdData
                                                          .recovered +
                                                      state.covidBdData.cases,
                                                  "Reported cases"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              _getItem(
                                                  state.covidBdData
                                                      .casesPerOneMillion,
                                                  "Cases Per Million"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Card(
                                color: Colors.red[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                    fontSize: 12,
                                                    color: Colors.blueGrey),
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
                                          child: getChart(dataMapAll, [
                                            confirmedColor,
                                            recoveredColor,
                                            deathColor
                                          ])),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          _getItem(state.allData.deaths,
                                              "Total Deaths"),
                                          _getItem(state.allData.recovered,
                                              "Total Recovered"),
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
                        );
                      }
                      return Container();
                    } else if (state is CovidErrorState) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: primaryColorDark,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "Something went wrong!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          )),
    );
  }

  _getItem(final data, String level) {
    return Column(
      children: <Widget>[
        Text(
          "$data",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$level",
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

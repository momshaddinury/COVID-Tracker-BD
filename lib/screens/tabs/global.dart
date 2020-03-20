import 'dart:convert';

import 'package:covidtrackerbd/model//country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:covidtrackerbd/model//globalDataHandler.dart';


import 'package:covidtrackerbd/Screens/widgets//details.dart';
import 'package:covidtrackerbd/Screens/widgets/InfoShow.dart';


class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  @override
  void initState() {
    super.initState();
    totalCases = '100,679';
    deaths = '3,412';
    recovered = '55,991';
    countries = List();
    getData();
  }

  Future<void> getData() async {
    var response = await http.get(url, headers: {
      "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
      "x-rapidapi-key": "25af6ebf6cmsh10c0a702d2aa41ep1b75f2jsn80a3b3fcca8e",
    });
    Map<String, dynamic> dataResponse = jsonDecode(response.body);
    List countriesList = dataResponse['countries_stat'];
    int n = countriesList.length;
    setState(() {
      int totalCasesI = 0, totalDeathsI = 0, totalRecoveredI = 0;
      for (int i = 0; i < n; i++) {
        String curCases = countriesList[i]['cases'];
        String curDeaths = countriesList[i]['deaths'];
        String curRecovered = countriesList[i]['total_recovered'];
        countries.add(
          Country(
            name: (countriesList[i]['country_name'] == 'Israel'
                ? 'NULL'
                : countriesList[i]['country_name']),
            totalCases: curCases,
            deaths: curDeaths,
            recovered: curRecovered,
          ),
        );
        String t = '';
        for (int i = 0; i < curCases.length; i++) {
          if (curCases[i] != ',') {
            t += curCases[i];
          }
        }
        totalCasesI += num.parse(t);
        t = '';
        for (int i = 0; i < curDeaths.length; i++) {
          if (curDeaths[i] != ',') {
            t += curDeaths[i];
          }
        }
        totalDeathsI += num.parse(t);
        t = '';
        for (int i = 0; i < curRecovered.length; i++) {
          if (curRecovered[i] != ',') {
            t += curRecovered[i];
          }
        }
        totalRecoveredI += num.parse(t);
      }
      String totalCasesS = totalCasesI.toString();
      String totalDeathsS = totalDeathsI.toString();
      String totalRecoveredS = totalRecoveredI.toString();
      String t = '';
      int c = 0;
      for (int i = totalCasesS.length - 1; i >= 0; i--) {
        t = totalCasesS[i] + t;
        c++;
        if (c == 3 && i != 0) {
          t = ',' + t;
          c = 0;
        }
      }
      totalCases = t;
      t = '';
      c = 0;
      for (int i = totalDeathsS.length - 1; i >= 0; i--) {
        t = totalDeathsS[i] + t;
        c++;
        if (c == 3 && i != 0) {
          t = ',' + t;
          c = 0;
        }
      }
      deaths = t;
      t = '';
      c = 0;
      for (int i = totalRecoveredS.length - 1; i >= 0; i--) {
        t = totalRecoveredS[i] + t;
        c++;
        if (c == 3 && i != 0) {
          t = ',' + t;
          c = 0;
        }
      }
      recovered = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: countries.length == 0
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Stack(
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
                      'GLOBAL UPDATE',
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
                ],
              ),
            ),
          ),
          Details(
            countries: countries,
          ),
        ],
      ),
    );
  }
}

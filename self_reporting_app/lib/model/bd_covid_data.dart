import 'dart:convert';

CovidBdData covidBdDataFromJson(String str) =>
    CovidBdData.fromJson(json.decode(str));

String covidBdDataToJson(CovidBdData data) => json.encode(data.toJson());

class CovidBdData {
  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;

  CovidBdData({
    this.country,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
  });

  factory CovidBdData.fromJson(Map<String, dynamic> json) => CovidBdData(
        country: json["country"],
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
      };
}

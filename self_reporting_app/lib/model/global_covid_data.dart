import 'dart:convert';

AllData allDataFromJson(String str) => AllData.fromJson(json.decode(str));
String allDataToJson(AllData data) => json.encode(data.toJson());

class AllData {
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int updated;
  AllData({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.updated,
  });
  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        updated: json["updated"],
      );
  Map<String, dynamic> toJson() => {
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "updated": updated,
      };
}

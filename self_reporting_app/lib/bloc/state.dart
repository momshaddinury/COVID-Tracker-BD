

import 'package:selfreportingapp/model/bd_covid_data.dart';
import 'package:selfreportingapp/model/global_covid_data.dart';

class CovidState {}

class CovidInitailState extends CovidState {}

class CovidLoadingState extends CovidState {}

class CovidBdState extends CovidState {
  CovidBdData covidBdData;
  AllData allData;

  CovidBdState({this.covidBdData, this.allData});
}

class CovidAllState extends CovidState {}

class CovidErrorState extends CovidState {
  final error;
  CovidErrorState({this.error});
}

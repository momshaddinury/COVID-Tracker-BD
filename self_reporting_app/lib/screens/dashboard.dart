import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfreportingapp/bloc/bloc.dart';
import 'package:selfreportingapp/bloc/event.dart';
import 'package:selfreportingapp/bloc/state.dart';
import 'package:selfreportingapp/model/world_o_meter_repo.dart';
import 'package:selfreportingapp/screens/heatmap.dart';
import 'package:selfreportingapp/screens/support_page.dart';
import 'package:selfreportingapp/services/world_o_meter_api.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Report/survey_page.dart';
import 'about_us.dart';
import 'dart:io' show Platform;

//String selectedCategorie = "Adults";
String title;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel(
      'com.tne.selfreportingapp/MAP_CHANNEL');
  ApiService apiService;
  Map<String, double> dataMap = new Map();
  Map<String, double> dataMapAll = new Map();

  //List<String> categories = ["Online Covid Test","Childrens","Womens","Mens"];

  //List<SpecialityModel> specialities;

  @override
  void initState() {
    super.initState();

    //specialities = getSpeciality();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'করোনা',
            style: TextStyle(
              //color: Colors.black87.withOpacity(0.8), #95268D
                color: Color(0xFF95268D),
                fontSize: 25,
                fontWeight: FontWeight.w700),
            children: <TextSpan>[
              TextSpan(
                  text: " ইনফো",
                  style: TextStyle(
                    //textBaseline: TextBaseline.alphabetic,
                    //color: Colors.black87.withOpacity(0.8), #95268D
                      color: Color(0xFF4CB856),
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset('assets/0th-I.png'),
            ),
            Container(
              decoration: new BoxDecoration(color: Color(0x0F2A76DE)),
              child: ListTile(
                title: Text(
                  "আমাদের সম্পর্কে",
                  textScaleFactor: 1.0,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeveloperStory()));
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: new BoxDecoration(color: Color(0x0F2A76DE)),
              child: ListTile(
                title: Text(
                  "মতামত দিন",
                  textScaleFactor: 1.0,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Support()));
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.white,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              //Image.asset('assets/coronaInfo.png'),
              /*RichText(
                text: TextSpan(
                  text: 'করোনা',
                  style: TextStyle(
                      //color: Colors.black87.withOpacity(0.8), #95268D
                      color: Color(0xFF95268D),
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                  children: <TextSpan>[
                    TextSpan(
                        text: " ইনফো",
                        style: TextStyle(
                            //textBaseline: TextBaseline.alphabetic,
                            //color: Colors.black87.withOpacity(0.8), #95268D
                            color: Color(0xFF4CB856),
                            fontSize: 35,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),*/
              FittedBox(
                child: Image.asset(
                  "assets/3623963.jpg",
                  fit: BoxFit.contain,
                  width: 350,
                  height: 350,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "আপনি কি আক্রান্ত?",
                textScaleFactor: 1.0,
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                child: MaterialButton(
                  elevation: 10,
                  shape: StadiumBorder(),
                  color: Color(0xFFBD202E),
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SurveyPage()));
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.touch_app,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        "করোনার সম্ভাব্যতা যাচাই করুন",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              HeatMapTile(),
              SizedBox(
                height: 20,
              ),
              FittedBox(
                child: MaterialButton(
                  padding: EdgeInsets.all(20),
                  elevation: 10,
                  shape: StadiumBorder(),
                  color: Colors.indigo,
                  // color: Color(0xFFBD202E),
                  onPressed: () async {
                    if (await canLaunch("tel:333")) {
                      await launch("tel:333");
                    } else {
                      throw 'Could not launch';
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        "যোগাযোগ হটলাইন ৩৩৩ | ১০৬৫৫ | ১৬২৬৩",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                          //fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              AutoSizeText(
                "সর্বশেষ তথ্য \nতথ্যসূত্র: WorldoMeter",
                textScaleFactor: 1.0,
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),

              /*Container(
                height: 30,
                child: ListView.builder(
                itemCount: categories.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                  return CategorieTile(
                    categorie: categories[index],
                    isSelected: selectedCategorie == categories[index],
                    context: this,
                  );
                    }),
              ),*/
              /*SizedBox(
                height: 20,
              ),*/
              Container(
                  height: 170,
                  child: BlocProvider<CovidBloc>(
                      create: (BuildContext context) =>
                      CovidBloc(repository: Repository())
                        ..add(CovidBdDataEvent(
                            param: "countries/bangladesh",
                            paramAll: "all")),
                      child: Container(
                        child: BlocBuilder<CovidBloc, CovidState>(
                          builder: (context, state) {
                            return Dashboard(state);
                          },
                        ),
                      ))),
              SizedBox(
                height: 45,
              ),
              AutoSizeText(
                "(কোভিড-১৯) এর ঝুঁকি রোধে করনীয়",
                textScaleFactor: 1.0,
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 166,
                child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              /*Image.asset('assets/tod.png'),*/
                              todo(
                                instruction:
                                "ঘন ঘন দুইহাত সবান পানি দিয়ে ভালোভাবে ধুয়ে নিন(কমপক্ষে ২০ সেকেন্ড)",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              todo(
                                instruction:
                                "হাঁচি-কাশির সময় টিস্যু/কাপড়/বাহুর ভাঁজে নাক-মুখ ঢেকে ফেলুন",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              todo(
                                instruction:
                                "অসুস্থ হলে বা অসুস্থ ব্যক্তির সংস্পর্শে আসলে বা আক্রান্ত দেশ থেকে আসলে মাস্ক ব্যবহার করুন",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              todo(
                                instruction:
                                "স্বাস্থ্য সেবায় নিয়োজিত সকলে মাস্ক ব্যবহার করুন",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              todo(
                                instruction:
                                "জরুরী প্রয়োজন ছাড়া ভিড় ও ভ্রমন এড়িয়ে চলুন",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              todo(
                                instruction:
                                "স্বাস্থ্য পরামর্শ পেতে ১৬২৬৩ অথবা ৩৩৩ নম্বরে কল করুন",
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Dashboard(CovidState state) {
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
      if (state.covidBdData != null && state.allData != null) {
        dataMap.putIfAbsent(
            "Active", () => state.covidBdData.active.toDouble());
        dataMap.putIfAbsent(
            "Recovered", () => state.covidBdData.recovered.toDouble());
        dataMap.putIfAbsent(
            "Deaths", () => state.covidBdData.deaths.toDouble());
        print("CovidBdState ${state.allData}");
        dataMapAll.putIfAbsent(
            "Total Cases ", () => (state.allData.cases).toDouble());
        dataMapAll.putIfAbsent(
            "Recovered", () => state.allData.recovered.toDouble());
        dataMapAll.putIfAbsent("Deaths", () => state.allData.deaths.toDouble());
        return ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      getItem(
                          state.covidBdData.todayCases, "২৪ ঘন্টায় আক্রান্ত"),
                      getItem(
                          state.covidBdData.todayDeaths, "২৪ ঘন্টায় মৃত্যু"),
                      getItem(state.covidBdData.deaths, "মোট মৃত্যু"),
                      getItem(state.covidBdData.recovered, "মোট সুস্থ"),
                      getItem(state.covidBdData.cases, "মোট আক্রান্ত"),
                      //getItem(state.covidBdData.casesPerOneMillion, "Cases Per Million"),
                    ],
                  ),
                ],
              );
            });
      }
      return Container();
    } else if (state is CovidErrorState) {
      print(state.error.toString());
      return Align(
          alignment: Alignment.center,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitPulse(
                  color: Colors.blueAccent,
                  size: 60.0,
                ),
                AutoSizeText("সার্ভার মেইনটেনেন্স"),
              ],
            ),
          ));
    }

    return Container(
      child: Stack(
        children: <Widget>[
          SpinKitPulse(
            color: Colors.blueAccent,
            size: 60.0,
          ),
        ],
      ),
    );
  }
}

class todo extends StatelessWidget {
  const todo({Key key, @required this.instruction}) : super(key: key);

  final String instruction;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          //color: Color(0xFFCCECF9),
          //color: Colors.red[400],
          color: Color(0xFFBD202E),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              "$instruction",
              textScaleFactor: 1.25,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class HeatMapTile extends StatelessWidget {
  Future<void> _startMap() async {
    try {
      final String result = await platform.invokeMethod('map');
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(20),
      color: Color(0xFFCCECF9),
      onPressed: () {
        if (Platform.isAndroid) {
          _startMap();
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Location()));
        }
      },
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/covid.png",
            height: 50,
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                "গুগল ম্যাপ",
                textScaleFactor: 1.0,
                style: TextStyle(color: Color(0xffFC9535), fontSize: 19),
              ),
              SizedBox(
                height: 2,
              ),
              AutoSizeText(
                "করোনা হিট ম্যাপ",
                textScaleFactor: 1.0,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.touch_app,
            size: 50,
            color: Colors.red,
          ),
        ],
      ),
    );
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

getItem(final data, String level) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  String dataInBengali = data.toString();
  for (int i = 0; i < english.length; i++) {
    dataInBengali = dataInBengali.replaceAll(english[i], farsi[i]);
  }

  return Container(
    padding: EdgeInsets.all(5),
    width: 150,
    height: 150,
    margin: EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      color: Colors.indigo[400],
      //color: Color(0xFFCCECF9),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          "$dataInBengali",
          textScaleFactor: 1.0,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "$level",
          textScaleFactor: 1.0,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    ),
  );
}

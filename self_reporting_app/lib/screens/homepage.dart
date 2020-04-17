import 'dart:io' show Platform;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfreportingapp/bloc/bloc.dart';
import 'package:selfreportingapp/bloc/event.dart';
import 'package:selfreportingapp/bloc/state.dart';
import 'package:selfreportingapp/initialize.dart';
import 'package:selfreportingapp/model/todo_list.dart';
import 'package:selfreportingapp/model/world_o_meter_repo.dart';
import 'package:selfreportingapp/screens/heatmap.dart';
import 'package:selfreportingapp/screens/support_page.dart';
import 'package:selfreportingapp/services/world_o_meter_api.dart';
import 'package:selfreportingapp/widgets/check_connection.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Report/report_main.dart';
import 'about_us.dart';

String title;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService;
  Map<String, int> dataMap = new Map();
  Map<String, double> dataMapAll = new Map();
  final controller = PageController(viewportFraction: 0.5, initialPage: 3);
  final controller2 = PageController(viewportFraction: 0.5, initialPage: 2);
  final controller3 = PageController(viewportFraction: 0.5, initialPage: 2);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'করোনা',
            style: TextStyle(
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
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    "assets/3623963.jpg",
                    fit: BoxFit.contain,
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      /// আপনি কি আক্রান্ত?
                      AutoSizeText(
                        "আপনি কি আক্রান্ত?",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CM Sans Serif',
                          fontSize: 26.0,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      /// করোনার সম্ভাব্যতা যাচাই করুন
                      FittedBox(
                        child: MaterialButton(
                          elevation: 10,
                          shape: StadiumBorder(),
                          color: Color(0xFFBD202E),
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportMain()));
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

                      /// করোনা হিট ম্যাপ
                      HeatMapTile(),
                      SizedBox(
                        height: 20,
                      ),

                      /// যোগাযোগ হটলাইন
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
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    child: AutoSizeText(
                                      "যোগাযোগ হটলাইন ৩৩৩ |",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: Colors.white,
                                        //fontSize: 19,
                                      ),
                                    ),
                                    onTap: () async {
                                      if (await canLaunch("tel:333")) {
                                        await launch("tel:333");
                                      } else {
                                        throw 'Could not launch';
                                      }
                                    },
                                  ),
                                  InkWell(
                                    child: AutoSizeText(
                                      " ১০৬৫৫ ",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: Colors.white,
                                        //fontSize: 19,
                                      ),
                                    ),
                                    onTap: () async {
                                      if (await canLaunch("tel:10655")) {
                                        await launch("tel:10655");
                                      } else {
                                        throw 'Could not launch';
                                      }
                                    },
                                  ),
                                  InkWell(
                                    child: AutoSizeText(
                                      "| ১৬২৬৩",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: Colors.white,
                                        //fontSize: 19,
                                      ),
                                    ),
                                    onTap: () async {
                                      if (await canLaunch("tel:16263")) {
                                        await launch("tel:16263");
                                      } else {
                                        throw 'Could not launch';
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              /// সর্বশেষ তথ্য
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AutoSizeText(
                  "সর্বশেষ তথ্য",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 26.0,
                  ),
                ),
              ),

              /// তথ্যসূত্র: WorldoMeter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AutoSizeText(
                  "তথ্যসূত্র: WorldoMeter",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 13.0,
                  ),
                ),
              ),
              Container(
                height: 500,
                child: BlocProvider<CovidBloc>(
                  create: (BuildContext context) =>
                      CovidBloc(repository: Repository())
                        ..add(CovidBdDataEvent(
                            param: "v2/countries/bangladesh",
                            paramAll: "v2/all")),
                  child: Center(
                    child: Container(
                      child: BlocBuilder<CovidBloc, CovidState>(
                        builder: (context, state) {
                          return dashboard(state);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              /* SizedBox(
                height: 30,
              ),*/

              /// ঝুঁকি রোধে করনীয়
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AutoSizeText(
                  "(কোভিড-১৯) এর ঝুঁকি রোধে করনীয়",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 26.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: PageView(
                            controller: controller,
                            children: List.generate(6, (i) {
                              return Center(
                                child: Card(
                                  elevation: 2.0,
                                  color: Color(0xFFBD202E),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 166,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                            todo[i],
                                            textScaleFactor: 1,
                                            maxLines: 10,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SmoothPageIndicator(
                          controller: controller,
                          count: 6,
                          effect: ScrollingDotsEffect(
                            activeDotColor: Color(0xFFBD202E),
                            dotColor: Colors.indigo[50],
                            activeStrokeWidth: 2.6,
                            activeDotScale: .4,
                            dotWidth: 10,
                            dotHeight: 10,
                            radius: 10,
                            spacing: 10,
                          )),
                    ],
                  ),
                ),
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

  Widget dashboard(CovidState state) {
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
        /* dataMap.putIfAbsent("Active", () => state.covidBdData.active.toInt());
        dataMap.putIfAbsent(
            "Recovered", () => state.covidBdData.recovered.toInt());
        dataMap.putIfAbsent("Deaths", () => state.covidBdData.deaths.toInt());
         print("CovidBdState ${state.covidBdData}");
        dataMapAll.putIfAbsent(
            "Total Cases ", () => (state.allData.cases).toDouble());
        dataMapAll.putIfAbsent(
            "Recovered", () => state.allData.recovered.toDouble());
        dataMapAll.putIfAbsent("Deaths", () => state.allData.deaths.toDouble());*/

        List<Widget> getLocalStatWidget = [
          getItem(state.covidBdData.recovered, "মোট সুস্থ"),
          getItem(state.covidBdData.cases, "মোট আক্রান্ত"),
          getItem(state.covidBdData.deaths, "মোট মৃত্যু"),
          getItem(state.covidBdData.todayDeaths, "২৪ ঘন্টায় মৃত্যু"),
          getItem(state.covidBdData.todayCases, "২৪ ঘন্টায় আক্রান্ত"),
        ];

        List<Widget> getGlobalStatWidget = [
          getItem(state.allData.recovered, "মোট সুস্থ"),
          getItem(state.allData.cases, "মোট আক্রান্ত"),
          getItem(state.allData.deaths, "মোট মৃত্যু"),
          getItem(state.allData.todayDeaths, "২৪ ঘন্টায় মৃত্যু"),
          getItem(state.allData.todayCases, "২৪ ঘন্টায় আক্রান্ত"),
        ];

        return Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  "বাংলাদেশ",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 26.0,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 166,
                  child: PageView(
                      controller: controller2,
                      children: List.generate(5, (i) {
                        return Center(
                          child: Card(
                            elevation: 5.0,
                            color: Colors.indigo[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 166,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    getLocalStatWidget[i],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 10,
                ),
                SmoothPageIndicator(
                    controller: controller2,
                    count: 5,
                    effect: ScrollingDotsEffect(
                      activeDotColor: Colors.indigo,
                      dotColor: Colors.indigo[50],
                      activeStrokeWidth: 2.6,
                      activeDotScale: .4,
                      dotWidth: 10,
                      dotHeight: 10,
                      radius: 10,
                      spacing: 10,
                    )),
                SizedBox(height: 15),
                AutoSizeText(
                  "বিশ্ব",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 26.0,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 166,
                  child: PageView(
                      controller: controller3,
                      children: List.generate(5, (i) {
                        return Center(
                          child: Card(
                            elevation: 3.0,
                            color: Colors.indigo[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 166,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    getGlobalStatWidget[i],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 10,
                ),
                SmoothPageIndicator(
                    controller: controller3,
                    count: 5,
                    effect: ScrollingDotsEffect(
                      activeDotColor: Colors.indigo,
                      dotColor: Colors.indigo[50],
                      activeStrokeWidth: 2.6,
                      activeDotScale: .4,
                      dotWidth: 10,
                      dotHeight: 10,
                      radius: 10,
                      spacing: 10,
                    )),
              ],
            ),
          ),
        );
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

class HeatMapTile extends StatelessWidget {
  Future<void> _startMap() async {
    const platform =
        const MethodChannel('com.tne.selfreportingapp/MAP_CHANNEL');
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
  const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  String dataInBengali = data.toString();
  for (int i = 0; i < english.length; i++) {
    dataInBengali = dataInBengali.replaceAll(english[i], bangla[i]);
  }

  return Column(
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
  );
}

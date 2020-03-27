import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/screens/tabs/developerStory.dart';
import 'package:covidtrackerbd/screens/tabs/home/api_service.dart';
import 'package:covidtrackerbd/screens/tabs/home/bloc/bloc.dart';
import 'package:covidtrackerbd/screens/tabs/home/bloc/event.dart';
import 'package:covidtrackerbd/screens/tabs/home/bloc/state.dart';
import 'package:covidtrackerbd/screens/tabs/home/repository.dart';
import 'package:covidtrackerbd/screens/tabs/location.dart';
import 'package:covidtrackerbd/screens/tabs/Report//survey_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String selectedCategorie = "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0x0F571783),
              ),
              child: Image.asset('assets/corona.png'),
            ),
            Container(
              decoration: new BoxDecoration(color: Color(0x0F2A76DE)),
              child: ListTile(
                title: Text("এবাউট আস"),
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
                title: Text("ফিডব্যাক"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/coronaInfo.png'),
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
              SizedBox(
                height: 35,
              ),
              AutoSizeText(
                "আপনি কি আক্রান্ত?",
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Material(
                color: Color(0xFFBD202E),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SurveyPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          "করোনার সম্ভাব্যতা যাচাই করুন",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 50,
                color: Color(0xFFBD202E),
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
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AutoSizeText(
                "সর্বশেষ তথ্য \nতথ্যসূত্র: DGHS",
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              /*SizedBox(
                height: 20,
              ),*/
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
                height: 20,
              ),
              AutoSizeText(
                "(কোভিড-১৯) এর ঝুঁকি রোধে করনীয়",
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/tod.png'),
                              SizedBox(
                                width: 100,
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
              HeatMapTile(),
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
            "Total Cases ",
            () => (state.allData.cases -
                    state.allData.recovered -
                    state.allData.deaths)
                .toDouble());
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
                      //getItem(state.covidBdData.critical, "Critical Cases"),
                      getItem(state.covidBdData.active, "একটিভ কেইসেস"),
                      getItem(
                          state.covidBdData.deaths +
                              state.covidBdData.recovered +
                              state.covidBdData.cases,
                          "মোট আক্রান্ত"),
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

class HeatMapTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFCCECF9),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Location()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
                    style: TextStyle(color: Color(0xffFC9535), fontSize: 19),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  AutoSizeText(
                    "করোনা হিট ম্যাপ",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                decoration: BoxDecoration(
                    color: Color(0xFFBD202E),
                    borderRadius: BorderRadius.circular(13)),
                child: AutoSizeText(
                  "ক্লিক",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
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
  return Container(
    width: 150,
    height: 150,
    margin: EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      color: Color(0xFFCCECF9),
      //borderRadius: BorderRadius.circular(24)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          "$data",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "$level",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Color(0xFF3C4C99)),
        )
      ],
    ),
  );
}
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfreportingapp/services/app_update.dart';
import 'package:selfreportingapp/widgets/update_popup.dart';
import '../widgets/SKOnBoarding/sk_onboarding_model.dart';
import '../widgets/SKOnBoarding/sk_onboarding_screen.dart.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    try {
      checkForUpdate();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  final pageList = [
    SkOnboardingModel(
      title: 'আমার নিরাপত্তা \nআমার হাতে',
      description: 'অসুস্থ হলে বা অসুস্থ ব্যক্তির সংস্পর্শে আসলে বা আক্রান্ত দেশ থেকে আসলে মাস্ক ব্যবহার করুন',
      titleColor: Colors.black,
      descripColor: Colors.black45,
      imagePath: 'assets/people.jpg',
    ),
    SkOnboardingModel(
      title: 'জরুরী প্রয়োজন ছাড়া ভিড় এবং ভ্রমন এড়িয়ে চলুন',
      description: 'স্বাস্থ্য পরামর্শ পেতে ১৬২৬৩ অথবা ৩৩৩ নম্বরে কল করুন',
      titleColor: Colors.black,
      descripColor: Colors.black45,
      imagePath: 'assets/people.jpg',
    ),
//    PageModel(
//      color: Color(0xFFDEE0DF),
//      heroAssetPath: 'assets/people.jpg',
//      title: AutoSizeText(
//        'আমার নিরাপত্তা \nআমার হাতে',
//        textAlign: TextAlign.center,
//        textScaleFactor: 1,
//        style: TextStyle(
//          color: Colors.black,
//          fontSize: 26.0,
//          height: 1.5,
//        ),
//      ),
//      body: AutoSizeText(
//        'অসুস্থ হলে বা অসুস্থ ব্যক্তির সংস্পর্শে আসলে বা আক্রান্ত দেশ থেকে আসলে মাস্ক ব্যবহার করুন',
//        textScaleFactor: 1,
//        textAlign: TextAlign.center,
//        style: TextStyle(
//          color: Colors.black,
//          fontSize: 18.0,
//          height: 1.2,
//        ),
//      ),
//      iconAssetPath: 'assets/circle.png',
//    ),
//    PageModel(
//      color: Color(0xFFDEE0DF),
//      heroAssetPath: 'assets/people.jpg',
//      title: AutoSizeText(
//        'জরুরী প্রয়োজন ছাড়া ভিড় এবং ভ্রমন এড়িয়ে চলুন',
//        textAlign: TextAlign.center,
//        textScaleFactor: 1,
//        style: TextStyle(
//          color: Colors.black,
//          fontSize: 26.0,
//          height: 1.5,
//        ),
//      ),
//      body: AutoSizeText(
//        'স্বাস্থ্য পরামর্শ পেতে ১৬২৬৩ অথবা ৩৩৩ নম্বরে কল করুন',
//        textScaleFactor: 1,
//        textAlign: TextAlign.center,
//        style: TextStyle(
//          color: Colors.black,
//          fontSize: 18.0,
//          height: 1.2,
//        ),
//      ),
//      iconAssetPath: 'assets/circle.png',
//    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: Color(0xFF7B51D3),
        pages: pageList,
        skipClicked: (value) {
          Navigator.of(context).pushReplacementNamed('/HomePage');
        },
        getStartedClicked: (value) {
          Navigator.of(context).pushReplacementNamed('/HomePage');
        },
      ),
//      body: FancyOnBoarding(
//        doneButtonText: "সমাপ্ত",
//        skipButtonText: "Skip",
//        doneButtonBackgroundColor: Colors.black54,
//        pageList: pageList,
//        onDoneButtonPressed: () =>
//            Navigator.of(context).pushReplacementNamed('/HomePage'),
//        onSkipButtonPressed: () =>
//            Navigator.of(context).pushReplacementNamed('/HomePage'),
//      ),
    );
  }
}


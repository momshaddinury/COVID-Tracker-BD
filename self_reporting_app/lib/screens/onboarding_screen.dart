import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFDEE0DF),
                Color(0xFFBFBFBF),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/HomePage');
                    },
                    child: AutoSizeText(
                      'স্কীপ',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                (MediaQuery.of(context).size.height < 700)?
                Container(
                  height: MediaQuery.of(context).size.height * .8 - 20,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/people.jpg',
                                ),
//                                  height: 300.0,
//                                  width: 300.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'আমার নিরাপত্তা \nআমার হাতে',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            AutoSizeText(
                              'অসুস্থ হলে বা অসুস্থ ব্যক্তির সংস্পর্শে আসলে বা আক্রান্ত দেশ থেকে আসলে মাস্ক ব্যবহার করুন',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/people.jpg',
                                ),
//                                  height: 300.0,
//                                  width: 300.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'জরুরী প্রয়োজন ছাড়া ভিড় এবং ভ্রমন এড়িয়ে চলুন',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            AutoSizeText(
                              'স্বাস্থ্য পরামর্শ পেতে ১৬২৬৩ অথবা ৩৩৩ নম্বরে কল করুন',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    :

//                      for large phone
                Container(
                  height: 600,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/people.jpg',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            AutoSizeText(
                              'আমার নিরাপত্তা \nআমার হাতে',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            AutoSizeText(
                              'অসুস্থ হলে বা অসুস্থ ব্যক্তির সংস্পর্শে আসলে বা আক্রান্ত দেশ থেকে আসলে মাস্ক ব্যবহার করুন',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/people.jpg',
                                ),
                                  height: 300.0,
                                  width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            AutoSizeText(
                              'জরুরী প্রয়োজন ছাড়া ভিড় এবং ভ্রমন এড়িয়ে চলুন',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            AutoSizeText(
                              'স্বাস্থ্য পরামর্শ পেতে ১৬২৬৩ অথবা ৩৩৩ নম্বরে কল করুন',
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AutoSizeText(
                          'Next',
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: AutoSizeText(
                      'শুরু করুন',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

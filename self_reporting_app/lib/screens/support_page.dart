import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset("assets/love.gif"),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: AutoSizeText(
                "THANK YOU FOR YOUR SUPPORT\n\nEMAIL: index.zeroth@gmail.com\n\nCALL: 01407869294\n\nPAGE:https://www.facebook.com/zeroth.index/",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

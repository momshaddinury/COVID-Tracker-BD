import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DeveloperStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 200,
                  child: Image.asset('assets/bd.jpg'),
                ),
                Text(
                  "This has been a total team effort. All of the members are students of EEE, CU. This is a small effort towards solving the national crisis.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://scontent.fcgp14-1.fna.fbcdn.net/v/t1.0-9/s960x960/88155240_3537590306315365_6564789638567821312_o.jpg?_nc_cat=106&_nc_sid=85a577&_nc_eui2=AeFNnDF_UlvlYdtXmQ1VF7CrXerCGRA9KEXEQwZd-_d_sie4Jo4RyabWV-CfXZbUeTqB-r6D274Tw1AqLJGyXBO0ThYL6-fsYGRYEtrXax0P0A&_nc_ohc=E82RLCxU3LQAX9Igjy0&_nc_ht=scontent.fcgp14-1.fna&_nc_tp=7&oh=6c26d3ba4c57803bfc7acbce12f9617c&oe=5EA92894"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Momshad Dinury\nLead App Developer",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://scontent.fcgp14-1.fna.fbcdn.net/v/t1.0-9/p960x960/67335915_2404977866192194_6920263697742954496_o.jpg?_nc_cat=102&_nc_sid=7aed08&_nc_eui2=AeEXHPtPB7x5ikGo0IUuA0IUCIpALalujdpi5DZ-6tc6JtOOf3wXFsom0514gq50gPAx-xESM64QeEwFCO0oazxZR49zE6FVI44FzZCDXAbMsw&_nc_ohc=UyxF_vC_Fh4AX_cBk14&_nc_ht=scontent.fcgp14-1.fna&_nc_tp=6&oh=5f017338b4f29804e38fd45084b91bf5&oe=5EA7B500"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  "Abdullah Z Khan\n Cloud Function & Firebase",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://scontent.fcgp14-1.fna.fbcdn.net/v/t1.0-9/89435181_2566724786787562_3468197142470852608_n.jpg?_nc_cat=105&_nc_sid=85a577&_nc_eui2=AeFTVduIdTmXAM37V3FtHUc3u9wj3U1IOdc4v0QG9hMdFE3ILqGOXv75sNdT9aPHDHl340foM5KZ_k_3PT6vM-nlbDOM3aXj-wwzx0AYYTswHQ&_nc_ohc=v692qvORxbYAX9qX_JB&_nc_ht=scontent.fcgp14-1.fna&oh=dc05a499a1f526028cc9c856c70cefa3&oe=5EA6AD81"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  "Mahbubur Rahman\n Server & API",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "CONTRIBUTORS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://scontent.fcgp14-1.fna.fbcdn.net/v/t1.0-9/15078855_10209414460531101_5867073609415938043_n.jpg?_nc_cat=109&_nc_sid=85a577&_nc_eui2=AeE1aZMVQ3H2pP3cgMeBmVyu6jnn_0VFnl8ypru5FK1GBRrTJ5bC4qUQGw1nAYWo2PjC6afoUFArKwwP7FzE2-d66BUbqMKrhX3CbLl7JeHZ0Q&_nc_ohc=rtNj00m1J3oAX-PzqHC&_nc_ht=scontent.fcgp14-1.fna&oh=d1a5bb317d9f1432cd2f22864925e027&oe=5EA9B372"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Asif Atick\n@HeadBlocks",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://avatars1.githubusercontent.com/u/14052795?s=400&u=4c77770b8ca079dacb5198c122fd1fa49da3430b&v=4"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Mahmudul Hassan Navid\n@Headblocks",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://avatars1.githubusercontent.com/u/5646002?s=400&v=4"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Nur Farazi\n@Jeeon Bangladesh",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Thanks to C19 Emergency Response Group, we were able to make this app. Without their continuous support & guideline it wouldn't been possible. Special thanks to  Faisal Bin Kashem & Muktashif Anwar Dhrubo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Image.asset('assets/0th-I.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants//country.dart';
import '../constants//helper.dart';
import 'InfoShow.dart';

class Details extends StatelessWidget {
  final List<Country> countries;

  Details({
    this.countries,
  });

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      height: data.size.height,
      width: data.size.width,
      child: Center(
        child: DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.85,
          builder: (BuildContext context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Center(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: countries.length * 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        padding: EdgeInsets.only(top: 25),
                        child: Center(
                          child: Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: data.size.width * 0.08,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    } else if (index % 2 == 1) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: data.size.width * 0.1,
                          vertical: data.size.height * 0.05,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                countries[index ~/ 2].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: data.size.width * 0.1,
                                ),
                              ),
                              SizedBox(
                                height: data.size.width * 0.08,
                              ),
                              InfoShow(
                                top: countries[index ~/ 2].totalCases,
                                left: countries[index ~/ 2].deaths,
                                right: countries[index ~/ 2].recovered,
                                size: data.size.width * 0.08,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: data.size.width * 0.1,
                        ),
                        height: data.size.height * 0.005,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            data.size.height * 0.005,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

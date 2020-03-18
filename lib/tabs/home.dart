import 'package:covidtrackerbd/service & api//JSONHandler.dart';
import 'package:flutter/material.dart';
import 'package:covidtrackerbd/widgets/cards.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Cards(
            "Total Cases",
            "$infected",
            colorValue: Color(0xFFCC231C),
          )),
          Expanded(
              child: Cards(
            "Deaths",
            "$dead",
            colorValue: Color(0xFF242424),
          )),
          Expanded(
              child: Cards("Recovered", "$recovered",
                  colorValue: Color(0xFF04E474))),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: ListView(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        title: Text(
                          "Q&A COVID-19 (Source - WHO)",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        title: Text('What is a coronavirus?'),
                        subtitle: Text(
                          "Coronaviruses are a large family of viruses which may cause illness in animals or humans.  In humans, several coronaviruses are known to cause respiratory infections ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS). The most recently discovered coronavirus causes coronavirus disease COVID-19.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      ListTile(
                        title: Text('What is COVID-19?'),
                        subtitle: Text(
                          "COVID-19 is the infectious disease caused by the most recently discovered coronavirus. This new virus and disease were unknown before the outbreak began in Wuhan, China, in December 2019.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      ListTile(
                        title: Text('What are the symptoms of COVID-19?'),
                        subtitle: Text(
                          "The most common symptoms of COVID-19 are fever, tiredness, and dry cough. Some patients may have aches and pains, nasal congestion, runny nose, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but don’t develop any symptoms and don't feel unwell. Most people (about 80%) recover from the disease without needing special treatment. Around 1 out of every 6 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart problems or diabetes, are more likely to develop serious illness. People with fever, cough and difficulty breathing should seek medical attention.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      ListTile(
                        title: Text('How does COVID-19 spread?'),
                        subtitle: Text(
                          "People can catch COVID-19 from others who have the virus. The disease can spread from person to person through small droplets from the nose or mouth which are spread when a person with COVID-19 coughs or exhales. These droplets land on objects and surfaces around the person. Other people then catch COVID-19 by touching these objects or surfaces, then touching their eyes, nose or mouth. People can also catch COVID-19 if they breathe in droplets from a person with COVID-19 who coughs out or exhales droplets. This is why it is important to stay more than 1 meter (3 feet) away from a person who is sick.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      ListTile(
                        title: Text(
                            'Can the virus that causes COVID-19 be transmitted through the air?'),
                        subtitle: Text(
                          "Studies to date suggest that the virus that causes COVID-19 is mainly transmitted through contact with respiratory droplets rather than through the air.  See previous answer on “How does COVID-19 spread?”",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ).toList(),
                ),
              ),
            ),
          ),
          /*SizedBox(
            height: 10,
          )*/
        ],
      ),
    );
  }
}

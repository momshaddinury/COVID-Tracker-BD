import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:selfreportingapp/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
  })  : _fbKey = fbKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            color: Colors.red,
            child: Text(
              "ফিরে যান",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              toast("অপেক্ষা করুন");
              _fbKey.currentState.reset();
              // await auth.signOut();
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: MaterialButton(
            color: Theme.of(context).accentColor,
            child: Text(
              "রিসেট",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              toast("অপেক্ষা করুন");
              _fbKey.currentState.reset();
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: MaterialButton(
            color: Colors.green,
            child: Text(
              "জমা দিন",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              toast("অপেক্ষা করুন");
              if (_fbKey.currentState.saveAndValidate()) {
                toast("প্রসেসিং");

                print(_fbKey.currentState.value);
                //await orgLoginResponse();
                await submitResponse();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("টেস্ট রেজাল্ট"),
                    content: SingleChildScrollView(
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: RichText(
                            text: TextSpan(
                              text: 'ফলাফল: $assessmentMessage\n',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.none,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "\nআইডি: $userID\n",
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Html(
                            data: """$notes""",
                            onLinkTap: (url) async {
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('ওকে'),
                      ),
                    ],
                  ),
                );
                //await auth.signOut();
                toast("সফল ভাবে জমা হয়েছে");
              } else {
                print(_fbKey.currentState.value);
                toast("পুনরায় চেক করুন");
                print("ভেলিডেশন ফেইল্ড");
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:selfreportingapp/widgets/loading.dart';
import 'package:selfreportingapp/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
  })  : _fbKey = fbKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
              Dialogs.showLoadingDialog(context, _keyLoader);
              if (_fbKey.currentState.saveAndValidate()) {
                print(_fbKey.currentState.value);
                //await orgLoginResponse();
                await postMainCaseReport();
                Navigator.of(_keyLoader.currentContext, rootNavigator: false)
                    .pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    content: SingleChildScrollView(
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/HomePage', (Route<dynamic> route) => false);
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

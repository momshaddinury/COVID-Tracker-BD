import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import 'package:selfreportingapp/services/json_handle.dart';

String appVersion = "https://zerothindex.org/app_version";
String updatedVersion = version;
String currentVersion;
bool needsUpdate = false;

getInfo() async {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    currentVersion = packageInfo.version;
    print(currentVersion);
  });

  var _response = await checkForAppVersionAPI();
  print(_response.body.toString());
  parseJson.decodeJson(_response.body);
}

Future<http.Response> checkForAppVersionAPI() async {
  var _response = await http.get(appVersion);
  return _response;
}

checkForUpdate() {
  getInfo().then((value) {
    if (int.parse(currentVersion[0]) < int.parse(updatedVersion[0])) {
      print(needsUpdate);
      needsUpdate = true;
      print(needsUpdate);
    }
  });
}

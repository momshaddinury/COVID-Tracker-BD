import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:geolocator/geolocator.dart';

getLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.latitude);
  print(position.longitude);
  location = "lat: ${position.latitude}, lon: ${position.longitude}, alt: ${position.altitude}";
}

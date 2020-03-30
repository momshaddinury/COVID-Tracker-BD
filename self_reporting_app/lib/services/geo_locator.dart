import 'package:geolocator/geolocator.dart';
import 'package:selfreportingapp/model/patient_data.dart';

Position position;

getLocation() async {
  position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.latitude);
  print(position.longitude);

  location =
      "lat: ${position.latitude}, lon: ${position.longitude}, alt: ${position.altitude}";
}

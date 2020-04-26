import 'package:geolocator/geolocator.dart';

Position position;
String location;

getLocation() async {
  position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  location =
      "lat: ${position.latitude}, lon: ${position.longitude}, alt: ${position.altitude}";
}

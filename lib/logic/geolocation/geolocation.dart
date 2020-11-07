import 'package:geolocator/geolocator.dart';

class UserLocation {
  static Future<Position> currentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  permit() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
  }
}

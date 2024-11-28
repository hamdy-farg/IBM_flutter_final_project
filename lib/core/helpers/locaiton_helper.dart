// This is Method to check the locatinn permissions and connectivity also and get Cerrent location.  

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationHelper {
  static Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Handle service disabled
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // Permission denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // Permission denied forever
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}

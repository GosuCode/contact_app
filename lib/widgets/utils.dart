import 'package:location/location.dart';

class LocationFunctions {
  static Location location = new Location();
  static Future<bool> locationEnabled() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
    // _locationData = await location.getLocation();
  }

  static Future<LocationData?> getCurrentLocation() async {
    if (await locationEnabled()) {
      LocationData currLoc = await location.getLocation();
      return currLoc;
    } else {
      return null;
    }
  }
}
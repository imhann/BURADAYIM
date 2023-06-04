import 'package:location/location.dart';

class LocationHelper {
  //boylam
  double? lan;

  //enlem
  double? lat;

  //https://api.openweathermap.org/data/2.5/weather?lat=37.4217937&lon=-122.083922&appid=7bc0d6fd41a881f739fdbc74a7a9c9e1

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    lat = locationData.latitude;
    lan = locationData.longitude;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier{
  LatLng? location;
  void updateLocation(LatLng newLocation){
    location = newLocation;
    notifyListeners();
  }
  void clearLocation(){
    location = null;
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:red_vital/model/place_search.dart';
import 'package:red_vital/screens/maps/services/geolocator_service.dart';
import 'package:red_vital/screens/maps/services/places_services.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

//  Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTeam) async{
    searchResults = await placesService.getAutoComplete(searchTeam);
    notifyListeners();
  }
}


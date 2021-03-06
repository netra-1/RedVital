import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:red_vital/model/geometry.dart';
import 'package:red_vital/model/location.dart';
import 'package:red_vital/model/place.dart';
import 'package:red_vital/model/place_search.dart';
import 'package:red_vital/screens/maps/services/geolocator_service.dart';
import 'package:red_vital/screens/maps/services/marker_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:red_vital/model/place_search.dart';
import 'package:red_vital/screens/maps/services/geolocator_service.dart';
import 'package:red_vital/screens/maps/services/places_services.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

//  Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place? selectedLocationStatic;
  String? placeType;
  List<Place>? placeResults;
  // List<Marker> markers = <Marker>[];
  List<Marker> markers = List<Marker>.empty(growable: true);

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    // selectedLocationStatic = Place(name: '',
    //   geometry: Geometry(location: Location(
    //       lat: currentLocation!.latitude, lng: currentLocation!.longitude),), vicinity: '',
    //   );
    selectedLocationStatic = Place(name: '',
      geometry: Geometry(location: Location(
          lat: currentLocation!.latitude, lng: currentLocation!.longitude),),
    );
    notifyListeners();
  }

  searchPlaces(String searchTeam) async{
    searchResults = await placesService.getAutoComplete(searchTeam);
    notifyListeners();
  }
  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic!.geometry.location.lat,
          selectedLocationStatic!.geometry.location.lng, placeType!);
      markers= [];

      if (places.length > 0) {
        var newMarker = markerService.createMarkerFromPlace(places[0],false);
        markers.add(newMarker);
      }

      var locationMarker = markerService.createMarkerFromPlace(selectedLocationStatic!,true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}


import 'package:http/http.dart' as http;
import 'package:red_vital/model/place.dart';
import 'dart:convert' as convert;

import 'package:red_vital/model/place_search.dart';

class PlacesService{
  final key = 'AIzaSyAxnrTuuRm7yftfGU--TB-YfRCsm4rC-CM';

  Future<List<PlaceSearch>> getAutoComplete(String search) async{
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["predictions"] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();

  }

  Future<Place> getPlace(String placeId) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }


  Future<List<Place>> getPlaces(double lat, double lng, String placeType) async{
    var url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?type=$placeType&location=$lat,$lng&rankby=distance&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["results"] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}
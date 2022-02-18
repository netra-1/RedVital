import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:red_vital/model/place_search.dart';

// class for places search dart
class PlacesService{
  final key = 'AIzaSyAxnrTuuRm7yftfGU--TB-YfRCsm4rC-CM';

  Future<List<PlaceSearch>> getAutoComplete(String search) async{
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key";
    var response = await http.get(Uri.parse(url)); // response var
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["predictions"];
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();

  }
}
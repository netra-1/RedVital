import 'package:red_vital/model/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  // final String vicinity;

  Place({required this.geometry,required this.name});

  factory Place.fromJson(Map<String,dynamic> json){
    return Place(
      geometry:  Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      // vicinity: json['vicinity'],
    );
  }
}
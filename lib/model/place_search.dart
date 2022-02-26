class PlaceSearch{
  final String description;
  final String placeId;

  PlaceSearch({required this.description, required this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json){
    return PlaceSearch(
      description: json['description'],
<<<<<<< HEAD
      placeId: json['place_id'],
=======
      placeId: json['place_id']
>>>>>>> afee6102c027c4a1061bc69655f22356ea949463
    );
  }
}
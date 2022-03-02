import 'package:geolocator/geolocator.dart';

// class for geolocator service
class GeolocatorService{
  Future<Position> getCurrentLocation() async{
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
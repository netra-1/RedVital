import 'package:geolocator/geolocator.dart';

<<<<<<< HEAD
=======
// class for geolocator service
>>>>>>> afee6102c027c4a1061bc69655f22356ea949463
class GeolocatorService{
  Future<Position> getCurrentLocation() async{
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
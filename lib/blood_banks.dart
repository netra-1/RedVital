import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'Assistants/assistantMethods.dart';

class BloodBanks extends StatefulWidget {
  const BloodBanks({Key? key}) : super(key: key);

  @override
  _BloodBankState createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBanks>{

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();



 void locatePosition() async{
   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   currentPosition = position;

   // LocationPermission permission;
   // permission = await Geolocator.requestPermission();

   LatLng latLatPosition = LatLng(position.latitude, position.longitude);

   CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
   newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

   String address = await AssistantMethods.searchCoordinateAddress(position, context);
   print("This is your address:: "+ address);
 }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.723120, 85.322573),
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Banks"),
      ),

      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locatePosition();
            },

          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 30,
            ),
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff52555a),
                  ),
                  hintText: "Search blood banks...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

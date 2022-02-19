import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(27.7215,85.3201);
const LatLng DEST_LOCATION = LatLng(27.7062581,85.3278125);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class BloodBanks extends StatefulWidget {
  const BloodBanks({Key? key}) : super(key: key);

  @override
  _BloodBanksState createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  Set<Marker> _markers = Set<Marker>();

  LatLng? currentLocation;
  LatLng? destinationLocation;



  @override
  void initState() {
    super.initState();

    // polylinePoints = PolylinePoints();

    // set up initial locations
    this.setInitialLocation();


    this.setSourceAndDestinationMarkerIcons();

  }



  void setSourceAndDestinationMarkerIcons() async {
    // String parentCat = widget.subCategory!.imgName!.split("_")[0];

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'images/source.png'
    );

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'images/destination.png'
    );
  }

  void setInitialLocation() {
    currentLocation = LatLng(
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude
    );

    destinationLocation = LatLng(
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude
    );
  }

  @override
  Widget build(BuildContext context) {

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                // polylines: _polylines,
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                  showPinsOnMap();
                },
              )
          ),

          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('images/profile.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text("John Doe",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                          Text("Current Location",
                            style: TextStyle(
                                color: Colors.red
                            ),
                          )

                        ],
                      ),
                    ),
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    )
                  ],
                ),

              )
          )

        ],
      ),
    );
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: currentLocation!,
        icon: sourceIcon!,
        // onTap: () {
        //   setState(() {
        //     this.userBadgeSelected = true;
        //   });
        // }
      ));

      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation!,
        icon: destinationIcon!,
        // onTap: () {
        //   setState(() {
        //     this.pinPillPosition = PIN_VISIBLE_POSITION;
        //   });
        // }
      ));
    });
  }

}

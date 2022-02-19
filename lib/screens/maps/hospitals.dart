import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:provider/provider.dart';
import 'package:red_vital/model/place.dart';
import 'package:red_vital/screens/maps/blocs/application_bloc.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  Completer<GoogleMapController> _mapController = Completer();

  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
    Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    boundsSubscription = applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSubscription.cancel();
    _locationController.dispose();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
        body: (applicationBloc.currentLocation == null)
        ? Center(
          child: CircularProgressIndicator(),
        )
        : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Location",
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => applicationBloc.searchPlaces(value),
                ),
              ),
              Stack(
                children: [
                  Container(
                    // width: screenWidth,
                    // width: double.infinity,
                    height: screenHeight*0.67,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      compassEnabled: false,
                      tiltGesturesEnabled: false,
                      markers: Set<Marker>.of(applicationBloc.markers),
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(applicationBloc.currentLocation!.latitude,
                            applicationBloc.currentLocation!.longitude),
                        zoom: 14),
                      onMapCreated: (GoogleMapController controller){
                        _mapController.complete(controller);
                      },
                    ),
                  ),

                  if (applicationBloc.searchResults != null &&
                      applicationBloc.searchResults?.length !=0)
                    Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      backgroundBlendMode: BlendMode.darken
                    ),
                  ),

                  if (applicationBloc.searchResults != null &&
                  applicationBloc.searchResults?.length !=0)
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: applicationBloc.searchResults?.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Text(
                            applicationBloc.searchResults![index].description,
                            style: TextStyle(
                              color: Colors.white
                          ),),
                          onTap: (){
                            applicationBloc.setSelectedLocation(
                              applicationBloc.searchResults![index].placeId
                            );
                          },
                        );
                      }
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Find Nearest',
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Wrap(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                        label: Text('Hospital'),
                        onSelected: (val) => applicationBloc
                            .togglePlaceType('hospital', val),
                        selected:
                        applicationBloc.placeType  =='hospital',
                        selectedColor: Colors.red),
                    FilterChip(
                        label: Text('Blood Bank'),
                        onSelected: (val) => applicationBloc
                            .togglePlaceType('zoo', val),
                        selected:
                        applicationBloc.placeType  =='zoo',
                        selectedColor: Colors.red),
                  ],
                ),
              )
            ],
          )
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }

}

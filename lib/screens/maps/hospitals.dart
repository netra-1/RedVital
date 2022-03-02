import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:provider/provider.dart';
import 'package:red_vital/screens/maps/blocs/application_bloc.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final applicationBloc = Provider.of<ApplicationBloc>(context);
    // print(applicationBloc.searchResults![0].description);

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
                  width: screenWidth,
                  height: screenHeight*0.5,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(applicationBloc.currentLocation!.latitude,
                            applicationBloc.currentLocation!.longitude),
                        zoom: 14
                    ),
                  ),
                ),

                if (applicationBloc.searchResults != null && applicationBloc.searchResults?.length !=0)
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        backgroundBlendMode: BlendMode.darken
                    ),
                  ),

                if (applicationBloc.searchResults != null && applicationBloc.searchResults?.length !=0)
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
                          );
                        }
                    ),
                  )
              ],
            )
          ],
        )
    );
  }
}

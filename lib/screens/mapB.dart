import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/addpetrolstation.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapB extends StatefulWidget {
  @override
  _MapBState createState() => _MapBState();
}

class _MapBState extends State<MapB> {

  LatLng _initialPosition = LatLng(2.2214,102.4531);
  GoogleMapController _controller;
  Location _location = Location();
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  var lat , long;
  Map<String, double> userLocation;

  var location = new Location();

  void _onUserCurrentLocation() {

    setState(() {
      _markers.add(Marker(

        markerId: MarkerId(_initialPosition.toString()),
        position: LatLng(lat, long),
      ));
    });
  }

  void _onMapCreated(GoogleMapController _cntrl) async {
    Position currentLocation = await Geolocator.getCurrentPosition();

    _controller = _cntrl;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(2.2214,102.4531),
            zoom: 15,
          ),
        ),
      );

      setState(() {
        LatLng(currentLocation.latitude, currentLocation.longitude);
        _onUserCurrentLocation();
      });
    });
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        elevation: 0.0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 10),
            mapType: _currentMapType,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: {malaysia1Marker, malaysia2Marker, malaysia3Marker},
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget> [
                  SizedBox(height: 50.0),
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPetrolStation()));
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.add, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Marker malaysia1Marker = Marker(
  markerId: MarkerId('malaysia1'),
  position: LatLng(2.22086766,102.45945301),
  infoWindow: InfoWindow(title: "Petronas Semujok"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

Marker malaysia2Marker = Marker(
  markerId: MarkerId('malaysia2'),
  position: LatLng(2.21445387,102.45539516),
  infoWindow: InfoWindow(title: "Shell Semujok"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

Marker malaysia3Marker = Marker(
  markerId: MarkerId('malaysia3'),
  position: LatLng(2.22260442,102.44953957),
  infoWindow: InfoWindow(title: "Petron Semujok"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

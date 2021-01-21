import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Map123 extends StatefulWidget {
  @override
  _Map123State createState() => _Map123State();
}

class _Map123State extends State<Map123> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(2.2214,102.4531);
  LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  var lat , long;
  CameraPosition currentPosition;



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onUserCurrentLocation() {

    setState(() {
      _markers.add(Marker(

        markerId: MarkerId(_lastMapPosition.toString()),
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }


  void location() async {

    Position currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {

      LatLng(currentLocation.latitude, currentLocation.longitude);
      _onUserCurrentLocation();

    });
  }

@override
void initState(){
  location();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget> [
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
                    onPressed: _onUserCurrentLocation,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.location_history, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: _onUserCurrentLocation,
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

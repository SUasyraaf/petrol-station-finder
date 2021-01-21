import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  Location _location = Location();
  Completer<GoogleMapController> _controller = Completer();
  LatLng _initialPosition = LatLng(2.2214,102.4531);
  // GoogleMapController _controller;
  // Location _location = Location();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;


  void _onMapCreated(GoogleMapController _cntrl) {
    GoogleMapController _controller;
    Location _location = Location();

    _controller = _cntrl;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude, l.longitude),
            zoom: 15,
          ),
        ),
      );
    });
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
        title: Text("Map"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.zoom_out, color: Colors.blue),
        onPressed: () {
          zoomVal--;
          _minus(zoomVal);
        },
      ),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(Icons.zoom_in, color: Colors.blue),
        onPressed: () {
          zoomVal++;
          _plus(zoomVal);
        },
      ),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(3.2074316969019705,101.48309697995171), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(3.2074316969019705,101.48309697995171), zoom: zoomVal)));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 15,
            tilt: 50.0,
            bearing: 45.0,
        )
      )
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://static.imoney.my/articles/wp-content/uploads/2020/01/23163938/petronas.jpg",
                    3.2013534759008735,
                    101.48122689010147,
                    "Petronas Saujana Utama"),
              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://www.bikesrepublic.com/wp-content/uploads/2020/06/shell-cover.jpg",
                    3.2053460369013913,
                    101.4874837332662,
                    "Shell Saujana Utama"),
              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://assets.theedgemarkets.com/Petron-1_theedgemarkets_4.jpg?null",
                    3.206418662575518,
                    101.47718829181079,
                    "Petron Saujana Utama"),
              ),
            ],
          )),
    );
  }

  Widget _boxes(String _image, double lat, double long, String petrolName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer(petrolName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer(String petrolName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              petrolName,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "4.1",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Text(
                  "946",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Text(
            "Malaysia \u00B7 RM \u00B7 1.6 km",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Text(
            "Closed \u00B7 Opens 17:00 Thu",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ), 
        ),
      ],
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: GoogleMap(
          initialCameraPosition:
          CameraPosition(target: _initialPosition, zoom: 10),
          mapType: MapType.terrain,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          markers: {malaysia1Marker, malaysia2Marker, malaysia3Marker},
      ),
    );
  }
}

Marker malaysia1Marker = Marker(
  markerId: MarkerId('malaysia1'),
  position: LatLng(3.2013534759008735,101.48122689010147),
  infoWindow: InfoWindow(title: "Petronas Saujana Utama"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

Marker malaysia2Marker = Marker(
  markerId: MarkerId('malaysia2'),
  position: LatLng(3.2053460369013913,101.4874837332662),
  infoWindow: InfoWindow(title: "Shell Saujana Utama"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

Marker malaysia3Marker = Marker(
  markerId: MarkerId('malaysia3'),
  position: LatLng(3.206418662575518,101.47718829181079),
  infoWindow: InfoWindow(title: "Petron Saujana Utama"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  ),
);

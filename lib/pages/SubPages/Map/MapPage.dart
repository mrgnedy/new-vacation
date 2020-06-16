import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vacatiion/utility/colors.dart';

class MapTypes extends StatefulWidget {
  double lat;
  double long;
  String namelocation = "السعوديه";

  MapTypes({this.lat, this.long, this.namelocation});

  @override
  _MapTypesState createState() => _MapTypesState();
}

class _MapTypesState extends State<MapTypes> {
  static double lat = 26.8206;
  static double long = 30.8025;

  Set<Circle> circles;
  BitmapDescriptor myIcon;

  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(30, 30)),
      'assets/chalet.png',
    ).then((onValue) {
      myIcon = onValue;
    });

    setState(() {
      lat = widget.lat??0.00;
      long = widget.long??0.00;
    });
    _goToCurrentLocation();

    circles = Set.from([
      Circle(
        circleId: CircleId("20"),
        center: LatLng(lat, long),
        radius: 300,
        fillColor: ColorsV.defaultColor.withOpacity(0.5),
        strokeColor: ColorsV.defaultColor,
        strokeWidth: 1,
      )
    ]);

    super.initState();
  }
  
  setCircles(LatLng latlang) {
    return circles = Set.from([
      Circle(
        circleId: CircleId("20"),
        center: latlang,
        radius: 300,
        fillColor: ColorsV.defaultColor.withOpacity(0.5),
        strokeColor: ColorsV.defaultColor,
        strokeWidth: 1,
      )
    ]);
  }

  final Set<Marker> _markers = Set();
  final double _zoom = 15;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(lat, long));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  String address;
  // Geocoder addressName = Geocoder();
  LatLng coords = LatLng(lat, long);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pop(context, [coords.latitude, coords.longitude, address]);
            },
            icon: Icon(Icons.check),
          )
        ],
        backgroundColor: ColorsV.defaultColor,
        title: Text('الموقع الجغرافي'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (latlang) async {
              coords = latlang;
              print(latlang.latitude);
              _markers.clear();
              _markers.add(Marker(
                infoWindow: InfoWindow(title: address),
                markerId: MarkerId('5'),
                position: LatLng(latlang.latitude, latlang.longitude),
              ));
              GoogleMapController ctrler = await _controller.future;
              ctrler.animateCamera(CameraUpdate.newLatLng(latlang));
              setCircles(latlang);
              await Geocoder.local
                  .findAddressesFromCoordinates(
                      Coordinates(latlang.latitude, latlang.longitude))
                  .then((add) {
                address = add.first.addressLine.toString();
              });
              setState(() {});
            },
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            circles: circles,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Image.asset(
                      "assets/layer.png",
                      fit: BoxFit.fill,
                    ),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print(
                          '-------------- Changing the Map Type------------------');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    //  double lat = 28.644800;
    // double long = 77.216721;

//    var image = await BitmapDescriptor.fromAssetImage(
//      ImageConfiguration(),
//      "assets/icons/20.png",
//    );
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          draggable: true,

          markerId: MarkerId('5'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
              title: '${widget.namelocation}', snippet: 'موقع العقار الحالي '),
          //  icon: myIcon,
        ),
      );
    });
  }
}

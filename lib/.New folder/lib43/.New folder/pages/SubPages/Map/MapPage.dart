import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vacatiion/utility/colors.dart';

class MapTypes extends StatefulWidget
{

  double lat;
  double long;
  String namelocation="السعوديه";

  MapTypes({this.lat,this.long,this.namelocation});

  @override
  _MapTypesState createState() => _MapTypesState();
}

class _MapTypesState extends State<MapTypes> {


 static double lat=26.8206;
 static double long=30.8025;

 Set<Circle> circles ;
 BitmapDescriptor myIcon;





 @override
  void initState()
  {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(30, 30)), 'assets/chalet.png',)
        .then((onValue) {
      myIcon = onValue;
    });

    setState(()
    {
      lat=widget.lat;
      long=widget.long;
    });
    _goToCurrentLocation();



   circles = Set.from([Circle(
      circleId: CircleId("20"),
      center: LatLng(lat, long),
      radius: 300,
     fillColor: ColorsV.defaultColor.withOpacity(0.5),
     strokeColor: ColorsV.defaultColor,
     strokeWidth: 1,
    )]);


    super.initState();
  }


  final Set<Marker> _markers = Set();
  final double _zoom = 15;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(lat, long));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller)
  {
    _controller.complete(controller);
  }

  void _changeMapType()
  {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsV.defaultColor,
        title: Text('الموقع الجغرافي'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            circles:circles ,

          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Image.asset("assets/layer.png",fit: BoxFit.fill,),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: ()
                    {
                      _changeMapType();
                      print('-------------- Changing the Map Type------------------');
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
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(()
    {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('5'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: '${widget.namelocation}',  snippet: 'موقع العقار الحالي ')
              ,
           icon: myIcon,

        ),

      );
    });
  }

}







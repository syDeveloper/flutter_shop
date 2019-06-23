import 'package:flutter/material.dart';
import 'package:amap_base/amap_base.dart';

class MapFlutterPage extends StatefulWidget {
  @override
  _MapFlutterPageState createState() {
    return _MapFlutterPageState();
  }
}

class _MapFlutterPageState extends State<MapFlutterPage> {
  AMapController _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("高德地图"),),
      body: AMapView(
        onAMapViewCreated: (controller){
          _controller=controller;

        },

        amapOptions: AMapOptions(
          compassEnabled: false,
          zoomControlsEnabled: true,
          logoPosition: LOGO_POSITION_BOTTOM_RIGHT,
          camera: CameraPosition(
            target: LatLng(41.323212, 112.803231),
            zoom: 4,
          ),
        ),
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_contact/widgets/utils.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationData? myLocation;
  Marker? markers;
  getCurrentLocation() async {
    myLocation = await LocationFunctions.getCurrentLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(myLocation?.latitude ?? 27.6866,
                myLocation?.longitude ?? 83.4323),
            zoom: 14.0)));
    setState(() {
      markers = Marker(
          markerId: MarkerId("002"),
          position: LatLng(myLocation?.latitude ?? 27.6866,
              myLocation?.longitude ?? 83.4323));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(27.6866, 83.4323), zoom: 18.0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapType: MapType.normal,
        markers: {
          markers != null
              ? markers!
              : Marker(
                  markerId: MarkerId("002"),
                  position: LatLng(myLocation?.latitude ?? 27.6866,
                      myLocation?.longitude ?? 83.4323))
        },
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SampleMap extends StatefulWidget {
  const SampleMap({super.key});

  @override
  State<SampleMap> createState() => _SampleMapState();
}

class _SampleMapState extends State<SampleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: LatLng(52.6, 65.3), zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    );
  }
}

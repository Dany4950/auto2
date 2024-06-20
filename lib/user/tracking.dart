import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class u_tracking extends StatefulWidget {
  const u_tracking({super.key});

  @override
  State<u_tracking> createState() => u_trackingState();
}

class u_trackingState extends State<u_tracking> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 500,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(zoom: 13, target: LatLng(10, 30)),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Center(
              child: Positioned(
                  top: 16, left: 0, right: 0, child: Text("Location ON"))),
        ],
      ),
    );
  }
}

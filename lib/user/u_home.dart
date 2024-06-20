// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:one/user/id_list.dart';
// import 'package:one/user/tracking.dart';

// class u_home extends StatefulWidget {
//   const u_home({super.key});

//   @override
//   State<u_home> createState() => _u_homeState();
// }

// class _u_homeState extends State<u_home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.to(const IdList());
//               },
//               icon: Icon(Icons.straighten_sharp))
//         ],
//         title: Text("Home"),
//       ),
//       body: u_tracking(),
//     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserHomePage extends StatefulWidget {
//   @override
//   _UserHomePageState createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   GoogleMapController? _mapController;
//   Location _location = Location();
//   List<LatLng> _polylineCoordinates = [];
//   bool _isTracking = false;
//   late CollectionReference _locationCollection;

//   @override
//   void initState() {
//     super.initState();
//     _locationCollection = FirebaseFirestore.instance.collection('locations');
//   }

//   void _startTracking() {
//     setState(() {
//       _isTracking = true;
//       _polylineCoordinates.clear();
//     });
//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (_isTracking) {
//         setState(() {
//           _polylineCoordinates.add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
//         });
//         _locationCollection.add({
//           'latitude': currentLocation.latitude,
//           'longitude': currentLocation.longitude,
//           'timestamp': FieldValue.serverTimestamp()
//         });
//       }
//     });
//   }

//   void _stopTracking() {
//     setState(() {
//       _isTracking = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Home Page'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 15),
//               onMapCreated: (controller) => _mapController = controller,
//               polylines: {
//                 Polyline(
//                   polylineId: PolylineId('userPath'),
//                   points: _polylineCoordinates,
//                   color: Colors.blue,
//                   width: 5,
//                 )
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _isTracking ? null : _startTracking,
//                 child: Text('Start'),
//               ),
//               SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: _isTracking ? _stopTracking : null,
//                 child: Text('Stop'),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class LocationTrackingPage extends StatefulWidget {
  @override
  _LocationTrackingPageState createState() => _LocationTrackingPageState();
}

class _LocationTrackingPageState extends State<LocationTrackingPage> {
  late GoogleMapController _mapController;
  Location _location = Location();
  List<LatLng> _route = [];
  bool _isTracking = false;
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _checkLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_isTracking) {
        setState(() {
          LatLng latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _route.add(latLng);
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: _route,
            width: 5,
            color: Colors.blue,
          ));

          // Move the camera to the user's location
          _mapController.animateCamera(
            CameraUpdate.newLatLng(latLng),
          );
        });

        // Save the location to Firebase
        FirebaseFirestore.instance.collection('user_locations').add({
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 14.0,
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            polylines: _polylines,
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              child: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
              onPressed: () {
                if (_isTracking) {
                  _stopTracking();
                } else {
                  _startTracking();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
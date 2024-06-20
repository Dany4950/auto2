// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminViewPage extends StatefulWidget {
//   @override
//   _AdminViewPageState createState() => _AdminViewPageState();
// }

// class _AdminViewPageState extends State<AdminViewPage> {
//   late GoogleMapController _mapController;
//   final Set<Polyline> _polylines = {};
//   List<LatLng> _route = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadRouteFromFirestore();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   void _loadRouteFromFirestore() async {
//     FirebaseFirestore.instance
//         .collection('user_locations')
//         .orderBy('timestamp')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         LatLng point = LatLng(doc['latitude'], doc['longitude']);
//         setState(() {
//           _route.add(point);
//           _polylines.add(Polyline(
//             polylineId: PolylineId('route'),
//             points: _route,
//             width: 5,
//             color: Colors.blue,
//           ));
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin View'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _route.isNotEmpty ? _route.first : LatLng(0, 0),
//           zoom: 14.0,
//         ),
//         onMapCreated: _onMapCreated,
//         polylines: _polylines,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminViewPage extends StatefulWidget {
  @override
  _AdminViewPageState createState() => _AdminViewPageState();
}

class _AdminViewPageState extends State<AdminViewPage> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};
  List<LatLng> _route = [];

  @override
  void initState() {
    super.initState();
    _loadRouteFromFirestore();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _loadRouteFromFirestore() async {
    FirebaseFirestore.instance
        .collection('user_locations')
        .orderBy('timestamp')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print("Data found");
        querySnapshot.docs.forEach((doc) {
          LatLng point = LatLng(doc['latitude'], doc['longitude']);
          print("Point: $point");
          setState(() {
            _route.add(point);
          });
        });

        // Create the polyline
        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: _route,
            width: 5,
            color: Colors.blue,
          ));
        });

        // Move the camera to the start of the route
        if (_route.isNotEmpty) {
          _mapController.animateCamera(
            CameraUpdate.newLatLngBounds(_boundsFromLatLngList(_route), 50),
          );
        }
      } else {
        print("No data found");
      }
    }).catchError((error) {
      print("Error fetching data: $error");
    });
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0 = list[0].latitude, x1 = list[0].latitude;
    double y0 = list[0].longitude, y1 = list[0].longitude;
    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(
      northeast: LatLng(x1, y1),
      southwest: LatLng(x0, y0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin View'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _route.isNotEmpty ? _route.first : LatLng(0, 0),
          zoom: 14.0,
        ),
        onMapCreated: _onMapCreated,
        polylines: _polylines,
      ),
    );
  }
}

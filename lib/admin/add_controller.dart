import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddController_a extends GetxController {
  TextEditingController Idcontroller = TextEditingController();
  TextEditingController PhoneNocontroller = TextEditingController();

  GoogleMapController? mapController;
  LatLng currentlocation = LatLng(10, 10);
  LatLng selectedlocation = LatLng(10, 10);
}

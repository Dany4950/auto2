import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one/admin/a_home.dart';
import 'package:one/user/u_home.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FloatingActionButton(
                child: Text("admin"),
                onPressed: () {
                  Get.to(AdminViewPage());
                }),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
              child: Text("User"),
              onPressed: () {
                Get.to(LocationTrackingPage());
              })
        ],
      ),
    );
  }
}

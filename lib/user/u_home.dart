import 'package:flutter/material.dart';
import 'package:one/user/tracking.dart';

class u_home extends StatefulWidget {
  const u_home({super.key});

  @override
  State<u_home> createState() => _u_homeState();
}

class _u_homeState extends State<u_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: u_tracking(),
    );
  }
}

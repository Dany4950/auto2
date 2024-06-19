import 'package:flutter/material.dart';

class a_home extends StatefulWidget {
  const a_home({super.key});

  @override
  State<a_home> createState() => _a_homeState();
}

class _a_homeState extends State<a_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Home"),
      ),
    );
  }
}

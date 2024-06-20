import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

import 'package:one/firebase_options.dart';
import 'package:one/firstpage.dart';
import 'package:one/user/u_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Firstpage(),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       TextButton(
        //           style: TextButton.styleFrom(
        //             foregroundColor: Colors.white,
        //             backgroundColor: Colors.blue, // Background color
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: 16.0, vertical: 8.0), // Padding
        //             textStyle: TextStyle(fontSize: 20), // Text style
        //           ),
        //           onPressed: () {
        //             Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (context) => a_home()));
        //           },
        //           child: Text("Admin")),
        //       SizedBox(
        //         height: 30,
        //       ),
        //       TextButton(
        //           style: TextButton.styleFrom(
        //             foregroundColor: Colors.white,
        //             backgroundColor: Colors.blue, // Background color
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: 16.0, vertical: 8.0), // Padding
        //             textStyle: TextStyle(fontSize: 20), // Text style
        //           ),
        //           onPressed: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) => u_home()));
        //           },
        //           child: Text("User")),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

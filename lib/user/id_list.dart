import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IdList extends StatefulWidget {
  const IdList({super.key});

  @override
  State<IdList> createState() => _IdListState();
}

class _IdListState extends State<IdList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Id"),
              subtitle: Text("Name"),
              onTap: () {},
            );
          }),
    );
  }
}

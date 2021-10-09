import 'package:flutter/material.dart';
import 'package:noteiteasy/record_page.dart';
import 'package:firebase_core/firebase_core.dart'; //importing the firebase core plugin

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note It Easy',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const RecordPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noteiteasy/record_page.dart';

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

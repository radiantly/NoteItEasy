import 'dart:html';

import 'package:flutter/material.dart';
import 'package:noteiteasy/record_page.dart';
import 'package:firebase_core/firebase_core.dart'; //importing the firebase core plugin

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  //fireflutter
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAwesomeApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }

  MaterialApp MyAwesomeApp() {
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

MaterialApp SomethingWentWrong() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Note It Easy',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const RecordPage(),
  );
}

MaterialApp Loading() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Note It Easy',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const RecordPage(),
  );
}

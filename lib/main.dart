import 'package:flutter/material.dart';
import 'package:noteiteasy/record_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteiteasy/splash_page.dart'; //importing the firebase core plugin


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note It Easy',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            // Once initialization completes, show record page
            if (snapshot.connectionState == ConnectionState.done) {
              return const RecordPage();
            }

            return const SplashPage();
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noteiteasy/splash_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteiteasy/globals.dart' as globals;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
        child: Column(
        children: [
        GradientText("Note it Easy",
        style: GoogleFonts.loveYaLikeASister(
        textStyle: TextStyle(fontSize: 42)),
    gradient: LinearGradient(
    // TODO: Fix Gradient rotation here to be diagonal
    colors: [globals.gradientPurple, globals.gradientPink])),
    ],
    ),
      ),
    )
    );
  }
}

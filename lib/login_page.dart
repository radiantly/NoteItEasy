import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:noteiteasy/splash_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Container(
                alignment: Alignment.center,
                child: GradientText("Note it Easy",
                    style: GoogleFonts.loveYaLikeASister(
                        textStyle: const TextStyle(fontSize: 42)),
                    gradient: const LinearGradient(
                        // TODO: Fix Gradient rotation here to be diagonal
                        colors: [
                          globals.gradientPurple,
                          globals.gradientPink
                        ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 16.0, right: 16.0, bottom: 40.0),
              child: Text('The perfect solution for your daily memos!',
                  style: GoogleFonts.loveYaLikeASister(
                    textStyle: const TextStyle(
                        fontSize: 15.0, color: globals.gradientPink),
                  )),
            ),
            Image.asset(
              'assets/loginImage.png',
              width: 500,
              height: 300,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 50.0),
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(style: BorderStyle.none)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 13)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                      backgroundColor:
                          MaterialStateProperty.all(globals.gradientPink),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: SizedBox(
                    width: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.google),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Login with Google'),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

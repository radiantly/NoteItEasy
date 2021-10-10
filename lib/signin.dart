import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:noteiteasy/splash_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: GradientText("Note it Easy",
                        style: GoogleFonts.loveYaLikeASister(
                            textStyle: TextStyle(fontSize: 42)),
                        gradient: LinearGradient(
                            // TODO: Fix Gradient rotation here to be diagonal
                            colors: [
                              globals.gradientPurple,
                              globals.gradientPink
                            ])),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0,left: 16.0,right: 16.0),
                  child: Text('The perfect solution for your daily memos!',
                  style: GoogleFonts.loveYaLikeASister(
                      textStyle: TextStyle(fontSize: 15.0,color: globals.gradientPink),
                  )
                ),
                ),
                // TODO: Fix this image location error (thanks, Arun)
                Image.asset('/assets/pe01718_.gif',width: 300,height: 300,),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 80.0),
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
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: Text('Login with Google'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

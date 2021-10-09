import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:noteiteasy/record_button.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [globals.gradientPurple, globals.gradientPink]),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text("Note it easy!",
                      style: GoogleFonts.loveYaLikeASister(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 40))),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RecordButton(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

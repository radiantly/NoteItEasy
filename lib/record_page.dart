import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteiteasy/globals.dart' as globals;

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Text("Note it easy!",
                    style: GoogleFonts.loveYaLikeASister(
                        textStyle:
                            const TextStyle(color: globals.red, fontSize: 40))),
              ],
            ),
          )
        ],
      )),
    );
  }
}

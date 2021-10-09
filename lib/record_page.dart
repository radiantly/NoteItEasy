import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:noteiteasy/memo_list.dart';
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
                    // TODO: Fix Gradient rotation here to be diagonal
                    colors: [globals.gradientPurple, globals.gradientPink]),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text("Note it easy!",
                        style: GoogleFonts.loveYaLikeASister(
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 40))),
                  ),
                  const Text("Your memos!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Expanded(child: MemoList())
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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

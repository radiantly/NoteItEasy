import 'package:flutter/material.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';

class MemoList extends StatelessWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Text(
                        '“Pick up Zach from school also this is some lorem ipsum text to make it larger”',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 24)),
                  ),
                  SvgPicture.asset(
                      index % 2 == 0 ? "assets/Play.svg" : "assets/Pause.svg")
                ],
              ),
              decoration: BoxDecoration(
                  color: globals.listTransparentBg,
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteiteasy/sound_player.dart';

class MemoList extends StatefulWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  var _isPlaying = -1;
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memos = [
      '"Pick up Zach from school in the afternoon"',
      '"Finish washing dishes in the sink"',
      '"Buy a birthday gift for Andrea"'
    ];
    return ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(memos[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 24)),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset((_isPlaying == index)
                            ? "assets/Pause.svg"
                            : "assets/Play.svg"),
                        onTap: () async {
                          if (_isPlaying == index) {
                            setState(() {
                              _isPlaying = -1;
                            });
                            await player.startPlaying();
                          } else {
                            if (_isPlaying != -1) {
                              await player.stopPlaying();
                            }
                            setState(() {
                              _isPlaying = index;
                            });
                            await player.startPlaying();
                          }
                        },
                      )
                    ],
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       GestureDetector(child: FaIcon(FontAwesomeIcons.edit,color: Colors.white,),onTap: (){},),
                  //       SizedBox(width: 10,),
                  //       GestureDetector(child: FaIcon(FontAwesomeIcons.trash,color: Colors.white,),onTap: (){},),
                  //     ],
                  //   ),
                  // )
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

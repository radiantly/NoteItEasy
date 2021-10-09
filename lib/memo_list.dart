import 'package:flutter/material.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:noteiteasy/sound_player.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';


class MemoList extends StatefulWidget {
  MemoList({Key? key}) : super(key: key);



  @override
  _MemoListState createState() => _MemoListState();
}



class _MemoListState extends State<MemoList> {

  var _isPlaying = -1;
  final player = SoundPlayer();

  @override
  void initState(){
    super.initState();
    player.init();
  }

  @override
  void dispose(){
    player.dispose();

    super.dispose();
  }

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
                  GestureDetector(
                    child: SvgPicture.asset(
                        (_isPlaying==index) ? "assets/Pause.svg" : "assets/Play.svg"),
                    onTap: () async{

                      if(_isPlaying==index){
                        setState(() {
                          _isPlaying=-1;
                        });
                        await player.startPlaying();
                      }

                      else{
                        if(_isPlaying!=-1){
                          await player.stopPlaying();
                        }
                        setState(() {
                          _isPlaying=index;
                        });
                        await player.startPlaying();
                      }
                    },
                  )
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

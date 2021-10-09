import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

final pathToReadAudio = 'audio_date.aac';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  Future startPlaying() async{
    await _audioPlayer!.startPlayer(
      fromURI: pathToReadAudio,
      whenFinished:(){},
    );
  }

  Future stopPlaying() async{
    await _audioPlayer!.stopPlayer();
  }


  void init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openAudioSession();
  }

  void dispose() async{
    _audioPlayer!.closeAudioSession();
  }


}
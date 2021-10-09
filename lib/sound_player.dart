import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:io';

final pathToReadAudio = 'audio_date.aac';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  Future<void> startPlaying() async {
    await _audioPlayer!.startPlayer(
      fromURI: pathToReadAudio,
      whenFinished: () {},
    );
  }

  Future<void> startPlayingFile(String fileId, VoidCallback callback) async {
    final audioFilePath = "${(await globals.storageDir).path}/$fileId.aac";

    if (!await File(audioFilePath).exists()) {
      // Download file from Cloud Storage
    } else {
      await _audioPlayer!.startPlayer(
        fromURI: audioFilePath,
        whenFinished: callback,
      );
    }
  }

  Future<void> stopPlaying() async {
    await _audioPlayer!.stopPlayer();
  }

  void init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openAudioSession();
  }

  void dispose() async {
    _audioPlayer!.closeAudioSession();
  }
}

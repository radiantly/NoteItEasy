import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:io';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  Future<void> startPlayingFile(String fileId, VoidCallback callback) async {
    final audioFilePath = "${(await globals.storageDir).path}/$fileId.aac";

    if (!await File(audioFilePath).exists()) {
      // Download file from Cloud Storage
      callback();
    } else {
      await _audioPlayer!.startPlayer(
        fromURI: audioFilePath,
        whenFinished: callback,
      );
    }
  }

  Future<void> stopPlaying() async {
    await _audioPlayer?.stopPlayer();
  }

  Future<void> init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer?.openAudioSession();
  }

  void dispose() async {
    _audioPlayer?.closeAudioSession();
  }
}

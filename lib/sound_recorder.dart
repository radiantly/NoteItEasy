import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:uuid/uuid.dart';

class SoundRecorder {
  final uuid = const Uuid();

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder?.isRecording ?? false;

  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future<void> _record() async {
    if (!_isRecorderInitialised) return;
    final recordingId = uuid.v4();
    final pathToSaveAudioFile =
        "${(await globals.storageDir).path}/$recordingId.aac";

    await _audioRecorder!.startRecorder(toFile: pathToSaveAudioFile);
  }

  Future<void> _stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
  }

  Future<void> toggleRecording() async =>
      await (_audioRecorder!.isStopped ? _record() : _stop());
}

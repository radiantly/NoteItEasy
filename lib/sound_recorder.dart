import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:noteiteasy/upload_recording.dart';
import 'package:uuid/uuid.dart';

class SoundRecorder {
  final uuid = const Uuid();

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;
  String currentRecordingId = "";

  bool get isRecording => _audioRecorder?.isRecording ?? false;

  void generateNewRecordingId() => (currentRecordingId = uuid.v4());

  Future<String> get currentRecordingPath async =>
      "${(await globals.storageDir).path}/$currentRecordingId.aac";

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
    generateNewRecordingId();

    await _audioRecorder!.startRecorder(toFile: await currentRecordingPath);
  }

  Future<void> _stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
    await uploadFile(currentRecordingId, await currentRecordingPath);
  }

  Future<void> toggleRecording() async =>
      await (_audioRecorder!.isStopped ? _record() : _stop());
}

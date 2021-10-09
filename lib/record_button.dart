import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteiteasy/sound_recorder.dart';

class RecordButton extends StatefulWidget {
  RecordButton({Key? key}) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  final recorder = SoundRecorder();

  @override
  void initState() {
    super.initState();

    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'RECORD';

    return OutlinedButton(
        onPressed: () async {
          final isRecording = await recorder.toggleRecording();
          setState(() {});
        },
        child: const Text("Record"));
  }
}

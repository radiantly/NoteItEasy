import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteiteasy/sound_recorder.dart';
import 'package:noteiteasy/globals.dart' as globals;

class RecordButton extends StatefulWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  final recorder = SoundRecorder();
  bool recorderProcessing = true;

  @override
  void initState() {
    super.initState();

    recorder.init().then((_) => setState(() {
          recorderProcessing = false;
        }));
  }

  @override
  void dispose() {
    recorder.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(style: BorderStyle.none)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(globals.gradientPink)),
        onPressed: recorderProcessing
            ? null
            : () {
                setState(() {
                  recorderProcessing = true;
                });
                recorder.toggleRecording().then((_) => setState(() {
                      recorderProcessing = false;
                    }));
              },
        child: Text(recorderProcessing
            ? 'Processing'
            : recorder.isRecording
                ? 'Stop'
                : 'Record'));
  }
}

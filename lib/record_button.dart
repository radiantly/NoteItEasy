import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RecordButton extends StatefulWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {
    }, child: const Text("Record"));
  }
}

import 'package:flutter/material.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteiteasy/sound_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MemoList extends StatefulWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  final _memosStream = FirebaseFirestore.instance
      .collection('transcripts')
      .where("author", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  String? _currentlyPlaying;
  final _player = SoundPlayer();
  bool _processingPlayer = true;

  @override
  void initState() {
    super.initState();
    _player.init().then((_) => setState(() {
          _processingPlayer = false;
        }));
  }

  @override
  void dispose() {
    _player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _memosStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text("Something went wrong.");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(data["transcript"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24)),
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                              (_currentlyPlaying == data["audioID"])
                                  ? "assets/Pause.svg"
                                  : "assets/Play.svg"),
                          onTap: _processingPlayer
                              ? null
                              : () {
                                  setState(() {
                                    _processingPlayer = true;
                                  });
                                  (() async {
                                    // If something is already playing
                                    if (_currentlyPlaying != null) {
                                      await _player.stopPlaying();
                                    }

                                    // If currently playing item is this
                                    if (_currentlyPlaying == data["audioID"]) {
                                      return setState(() {
                                        _currentlyPlaying = null;
                                      });
                                    }
                                    // Else
                                    setState(() {
                                      _currentlyPlaying = data["audioID"];
                                    });
                                    await _player
                                        .startPlayingFile(data["audioID"], () {
                                      setState(() {
                                        _currentlyPlaying = null;
                                      });
                                    });
                                  })()
                                      .then((_) => setState(() {
                                            _processingPlayer = false;
                                          }));
                                },
                        )
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: globals.listTransparentBg,
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

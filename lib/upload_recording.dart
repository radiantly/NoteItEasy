import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> uploadFile(String fileId, String filePath) async {
  File file = File(filePath);

  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseStorage.instance
        .ref("uploads/$fileId.aac")
        .putFile(file, SettableMetadata(customMetadata: {"uid": uid!}));
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'

    // TODO: Do something with this exception
  }
}

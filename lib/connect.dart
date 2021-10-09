import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';

void FireBaseConnect() {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref();
}

Future<void> uploadAudioFile(String FilePath) async {
  File file = File(FilePath);

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('/AudioFiles')
        .putFile(file);
  } on FirebaseException catch (e) {
    return;
  }
}

Future<void> DownloadAudioFile(String FileName, String FilePath) async {
  //if specific file is required we could pass in FileName as a parameter else we could Replace it with FilePath
  File downloadToFile = File(FilePath); // the File in the mobile storage
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(FileName)
        .writeToFile(downloadToFile);
  } on FirebaseException catch (e) {
    return;
  }
}

Future<List> ListAllTheAudioFiles() async {
  List AudioFiles = [];

  firebase_storage.ListResult ListResult = await firebase_storage
      .FirebaseStorage.instance
      .ref('/AudioFiles')
      .listAll();

  ListResult.items.forEach((firebase_storage.Reference ref) {
    AudioFiles.add(ref);
  });

  return AudioFiles;
}

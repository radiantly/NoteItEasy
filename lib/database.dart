import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore= FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('transcripts');

class Database{
  static String? author;
  static String? transcript;
  static String? audioID;
  static String? assemblyID;

  static Stream<QuerySnapshot> readItems(){
    CollectionReference transcriptCollection = _mainCollection.doc(author).collection('transcripts');

    return transcriptCollection.snapshots();
  }
  static Future<void> updateItem({
  required String transcript,
  required String audioID,}) async{
    DocumentReference documentReferencer = _mainCollection.doc(author).collection('transcripts').doc(audioID);

    Map<String,String> data = <String,String>{
      "transcript": transcript,
      "audioID" : audioID,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Updated transcript"))
        .catchError((error) =>print(error));
  }

  static Future<void> deleteItem({
  required String audioID,}) async {
    DocumentReference documentReferencer = _mainCollection.doc(author).collection('transcripts').doc(audioID);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Transcript has been deleted from the database'))
        .catchError((error)=>print(error));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';

class FirestoreService implements DatabaseService {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addDataToDatabase({required String collectionName, required Map<String, dynamic> data,String? documentId}) async {

    if(documentId!=null){
      await firestore.collection(collectionName).doc(documentId).set(data);
    }
    else{
      await firestore.collection(collectionName).add(data);
    }
  }

  @override
  Future<Map<String,dynamic>> getDataFromDatabase({required String collectionName,required String documentId}) async {

    final doc = await firestore.collection(collectionName).doc(documentId).get();
    final data = doc.data();
    return data as Map<String,dynamic>;



  }

  @override
  Future<bool> checkDataExists({required String collectionName,required String documentId}) async {

    final doc = await firestore.collection(collectionName).doc(documentId).get();
    return doc.exists;



  }












}
abstract class DatabaseService {

 Future<void> addDataToDatabase({required String collectionName,required Map<String,dynamic> data,String? documentId});

 Future<Map<String,dynamic>> getDataFromDatabase({required String collectionName,required String documentId});

 Future<bool> checkDataExists({required String collectionName,required String documentId});

}
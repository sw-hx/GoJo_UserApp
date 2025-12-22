import 'dart:io';

abstract class StorageService {

  Future<String> uploadImage({required File file, required String bucket, required String folder});
}
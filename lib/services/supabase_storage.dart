import 'dart:io';
import 'package:path/path.dart' as b;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/constants.dart';
import 'storage_service.dart';

class Buckets {
  static const userProfilePhotos = 'user_profile_photos';
  static const ticketPhotos = 'ticket_photos';
}

class SupabaseStorage implements StorageService {
  static late SupabaseClient client;

  static Future<void> initSupabaseStorage() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
    client = Supabase.instance.client;
  }

  static Future<void> ensureBucket(String bucket) async {
    var buckets = await client.storage.listBuckets();
    if (!buckets.any((b) => b.name == bucket)) {
      await client.storage.createBucket(bucket);
    }
  }

  @override
  Future<String> uploadImage({required File file, required String bucket, required String folder}) async {
    try {
      await ensureBucket(bucket);

      final fileName = b.basename(file.path)
          .replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');

      final fileBytes = await file.readAsBytes();
      final path = '$folder/$fileName';

      await client.storage
          .from(bucket)
          .uploadBinary(path, fileBytes, fileOptions: const FileOptions(upsert: true));

      return client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      throw Exception("Upload failed: $e");
    }
  }
}

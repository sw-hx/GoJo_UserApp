import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'git_it_service.dart';

final storage =getIt.get<FlutterSecureStorage>();

Future<void> saveUserToken({required Map<String, dynamic> response}) async {
  await storage.write(key: 'jwtToken', value: response['jwtToken']);
}

Future<String?> getSavedToken() async {
  return await storage.read(key: 'jwtToken');
}


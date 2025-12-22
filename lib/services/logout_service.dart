import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'git_it_service.dart';

class LogoutService {
  static final _storage = getIt.get<FlutterSecureStorage>();

  static Future<void> signOut() async {
    await _storage.delete(key: 'jwtToken');
  }

}

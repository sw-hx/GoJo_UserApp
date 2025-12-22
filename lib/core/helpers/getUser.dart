import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';
import '../../services/shared_preferences.dart';
import '../constants.dart';

Future<UserModel?> getUserData() async {
  final String? jsonData =
  SharedPreferencesService.getString(userDataKey);

  if (jsonData == null || jsonData.isEmpty) {
    return null;
  }

  try {
    final Map<String, dynamic> map =
    jsonDecode(jsonData) as Map<String, dynamic>;

    return UserModel.fromMap(map);
  } catch (e) {
    return null;
  }
}


Future<void> saveUserData(UserModel user) async {
  final prefs = await SharedPreferences.getInstance();
  final userMap = user.toMap();
  prefs.setString(userDataKey, jsonEncode(userMap));
}


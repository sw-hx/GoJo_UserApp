import 'dart:convert';
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

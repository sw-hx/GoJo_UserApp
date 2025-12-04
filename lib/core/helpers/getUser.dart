import 'dart:convert';
import '../../data/models/user_model.dart';
import '../../services/shared_preferences.dart';
import '../constants.dart';

UserModel getUserData() {
  var jsonData=SharedPreferencesService.getString(userDataKey);
  var user= UserModel.fromMap(jsonDecode(jsonData));
  return user;

}

import 'dart:convert';
import 'package:go_jo_user_application/domain/models/user_model.dart';
import '../constants.dart';
import '../services/shared_preferences.dart';

UserModel getUserData() {
  var jsonData=SharedPreferencesService.getString(userDataKey);
  var user= UserModel.fromMap(jsonDecode(jsonData));
  return user;

}

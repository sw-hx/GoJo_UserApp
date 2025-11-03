import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setString(key, value) async{
    await sharedPreferences.setString(key, value);
  }

  static String getString(key) {
    return sharedPreferences.getString(key) ?? '';
  }




}
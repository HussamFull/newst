import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
 static final PreferenceManager _instance = PreferenceManager._internal();

  factory PreferenceManager(){
    return _instance;
  }

  PreferenceManager._internal();

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }


// get
  String? getString(String key) {
    return _preferences.getString(key);
  }
    
  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  bool? getBoolean(String key) {
    return _preferences.getBool(key);
  }

// set 
  Future setString(String key, String value) async {
   return await _preferences.setString(key, value);
  }

  Future setBoolean(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  


  
}



// وصلنا عند الجزء 4 

import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
// import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class LocalStorage {
  static save(String key, value) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, value);
    HiFlutterBridge.getInstance().save(key, value);
  }

  static get(String key) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var str =  await HiFlutterBridge.getInstance().getVal(key) ;
    return str ?? "";
    // return prefs.get(key);
  }

  static remove(String key) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(key);
    HiFlutterBridge.getInstance().save(key, "");
  }
}

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiToken {
  //تخزين التوكن طريقه 1
  static const String _tokenkey = "TOKEN";
  static const String _id = "ID";
  // static late int id = 0;

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenkey, token);
    // id = prefs.getInt(_tokenkey) ?? 0;
    //print(token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    // final value = prefs.getString(_tokenkey) ;
    // id = value;
    return prefs.getString(_tokenkey) ;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //تخزين التوكن2
  static Future<void> savetoken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final keyes = 'token';
    final value = token;
    prefs.setString(keyes, value);
  }

  static Future<Object?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    //print(value);
    return value;
  }

  /////////////////////////////////
  ///تخزين الاي دي
  static Future<void> setId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_id, id);
    // id = prefs.getInt(_tokenkey) ?? 0;
    //print(token);
  }

  static Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_id) ?? 0;
    // id = value;
    return value;
  }

  // Future<void> _setid() async {

  //   int id = await ApiToken.getId();
  //   print(id);
  //   if (id == 0) {
  //     await ApiToken.setId(12);
  //     print(id);
  //   } else {
  //     print(id);
  //   }
  //   // await ApiToken.clearToken();
  // }

  // Future<void> _fechtoken() async {
  //   String? name = await ApiToken.getToken();
  //   if (name == null) {
  //     await ApiToken.setToken("hhhhhhhhhhhhhhhh");
  //     print(name);
  //   } else {
  //     print(name);
  //   }
  // }

  
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestMasseging {
  // static late String? _token;
  // static late Stream<String>? _tokenstrem;
  static Future<String?> getTokenFB() async {
    try {
      String? tokenFB = await FirebaseMessaging.instance.getToken();
      print("===========================");
      print(tokenFB);
      print("=================================");
      return tokenFB;
    } catch (er) {}
  }

  static const String _tokenkey = "TOKEN";

  static Future<void> setToken() async {
    String? token = await getTokenFB();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenkey, token ?? "000");
    //print(token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenkey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
///topics/SubRafahia
//dh5mnyqBSNaFfvughelSoX:APA91bEMt8UMHdpV7uafi4whXV5FUaoVICGhG9KZGrVYx8uMlikNZpFUXG0BNDDjhkXrjyuhVsJ0rP8G1rNacT_eEvoN7rHpzaZ88GJFjMJz47epsQmt_u69cg_K_2H_1PHsLpsaOobz
// eBuwoT0dQCSLQAHAYW_xMg:APA91bEkbEx2OFh6MwR8KCWntM5zM3apsREKzHVyF4dXWrsgwAiSQ00sE2c_pD_CwlguZntb4gHzMYgB1gFNRpekOZ3NabRb-idArhCldktwah5z9nBCITUqaw1NMnnCek-wn6e22Spv
// eBuwoT0dQCSLQAHAYW_xMg:APA91bEkbEx2OFh6MwR8KCWntM5zM3apsREKzHVyF4dXWrsgwAiSQ00sE2c_pD_CwlguZntb4gHzMYgB1gFNRpekOZ3NabRb-idArhCldktwah5z9nBCITUqaw1NMnnCek-wn6e22Spv
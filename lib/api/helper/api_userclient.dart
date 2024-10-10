import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rafahia_web/api/helper/api_errors.dart';
import 'package:rafahia_web/api/helper/api_token.dart';

import '../../models/datausers/data_user_model.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';
import 'api_massegefirebase.dart';

class ApiUserClient {
  static BaseUrl _baseUrl = new BaseUrl();
  static GetClientLogin _getClientLogin = new GetClientLogin();
  static GetregisterClient _getregisterClient = new GetregisterClient();
  static GetCountries _getCountries = new GetCountries();
  static GetSexually _getSexually = new GetSexually();
  static GetMarital_State _getMarital_State = new GetMarital_State();
  static GetUsernameandemail _getUsernameandemail = new GetUsernameandemail();
  static ClientUpdate _clientUpdate = new ClientUpdate();
  static ClientChangePass _changePass = new ClientChangePass();
  static ClientGet _clientGet = new ClientGet();

  /////////////////////////////////////////////////
  static late List<Countries> countries = [];
  static late List<Sexually> sexually = [];
  static late List<MaritalState> maritalstste = [];
  static var userdata;
  static var usernameandemail;

  ////////////////////////////////////////////////////
  ///دالة تسجيل الدخول
  static Future<bool?> Loginuser(String email, String pass) async {
    String? token = await TestMasseging.getTokenFB();
    // Dio dio = new Dio();
    try {
      var response = await http.post(
          Uri.parse("${_baseUrl.baseurl.trim()}${_getClientLogin.url.trim()}"),
          headers: {"Content-type": "application/json"},
          body: json.encode({
            "email": email.toString(),
            "password": pass.toString(),
            "fBtoken": token.toString(),
          }));
      // var response = await http.post(
      //     Uri.parse("${_baseUrl.baseurl.trim()}${_getClientLogin.url.trim()}"),
      //     body: json.encode({
      //       "email": email,
      //       "password": pass,
      //       "fBtoken": token,
      //     }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.favorColor);
          return false;

          // print(data['message']);
        } else {
          int userid = data['id'];

          // FileOperations.writeFile(userid.toString());
          await ApiToken.setId(userid);
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.maingreencolor);
          return true;
          //       SqlHelper.createMassege(
          // "Rafahia", "لقد تم تسجيل الدخول");
        }
      } else {
        ApiError.massegerror(response.statusCode, response.body);
        return false;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  /////////////////////////////////////////////////////////////////
  ///دالة انشاء حساب
  static Future<bool?> registerUser(Map<String, dynamic> userData) async {
    Dio dio = new Dio();
    try {
      // var response = await http.post(
      //   Uri.parse("${_baseUrl.baseurl.trim()}${_getregisterClient.url.trim()}"),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(userData),
      // );

      var response = await http.post(
        Uri.parse("${_baseUrl.baseurl.trim()}${_getregisterClient.url.trim()}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.favorColor);
          return false;

          // print(data['message']);
        } else {
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.maingreencolor);
          return true;
          //       SqlHelper.createMassege(
          // "Rafahia", "لقد تم تسجيل الدخول");
        }
      } else {
        ApiError.massegerror(response.statusCode, response.body);
        return false;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  ///////////////////////////////////////////////////////
  ///دالة الاستعلام عن تفاصيل العميل
  static Future<dynamic> fetchUserDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_clientGet.url.trim()}$id");
      print(response.statusCode);
      if (response.statusCode == 200) {
        userdata = response.data;
        return userdata;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  ///////////////////////////////////////////////////////
  ///دالة الاستعلام عن اسم ةايميل العميل العميل
  static Future<dynamic> fetchUsernameDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getUsernameandemail.url.trim()}$id");
      print(response.statusCode);
      if (response.statusCode == 200) {
        usernameandemail = response.data;
        return usernameandemail;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  ///////////////////////////////////////////////////////
  ///دالة تعديل بيانات الحساب
  static Future<bool?> updateUser(
      Map<String, dynamic> userData, int? id) async {
    // Dio dio = new Dio();
    try {
      var response = await http.post(
        Uri.parse("${_baseUrl.baseurl.trim()}${_clientUpdate.url.trim()}${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      // var response = await http.post(
      //   Uri.parse("${_baseUrl.baseurl.trim()}${_clientUpdate.url.trim()}$id"),
      //   body: jsonEncode(userData),
      // );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.favorColor);
          return false;

          // print(data['message']);
        } else {
          ShowMasseg.ShowToastMassegError(
              "${data['message']}", LigthColor.maingreencolor);
          return true;
          //       SqlHelper.createMassege(
          // "Rafahia", "لقد تم تسجيل الدخول");
        }
      } else {
        ApiError.massegerror(response.statusCode, response.body);
        return false;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////
  ///دالة استعلام الدول
  static Future<List<Countries>?> fetchcountries() async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getCountries.url.trim()}");
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        countries = responsedata.map((e) => Countries.fromJson(e)).toList();
        return countries;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {}
  }

////////////////////////////////////////////////
  ///دالة استعلام الجنس
  static Future<List<Sexually>?> fetchsexually() async {
    final Dio dio = new Dio();

    try {
      var response =
          await dio.get("${_baseUrl.baseurl.trim()}${_getSexually.url.trim()}");
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        sexually = responsedata.map((e) => Sexually.fromJson(e)).toList();
        return sexually;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {}
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ///دالة استعلام الحالة الاجتماعية
  static Future<List<MaritalState>?> fetchmaritalstste() async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getMarital_State.url.trim()}");
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        maritalstste =
            responsedata.map((e) => MaritalState.fromJson(e)).toList();
        return maritalstste;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {}
  }

///////////////////////////////////////////////////////////////
  ///دالة تغيير كلمة المرور
  static Future<bool?> changepass(
      Map<String, dynamic> userData, int? id) async {
    // var checkid = await FileOperations.readFile();
    final Dio dio = new Dio();
    try {
       var response = await http.post(
        Uri.parse(
            "${_baseUrl.baseurl.trim()}${_changePass.url.trim()}${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      // var response = await http.post(
      //   Uri.parse("${_baseUrl.baseurl.trim()}${_changePass.url.trim()}${id}"),
      //   body: jsonEncode(userData),
      // );

      // print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          // print(data['message']);
          ShowMasseg.ShowToastMasseg(
              "${data['message']}", LigthColor.favorColor);
          return false;
        } else {
          ShowMasseg.ShowToastMasseg(
              "${data['message']}", LigthColor.maingreencolor);
          return true;
        }
      } else {
        ApiError.massegerror(response.statusCode, response.body);
        return false;
      }
    } on DioException catch (e) {
      ShowMasseg.ShowToastMasseg(
          "لايوجد اتصال بالانترنت", LigthColor.favorColor);
      // print(e);
    }
  }
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

  // String? name = await ApiToken.getToken();
  // if (name == null) {
  //   await ApiToken.setToken("hhhhhhhhhhhhhhhh");
  //   print(name);
  // } else {
  //   print(name);
  // }
  // }

  // getTokenFB() async {
  //   String? tokenFB = await FirebaseMessaging.instance.getToken();
  //   print("===========================");
  //   print(tokenFB);
  //   print("=================================");
  //   // return tokenFB;
  // }
  // Future<void> testtoken() async {
  //   await TestMasseging.setToken();
  // }
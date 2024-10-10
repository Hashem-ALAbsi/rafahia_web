import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rafahia_web/api/helper/api_errors.dart';

import '../../models/commintmodels/commint_model.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';

class ApiCommintAndRating {
  ////////////////////////////////////////////////////
  static BaseUrl _baseUrl = new BaseUrl();
  static GetRatingCompany _getRatingCompany = new GetRatingCompany();
  static GetCommentCompany _getCommentCompany = new GetCommentCompany();
  static CreateCommentAndRating _commentAndRating =
      new CreateCommentAndRating();
  static DeletedCommentCompany _deletedCommentCompany = DeletedCommentCompany();
  static UpdateCommentAndRating _updateCommentAndRating =
      UpdateCommentAndRating();

///////////////////////////////////////////////////
  static late String ratingvalue;
  static late List<Commintcompany> commintcompany;

/////////////////////////////////////////////////////////
  ///دالة ارجاع قيمة التقييم الخاص بالشركة
  static Future<String?> fetchRatingDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getRatingCompany.url.trim()}$id");

      if (response.statusCode == 200) {
        ratingvalue = response.data.toString();
        return ratingvalue;
      } else {
        ratingvalue = "10";
        return ratingvalue;
        //return rating;
      }
    } on DioException catch (e) {
      print(e);
      // return ratingvalue;
      //return "erorr";
    }
  }

  ///////////////////////////////////////////////
  ///دالة ارجاع التعليقات الخاصة بالشركة
  static Future<List<Commintcompany>?> fetchCommintDetails(int? id) async {
    final Dio dio = new Dio();
    //int i = 18;

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getCommentCompany.url.trim()}$id");
      print(response.statusCode);
      //print(response.data);

      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        commintcompany =
            responsedata.map((e) => Commintcompany.fromJson(e)).toList();
        return commintcompany;
        // if (commintcompany.isNotEmpty) {
        // } else {
        //   return null;
        // }
      } else {
        ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

/////////////////////////////////////////////////////////
  ///دالة انشاء تعليق
  static Future<bool?> commintandRitang(int? idclient, int? idcompany,
      String commintext, String ratintext) async {
    try {
      var response = await http.post(
          Uri.parse(
              "${_baseUrl.baseurl.trim()}${_commentAndRating.url.trim()}${idclient}/${idcompany}"),
          headers: {"Content-type": "application/json"},
          body: json.encode({"commentname": commintext, "value": ratintext}));

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
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
    } catch (e) {}
  }

  //////////////////////////////////////////////////////////////////////
  ///دالة التعديل على تعليق
  static Future<bool?> updatecommint(int? idclient, int? idcommint,
      String commintext, String ratintext) async {
    try {
      var response = await http.post(
          Uri.parse(
              "${_baseUrl.baseurl.trim()}${_updateCommentAndRating.url.trim()}${idclient}/$idcommint"),
          headers: {"Content-type": "application/json"},
          body: json.encode({"commentname": commintext, "value": ratintext}));

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
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
    } catch (e) {}
  }

  ////////////////////////////////////////////////
  ///دالة حذف تعليق
  static Future<bool?> deletecommint(int? idclient, int? commintid) async {
    final Dio dio = new Dio();
    try {
      var response = await dio.delete(
          "${_baseUrl.baseurl.trim()}${_deletedCommentCompany.url.trim()}${idclient}/${commintid}");

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = response.data;
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMasseg(
              "${data['message'].toString()}", LigthColor.favorColor);
          return false;
        } else {
          ShowMasseg.ShowToastMasseg(
              "${data['message'].toString()}", LigthColor.maingreencolor);
          return true;
        }
      } else {
        ApiError.massegerror(response.statusCode, response.data);
        return false;
      }
    } catch (e) {}
  }
}

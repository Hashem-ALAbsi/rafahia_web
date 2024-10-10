import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/imagemodels/image_model.dart';
import '../../models/imagemodels/image_service_model.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';

class ApiImage {
  ////////////////////////////////////////////////////
  static BaseUrl _baseUrl = new BaseUrl();
  static GetAllCompanyImage _allCompanyImage = new GetAllCompanyImage();
  static GetAllserviceImage _getAllserviceImage = new GetAllserviceImage();

///////////////////////////////////////////////////////
  static late List<Image_company> imagecompany = [];
  static late List<Image_service> imageservice = [];

///////////////////////////////////////////////////////
  ///دالة الاستعلام عن صور الفندق
  static Future<List<Image_company>?> fetchImageCompanyDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_allCompanyImage.url.trim()}$id");
      print(response.statusCode);
      //print(response.data);

      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        imagecompany =
            responsedata.map((e) => Image_company.fromJson(e)).toList();
        return imagecompany;
        // if (imagecompany.isNotEmpty) {
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
  ///دالة الاستعلام عن صور الخدمات
  static Future<List<Image_service>?> fetchImageServiseDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getAllserviceImage.url.trim()}$id");
      print(response.statusCode);
      //print(response.data);

      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        imageservice =
            responsedata.map((e) => Image_service.fromJson(e)).toList();
        return imageservice;
        // if (imageservice.isNotEmpty) {
        //   } else {
        //     return null;
        //   }
      } else {
        ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
        return null;
      }
    } on DioException catch (e) {
      // print(e);
    }
  }
}

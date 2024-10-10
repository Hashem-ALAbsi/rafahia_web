import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/servicemodels/service_model.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';

class ApiService {
  ////////////////////////////////////////////////////
  static BaseUrl _baseUrl = new BaseUrl();
  static GetServiceCompanyByid _getServiceCompanyByid =
      new GetServiceCompanyByid();
  static GetServiceByid _getServiceByid = new GetServiceByid();

  //////////////////////////////////////////////////////
  static late List<ServiceCompany> servicecompany = [];
  // static late dynamic dataservice;
  static var dataservice;

  //////////////////////////////////////////////////////
  ///دالة الاستعلام عن تقاصيل الخدمة من خلال معرف الخدمة
  static Future<dynamic> fetchServiceDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getServiceByid.url.trim()}$id");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var dataservice2 = response.data;
        // print(dataservice);
        return dataservice2;
      } else {
        ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
        return null;
      }
    } on DioException catch (e) {
      // print(e);
    }
  }

  ////////////////////////////////////////////////////////
  ///دالة الاستعلام عن جميع الخدمات الخاصة بالشركة من حلال معرف الشركة
  static Future<List<ServiceCompany>?> fetchdataservices(int? id) async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getServiceCompanyByid.url.trim()}$id");
      //print(response.statusCode);
      //print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        servicecompany =
            responsedata.map((e) => ServiceCompany.fromJson(e)).toList();
        return servicecompany;
        // if (servicecompany.isNotEmpty) {
        //   // print(servicecompany);
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
}

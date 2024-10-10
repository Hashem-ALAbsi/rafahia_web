import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rafahia_web/api/helper/api_errors.dart';
import 'package:http/http.dart' as http;

import '../../models/chaletmodels/chalet_model.dart';
import '../../models/chaletmodels/chalet_suggest_model.dart';
import '../../models/companymodels/companies._model.dart';
import '../../models/companymodels/companies_map_model.dart';
import '../../models/companymodels/companies_model_hight.dart';
import '../../models/estrahamodels/estraha_model.dart';
import '../../models/estrahamodels/estraha_suggest_model.dart';
import '../../models/favoritecompanymodels/favoritecompany_model.dart';
import '../../models/hotelsmodels/hotel_model.dart';
import '../../models/hotelsmodels/hotel_suggest_model.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';

class ApiCompany {
  ////////////////////////////////////////////////////
  static BaseUrl _baseUrl = new BaseUrl();
  static GetCompanyHighestrating _getCompanyHighestrating =
      new GetCompanyHighestrating();
  static GetCompanylastHotel _getCompanylastHotel = new GetCompanylastHotel();
  static GetCompanylastChalet _getCompanylastChalet =
      new GetCompanylastChalet();
  static GetCompanylastEstraaha _getCompanylastEstraaha =
      new GetCompanylastEstraaha();
  static GetCompany _getCompany = new GetCompany();
  static GetHotel _getHotel = new GetHotel();
  static GetChalet _getChalet = new GetChalet();
  static GetEstraaha _getEstraaha = new GetEstraaha();
  static GetCompanyByid _getCompanyByid = new GetCompanyByid();
  static GetFavoriteCompanyById _favoriteCompanyById =
      new GetFavoriteCompanyById();
  static CreateOrDeleteFavoriteCompany _favoriteCompany =
      new CreateOrDeleteFavoriteCompany();
  static DeleteFavoriteCompany _deleteFavoriteCompany =
      new DeleteFavoriteCompany();
  static GetMyCompany _getMyCompany = new GetMyCompany();

////////////////////////////////////////////////////////
  static late List<Companyhight> comp_hight = [];
  static late List<Hotel_Suggest> sugg_hotel = [];
  static late List<Chalet_Suggest> sugg_chalet = [];
  static late List<Estraha_Suggest> sugg_estraha = [];
  static late List<Companys> company = [];
  static late List<Hotles_Company> hotles = [];
  static late List<Chalet_Company> chalte = [];
  static late List<Estraha_Company> estraha = [];
  static late List<FavoriteCompany> favoritecompany = [];
  static late List<CompanysMap> companymap = [];
  // static late dynamic companydata;
  static var companydata;

///////////////////////////////////////////////////////////
  ///دالة استعلام الشركات الاعلى تقييم
  static Future<List<Companyhight>?> fetchCompanyHighestrating() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getCompanyHighestrating.getcompanyhighestrating.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        comp_hight = responsedata.map((e) => Companyhight.fromJson(e)).toList();
        return comp_hight;
        // if (comp_hight.isNotEmpty) {
        // } else {
        //   return comp_hight;
        // }
      } else {
        // response.statusMessage
        //print(response.statusMessage);
        ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
        return null;
      }
    } on DioException catch (e) {
      // ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
      print(e);
    }
  }

  ////////////////////////////////////////////////////
  ///دالة الاستعلام عن الفنادق الخمس المضافة موحرا
  static Future<List<Hotel_Suggest>?> fetchCompanylastHotel() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getCompanylastHotel.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        sugg_hotel =
            responsedata.map((e) => Hotel_Suggest.fromJson(e)).toList();
        return sugg_hotel;
        // if (sugg_hotel.isNotEmpty) {
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

  //////////////////////////////////////////////////
  ///دالة الاستعلام عن الخمس الشاليهات المضافة موخرا
  static Future<List<Chalet_Suggest>?> fetchCompanylastChalet() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getCompanylastChalet.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        sugg_chalet =
            responsedata.map((e) => Chalet_Suggest.fromJson(e)).toList();
        return sugg_chalet;
        // if (sugg_chalet.isNotEmpty) {
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
  ///دالة الاستعلام عن الخمس الاستراحات المضافة موخرا
  static Future<List<Estraha_Suggest>?> fetchCompanylastEstraaha() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getCompanylastEstraaha.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        sugg_estraha =
            responsedata.map((e) => Estraha_Suggest.fromJson(e)).toList();
        return sugg_estraha;
        // if (sugg_estraha.isNotEmpty) {
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

  ///////////////////////////////////////////////////////////
  ///دالة الاستعلام عن جميع الشركات
  static Future<List<Companys>?> fetchAllCompany() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response =
          await dio.get("${_baseUrl.baseurl.trim()}${_getCompany.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        company = responsedata.map((e) => Companys.fromJson(e)).toList();
        return company;
        // if (company.isNotEmpty) {
        //   // ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
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

  ////////////////////////////////////////////////////////////
  ///دالة الاستعلام عن جميع الفنادق
  static Future<List<Hotles_Company>?> fetchgetHotel() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response =
          await dio.get("${_baseUrl.baseurl.trim()}${_getHotel.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        hotles = responsedata.map((e) => Hotles_Company.fromJson(e)).toList();
        return hotles;
        // if (hotles.isNotEmpty) {
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

  ////////////////////////////////////////////////////////////
  ///دالة الاستعلام عن جميع الشاليهات
  static Future<List<Chalet_Company>?> fetchgetChalet() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response =
          await dio.get("${_baseUrl.baseurl.trim()}${_getChalet.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        chalte = responsedata.map((e) => Chalet_Company.fromJson(e)).toList();
        return chalte;
        // if (chalte.isNotEmpty) {
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

  //////////////////////////////////////////////////////////////
  ///دالة الاستعلام عن جميع الاستراحات
  static Future<List<Estraha_Company>?> fetchgetEstraaha() async {
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response =
          await dio.get("${_baseUrl.baseurl.trim()}${_getEstraaha.url.trim()}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        estraha = responsedata.map((e) => Estraha_Company.fromJson(e)).toList();
        return estraha;
        // if (estraha.isNotEmpty) {
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

  /////////////////////////////////////////////////////////////
  ///دالة الاستعلام على الشركة من خلال معرف الشركة
  static Future<dynamic> fetchHotelDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getCompanyByid.url.trim()}$id");
      if (response.statusCode == 200) {
        companydata = response.data;
        //print(response.statusMessage);
        //print(companydata.runtimeType);
        return companydata;
        // if (!didDispose) {
        //   setState(() {
        //     hotel = response.data;
        //     _longtude2 = hotel['longtude'];
        //     _latetude2 = hotel['latetud'];
        //     _namecompany = hotel['name'];
        //     _latetude = double.parse(_latetude2);
        //     _longtude = double.parse(_longtude2);
        //     _getk(_latetude, _longtude, _namecompany);
        //     serviceicon1 = response.data["rustorant"];
        //     serviceicon2 = response.data["cooffee"];
        //     serviceicon3 = response.data["swimmingbool"];

        //     iconcolor1 =
        //         serviceicon1 ? LigthColor.iconservice : LigthColor.graycolor;
        //     iconcolor2 =
        //         serviceicon2 ? LigthColor.iconservice : LigthColor.graycolor;
        //     iconcolor3 =
        //         serviceicon3 ? LigthColor.iconservice : LigthColor.graycolor;
        //   });
        // }
      } else {
        ShowMasseg.ShowToastMasseg("${response.statusMessage}", Colors.red);
        // print(response.statusMessage);
        ShowMasseg.ShowToastMasseg("لايوجد اتصال بالانترنت", Colors.red);
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////////
  ///دوال الخاصة بالمفضلات
  ///دالة الاستعلام عن الشركات المفضلة
  static Future<List<FavoriteCompany>?> fetchdatafavoriteCompany(
      int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_favoriteCompanyById.url.trim()}$id");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        favoritecompany =
            responsedata.map((e) => FavoriteCompany.fromJson(e)).toList();
        return favoritecompany;
      } else if (response.statusCode == 400) {
        ShowMasseg.ShowToastMasseg("قم بتسجيل دخولك اولاً", LigthColor.delete);
        return null;
      } else {
        ShowMasseg.ShowToastMasseg(
            "لايوجد اتصال بالانترنت", LigthColor.favorColor);
        return null;
      }
      //print(comp.);
    } on DioException catch (e) {
      ShowMasseg.ShowToastMasseg(
          "لايوجد اتصال بالانترنت", LigthColor.favorColor);
      // print(e);
    }
  }

  /////////////////////////////////////////////////////////////
  ///دالة الاضافة الى المفضلة
  static Future<bool?> createfouviret(int? idclient, int? idcompany) async {
    bool _isfavorite = true;
    final Dio dio = new Dio();
    try {
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_favoriteCompany.url.trim()}${idclient}/${idcompany}/${_isfavorite}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var fcompany = response.data;
        bool isAuthenticated = fcompany['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMasseg(
              "لم تتم الاضافة الى المفضلة", LigthColor.favorColor);
          return false;
        } else {
          ShowMasseg.ShowToastMasseg(
              "تمت الاضافة الى المفضلة", LigthColor.maingreencolor);
          return true;
        }
      } else {
        // print(response.statusMessage);
        ApiError.massegerror(response.statusCode, response.statusMessage);
        return false;
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////
  ///دالة الحذف من المفضلة
  static Future<bool?> deletefavoriteCompany(int? idfavoretcompany) async {
    //_clientid = order['clientId'];
    final Dio dio = new Dio();
    try {
      var response = await http.delete(Uri.parse(
          "${_baseUrl.baseurl.trim()}${_deleteFavoriteCompany.url.trim()}$idfavoretcompany"));

      // print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMasseg(
              "${data['message']}", LigthColor.favorColor);
          return false;
          // print(data['message']);
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
      // ShowMasseg.ShowToastMasseg(
      //     "لايوجد اتصال بالانترنت", LigthColor.favorColor);
      // print(e);
    }
  }

  ///////////////////////////////////
  ///دالة عرض الشركات على الخريطة
  static Future<List<CompanysMap>?> fetchMapDetails() async {
    Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getMyCompany.url.trim()}");
      print(response.statusCode);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        companymap = responsedata.map((e) => CompanysMap.fromJson(e)).toList();
        return companymap;
      } else {
        ApiError.massegerror(response.statusCode, response.data);
        return null;
      }
    } on DioException catch (e) {
      // print(e);
    }
  }
}

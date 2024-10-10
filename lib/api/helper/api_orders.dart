import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../models/ordersmodels/all_order_model.dart';
import '../../models/ordersmodels/isbooked_order_model.dart';
import '../../models/ordersmodels/isnotbooked_order_model.dart';
import '../../models/ordersmodels/transfers_wallet.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../apiurl.dart';
import 'api_errors.dart';

class Apiorder {
  static BaseUrl _baseUrl = new BaseUrl();
  static CreateOrderByWalletCordFromWeb _createOrderByWalletCordFromWeb =
      new CreateOrderByWalletCordFromWeb();
  static GetOrderById _getOrderById = new GetOrderById();
  static GetClintOrderAll _getClintOrderAll = new GetClintOrderAll();
  static GetClintIsNotBooked _getClintIsNotBooked = new GetClintIsNotBooked();
  static GetClintIsBooked _getClintIsBooked = new GetClintIsBooked();
  static GettransfersWallet _gettransfersWallet = new GettransfersWallet();
  static GetMyWallet _getMyWallet = new GetMyWallet();
  static UpdateWallet _updateWallet = new UpdateWallet();
  static CreateWallet _createWallet = new CreateWallet();
  static UpdateorderByClint _updateorderByClint = new UpdateorderByClint();

  ////////////////////////////////////////////
  static late List<AllOrder> allorder = [];
  static late List<IsNotBookedOrder> isnotbookedorder = [];
  static late List<IsBookedOrder> isbookedorder = [];
  static late List<TransferWallet> transferwalletlist = [];
  static var walletdata;
  //////////////////////////////////////////////////////
  ///دالة انشاء طلب حجز
  static Future<bool?> createorder(
      Map<String, dynamic> orderData, int? servicid) async {
    Dio dio = new Dio();
    try {
      var response = await http.post(
        Uri.parse(
            "${_baseUrl.baseurl.trim()}${_createOrderByWalletCordFromWeb.url.trim()}$servicid"),
        headers: <String, String>{
          // 'Content-Type': 'multipart/form-data',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //  body: json.encoder(orderData),
        body: jsonEncode(orderData),
      );

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
    } on DioException catch (e) {
      print(e);
    }
  }

  /////////////////////////////////////
  //دالة الاستعلام عن الطلب من خلال المعرف
  static Future<dynamic> fetchOrderDetails(int? id) async {
    final Dio dio = new Dio();

    try {
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getOrderById.url.trim()}${id}");
      print(response.statusCode);

      if (response.statusCode == 200) {
        var order = response.data;
        return order;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      // print(e);
    }
  }

  /////////////////////////////////////////////
  ///دالة الغاء الطلب
  static Future<bool?> cancelorder(int? id) async {
    try {
      var response = await http.delete(
        Uri.parse(
            "${_baseUrl.baseurl.trim()}${_updateorderByClint.url.trim()}${id}"),
        headers: {"Content-type": "application/json"},
        // body:
        // json.encode({"clientid": _clientid.toInt(), "stateOrderId": 5}
        // )
      );


      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print(data);
        bool isAuthenticated = data['isAuthenticated'];
        if (!isAuthenticated) {
          ShowMasseg.ShowToastMassegError(
              "${data['message'].toString()}", LigthColor.favorColor);
          return false;
        } else {
          ShowMasseg.ShowToastMasseg(
              "${data['message'].toString()}", LigthColor.maingreencolor);
          return true;
        }
      }  else {
         ApiError.massegerror(response.statusCode, response.body);
        return false;
      }
    } catch (e) {
    }
  }

  ////////////////////////////////////////
  ///دالة الاستعلام عن جميع الطلبات
  static Future<List<AllOrder>?> fetchdataAllorder(int id) async {
    // int clientid = checkid;
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getClintOrderAll.url.trim()}$id");
      print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;

      if (response.statusCode == 200) {
        allorder = responsedata.map((e) => AllOrder.fromJson(e)).toList();
        return allorder;
      } else if (response.statusCode == 400) {
        ShowMasseg.ShowToastMasseg("قم بتسجيل دخولك اولاً", LigthColor.delete);

        print(response.statusMessage);
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
      print(e);
    }
  }

  ////////////////////////////////////////////
  ///دالة الاستعلام عن الطلبات قيد الانتضار
  static Future<List<IsNotBookedOrder>?> fetchdataorderbooked(int id) async {
    // int clientid = checkid;
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_getClintIsNotBooked.url.trim()}$id");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        isnotbookedorder =
            responsedata.map((e) => IsNotBookedOrder.fromJson(e)).toList();
        return isnotbookedorder;
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
      print(e);
    }
  }

  ///////////////////////////////////////////
  ///دالة الاستعلام عن الكلبات التي تم الموافقه عليها
  static Future<List<IsBookedOrder>?> fetchdataorderaccept(int id) async {
    // int clientid = checkid;
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio
          .get("${_baseUrl.baseurl.trim()}${_getClintIsBooked.url.trim()}$id");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        isbookedorder =
            responsedata.map((e) => IsBookedOrder.fromJson(e)).toList();
        return isbookedorder;
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
      print(e);
    }
  }

  //////////////////////////////////////////////////
  ///دالة الاستعلام عن الحوالات
  static Future<List<TransferWallet>?> fetchdatatransferwallet(int id) async {
    // int clientid = checkid;
    final Dio dio = new Dio();

    try {
      // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
      var response = await dio.get(
          "${_baseUrl.baseurl.trim()}${_gettransfersWallet.url.trim()}${id}");
      // print(response.statusCode);
      // print(response.data);
      var responsedata = response.data as List;
      if (response.statusCode == 200) {
        transferwalletlist =
            responsedata.map((e) => TransferWallet.fromJson(e)).toList();
        return transferwalletlist;
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
      // ShowMasseg.ShowToastMasseg(
      //     "لايوجد اتصال بالانترنت", LigthColor.favorColor);
      // print(e);
    }
  }

  ///////////////////////////////////////////
  ///دالة الاستعلام عن المحفضة
  static Future<dynamic> fetchWalletDetails(int? id) async {
    final Dio dio = new Dio();
    // int id2 = 12;

    try {
      var response = await http.get(Uri.parse(
          "${_baseUrl.baseurl.trim()}${_getMyWallet.url.trim()}${id}"));
      // await dio
      //     .get(
      print(response.statusCode);
      if (response.statusCode == 200) {
        walletdata = json.decode(response.body);
        bool _isActive = walletdata['isActive'];
        if (!_isActive) {
          return 0;
        } else {
          return walletdata;
        }
        // if (!didDispose) {
        //   setState(() {
        //     if (!_isActive) {
        //       didDispose = true;
        //       _success = false;
        //       _stutes = "لايوجد لديك محفضة او تم الغاء تفعيلها";
        //       ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.delete);
        //       Navigator.pushReplacement(context,
        //           new MaterialPageRoute(builder: (context) => new No_wallet()));
        //     } else {
        //       _walletnumber = walletdata['walletNumber'].toString();
        //       _walletvalue = walletdata['value'].toString();
        //       walletid = walletdata['id'];
        //       didDispose = true;
        //       _success = true;
        //       _isActive = walletdata['isActive'];
        //     }
        //   });
        // }
      } else if (response.statusCode == 400) {
        ShowMasseg.ShowToastMasseg(
            "لايوجد اتصال بالانترنت", LigthColor.favorColor);
        return 0;
      } else {
        ShowMasseg.ShowToastMasseg(
            "لايوجد اتصال بالانترنت", LigthColor.favorColor);
        return 0;
      }
    }
    // on DioException
    catch (e) {
      // print(e);
    }
  }

  /////////////////////////////////////////////////////////
  ///دالة تعديل اضافة رصيد للمحفضه
  static Future<bool?> updateWaller(
      String bank_balanceController, int? walletid) async {
    try {
      var response = await http.post(
          Uri.parse(
              "${_baseUrl.baseurl.trim()}${_updateWallet.url.trim()}$walletid"),
          headers: {"Content-type": "application/json"},
          body: json.encode({"value": double.parse(bank_balanceController)}));

      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
        // data = json.decode(response.body);
        // isAuthenticated = data['isAuthenticated'];
        // if (!isAuthenticated) {
        //   // print(data['message']);
        //   _success = false;
        // } else {
        //   _success = true;
        // }
      } else if (response.statusCode == 400) {
        ShowMasseg.ShowToastMasseg("يرجى ادخال الرصيد", LigthColor.favorColor);
        return false;
      } else {
        ShowMasseg.ShowToastMasseg(
            "لايوجد اتصال بالانترنت", LigthColor.favorColor);
        return false;
      }
    } catch (e) {
      // setState(() {
      //   _stutes = "Error : Couldn't connect to server .";
      //   //_success = false;
      // });
    }
  }

  //////////////////////////////////////////////////////////////
  ///دالة انشاء محفضة
  static Future<bool?> createWaller(String email, String value) async {
    try {
      var response = await http.post(
          Uri.parse("${_baseUrl.baseurl.trim()}${_createWallet.url.trim()}"),
          headers: {"Content-type": "application/json"},
          body: json.encode({"email": email, "value": double.parse(value)}));

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
      } else if (response.statusCode == 400) {
        ShowMasseg.ShowToastMasseg(
            "يرجى ادخال الايميل ورصيد ابتدائي للمحفضة", LigthColor.favorColor);
        return false;
      } else {
        ShowMasseg.ShowToastMasseg(
            "لايوجد اتصال بالانترنت", LigthColor.favorColor);
        return false;
      }
    } catch (e) {
      // setState(() {
      //   _stutes = "Error : Couldn't connect to server .";
      //   //_success = false;
      // });
    }
  }
}

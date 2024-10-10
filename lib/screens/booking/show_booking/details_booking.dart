import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rafahia_web/api/helper/api_orders.dart';
// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../api/apiurl.dart';
import '../../../models/datausers/internalstorage.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../uitles/colors.dart';
import '../../../widget/booking_dateils.dart';
import '../../../widget/flutter_toast.dart';

class Detalis_Booking extends StatefulWidget {
  int? id;
  Detalis_Booking(
      {super.key,
      // required id,
      required this.id});

  @override
  State<Detalis_Booking> createState() => _Detalis_BookingState();
}

class _Detalis_BookingState extends State<Detalis_Booking> {
  BaseUrl _baseUrl = new BaseUrl();
  Generatepdf _generatepdf = new Generatepdf();
  var order;
  bool isAuthenticated = false;
  late bool? printpdf;
  late bool? _success;
  String _stutes = ' اضغط على الزر ';
  bool didDispose = false;

  Future<void> _fetchOrderDetails() async {
    order = await Apiorder.fetchOrderDetails(widget.id);
    didDispose = true;
    setState(() {});
  }

  Future<void> _cancelorder() async {
    _success = await Apiorder.cancelorder(widget.id);
    setState(() {});
  }

  Future<void> _generatepdforder() async {
    try {
      var response = await http.get(Uri.parse(
          "${_baseUrl.baseurl.trim()}${_generatepdf.url.trim()}${widget.id}"));

      print(response.statusCode);

      setState(() {
        if (response.statusCode == 200) {
          _launchUrl(Uri.parse(
              "${_baseUrl.baseurl.trim()}${_generatepdf.url.trim()}${widget.id}"));
          didDispose = true;
          printpdf = true;
          ShowMasseg.ShowToastMasseg(
              "تمت العملية بنجاح", LigthColor.maingreencolor);
          _stutes = "تمت العملية بنجاح";
        } else if (response.statusCode == 400) {
          _stutes = " error";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError("$_stutes", LigthColor.favorColor);
          // print(_stutes);
        } else if (response.statusCode == 401) {
          _stutes = "Unauthorized";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError("$_stutes", LigthColor.favorColor);
          // print(_stutes);
        } else if (response.statusCode == 403) {
          _stutes = "Forbidden : 403";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError("$_stutes", LigthColor.favorColor);
          // print(_stutes);
        } else if (response.statusCode == 404) {
          _stutes = "Not Found";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError("$_stutes", LigthColor.favorColor);
          // print(_stutes);
        } else if (response.statusCode == 500) {
          _stutes = "Internal Server Error";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError(
              "لايوجد اتصال بالانترنت", LigthColor.favorColor);
          // print(_stutes);
        } else {
          _stutes = "Unknown Error ${response.statusCode}";
          // didDispose = true;
          printpdf = false;
          ShowMasseg.ShowToastMassegError(
              "لايوجد اتصال بالانترنت", LigthColor.favorColor);
          // print(_stutes);
        }
      });
    } catch (e) {
      setState(() {
        // _stutes = "Error : Couldn't connect to server .";
        //_success = false;
        // didDispose = true;
      });
    }
  }

//final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> _launchUrl(Uri _launchurl) async {
    if (!await launchUrl(_launchurl)) {
      throw Exception('Could not launch $_launchurl');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 77,
        backgroundColor: LigthColor.maingreencolor,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              color: LigthColor.whiteColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              AwesomeDialog(
                width: MediaQuery.of(context).size.width / 2,
                titleTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 15),
                descTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 16),
                buttonsTextStyle: TextStyle(
                    fontFamily: "Rubik", color: LigthColor.whiteColor),
                btnOkText: "نعم",
                btnCancelText: "إلغاء",
                btnCancelColor: LigthColor.favorColor,
                btnOkColor: LigthColor.nanm1n,
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.rightSlide,
                title: 'أنتبه',
                desc: 'هل أنت متأكد من الغاء الطلب؟',
                btnCancelOnPress: () {
                  // Navigator.pop();
                },
                btnOkOnPress: () async {
                  setState(() {
                    didDispose = false;
                  });
                  await _cancelorder();
                  await _fetchOrderDetails();
                  // ShowMasseg.ShowToastMasseg(
                  //     "تمت العملية بنجاح", LigthColor.favorColor);
                  // await _fetchOrderDetails(widget.id);
                  // setState(() {
                  //   _fetchUserDetails(clientid);
                  // });
                  // Navigator.pushReplacement(
                  //       context,
                  //       new MaterialPageRoute(
                  //           builder: (context) => new Account_screen()));

                  // Navigator.pop(context);
                },
              ).show();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 20),
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                "الغاء الطلب",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: LigthColor.whiteColor,
                  fontSize: 14,
                  fontFamily: "Rubik",
                ),
              ),
            ),
          ),
        ],
      ),
      body: didDispose == false
          ? Center(
              child: LottieBuilder.asset(
                'assets/animation/loading_3bool.json',
                // height: 180,
                // width: 180,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: LigthColor.titles),
                      ),
                    ),
                    child: Text(
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      "تفاصيل الطلــب",
                      style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 25,
                          color: LigthColor.titles,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(20),
                            border: Border(
                                bottom: BorderSide(
                                  color: LigthColor.titles,
                                ),
                                top: BorderSide(
                                  color: LigthColor.titles,
                                ))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              TextDateils(
                                textapi: "${order['id']}",
                                text: "رقم الطلب ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['client']}",
                                text: "أسم العميل ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['clientphonenumber']}",
                                text: "رقم العميل ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['companyName']}",
                                text: " أسم الشركة ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['service']}",
                                text: " أسم الخدمة ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['stateOrder']}",
                                text: " حالة الطلب ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['short_time_in']}",
                                text: "تاريخ الوصول ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['short_time_out']}",
                                text: "تاريخ المغادرة ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['sumDay']} ليالي",
                                text: " عدد الليالي  ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['price']} ريال",
                                text: "السعر ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['priseState']}",
                                text: "حالة السعر ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['numberPeople']} اشخاص",
                                text: "عدد الاشخاص ",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextDateils(
                                textapi: "${order['short_time_create']}",
                                text: " تاريخ الطلب  ",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: LigthColor.titlesred,
                        ),
                      ),
                      //   borderRadius: BorderRadius.only(
                      //       bottomLeft: Radius.circular(2),
                      //       topRight: Radius.circular(2),
                      //       bottomRight: Radius.circular(20),
                      //       topLeft: Radius.circular(20)),
                    ),
                    child: Text(
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      "تفاصيل الإلغاء",
                      style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 20,
                          color: LigthColor.titlesred,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(20),
                            border: Border(
                                bottom: BorderSide(
                                  color: LigthColor.titlesred,
                                ),
                                top: BorderSide(
                                  color: LigthColor.titlesred,
                                ))),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      // "",
                                      "${order['is_cancel']}",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 13)),
                                  Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "الالغاء   ",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      // "",
                                      "${order['cancelby']}",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 13)),
                                  Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "القائم بالالغاء   ",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${order['time_cancel']}",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 13)),
                                  Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      " تاريخ الالغاء   ",
                                      style: TextStyle(
                                          fontFamily: "Rubik", fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     setState(() {
                  //       didDispose = false;
                  //     });
                  //     await _generatepdforder();
                  //     if (!printpdf) {
                  //       AwesomeDialog(
                  //         context: context,
                  //         dialogType: DialogType.error,
                  //         animType: AnimType.rightSlide,
                  //         title: 'Error',
                  //         desc: 'خطا',
                  //       ).show();
                  //     } else {
                  //       AwesomeDialog(
                  //               context: context,
                  //               dialogType: DialogType.success,
                  //               animType: AnimType.rightSlide,
                  //               title: 'success',
                  //               desc: 'تمت العملية بنجاح',
                  //               // },
                  //               btnOkOnPress: () {
                  //                 // Navigator.pushReplacement(
                  //                 //     context,
                  //                 //     new MaterialPageRoute(
                  //                 //         builder: (context) => new Nav_Bar()));
                  //               })
                  //           .show();
                  //     }
                  //   },
                  //   child: Container(
                  //     width: 90,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Color.fromARGB(173, 59, 89, 114),
                  //     ),
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       " طباعة",
                  //       style: TextStyle(color: Colors.white, fontSize: 18),
                  //     ),
                  //   ),
                  // ),
                ]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: LigthColor.print,
          onPressed: () async {
            setState(() {
              didDispose = false;
            });
            await _generatepdforder();
            await _fetchOrderDetails();

            // showDialog(
            //   context: context,
            //   builder: (context) => const DownloadingDialog(),
            // );
          },
          tooltip: ' طباعة الطلب',
          child: Icon(
            Icons.local_print_shop_outlined,
            color: LigthColor.whiteColor,
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
    // _controller.dispons();
    super.dispose();
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1800) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../api/helper/api_token.dart';
import '../../models/datausers/internalstorage.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import 'show_booking/show_accept_booking.dart';
import 'show_booking/show_all_booking.dart';
import 'show_booking/show_ordering_booking.dart';

class Booking_Screen extends StatefulWidget {
  const Booking_Screen({super.key});

  @override
  State<Booking_Screen> createState() => _Booking_ScreenState();
}

class _Booking_ScreenState extends State<Booking_Screen> {
  // Future<void> testgettoken() async {
  //   String? test = await ApiToken.getToken();
  //   print(test);
  // }
  late bool issignedin = false;
  var checkid;
  Future<void> getFile() async {
    // checkid = await FileOperations.readFile();

    checkid = await ApiToken.getId();

    if (checkid == null || checkid == 0) {
      setState(() {
        issignedin = false;
      });

      ShowMasseg.ShowToastMasseg("قم بتسجيل دخولك اولاً", LigthColor.delete);
      // print(checkid);
      // print(issignedin);
    } else {
      setState(() {
        issignedin = true;
      });
      // print(checkid);
      // print(issignedin);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFile();
    // testgettoken();
  }

  //bool didDispose = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: LigthColor.maingreencolor,
          bottom: TabBar(
            indicatorColor: LigthColor.whiteColor,
            labelColor: LigthColor.whiteColor,
            unselectedLabelColor: const Color.fromARGB(255, 233, 233, 233),
            padding: EdgeInsets.only(top: 10),
            tabs: [
              SizedBox(
                  height: 70,
                  child: Text(
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      " جميع الطلبات",
                      style: TextStyle(fontFamily: "Rubik"))),
              SizedBox(
                  height: 70,
                  child: Text(
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    "قيد الانتظار",
                    style: TextStyle(fontFamily: "Rubik"),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 70,
                child: Text(
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    " تم الموافقة",
                    style: TextStyle(fontFamily: "Rubik")),
              )
            ],
          ),
          title: Text(
            textScaleFactor: ScaleSize.textScaleFactor(context),
            "طلباتي",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: LigthColor.whiteColor,
                fontFamily: "Rubik"),
          ),
          centerTitle: true,
        ),
        body: issignedin == false
            ? Center(
                child: LottieBuilder.asset(
                  'assets/animation/search_none.json',
                  // height: 180,
                  // width: 180,
                ),
              )
            : TabBarView(
                children: [
                  ALL_Booking(
                    id: checkid,
                  ),
                  Ordering_Booking(id: checkid,),
                  Accept_Booking(id: checkid,),
                ],
              ),
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

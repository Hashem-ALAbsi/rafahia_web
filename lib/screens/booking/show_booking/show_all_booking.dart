import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/screens/account/account-screen.dart';

import '../../../api/apiurl.dart';
import '../../../api/helper/api_orders.dart';
import '../../../api/helper/api_token.dart';
import '../../../models/datausers/internalstorage.dart';

import '../../../models/ordersmodels/all_order_model.dart';
import '../../../uitles/colors.dart';
import '../../../widget/flutter_toast.dart';
import 'details_booking.dart';

class ALL_Booking extends StatefulWidget {
  int id;
  ALL_Booking({super.key, required this.id});

  @override
  State<ALL_Booking> createState() => _ALL_BookingState();
}

class _ALL_BookingState extends State<ALL_Booking> {
  late bool didDispose = false;
  late List<AllOrder>? allorder = [];

  Future<void> fechallorder(int id) async {
    // id = widget.id;
    allorder = await Apiorder.fetchdataAllorder(id);
    // print(allorder);
    if (allorder!.isEmpty) {
      setState(() {
        didDispose = false;
      });
    } else {
      setState(() {
        didDispose = true;
      });
    }
  }

  Future<void> _handRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    didDispose = false;
    await fechallorder(widget.id);
    // return await getFile();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechallorder(widget.id);
    // testgettoken();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> getFile() async {
    //   // checkid = await FileOperations.readFile();

    //   checkid = await ApiToken.getId();

    //   if (checkid == null || checkid == 0) {
    //     // setState(() {
    //     //   issignedin = false;
    //     // });

    //     ShowMasseg.ShowToastMasseg("قم بتسجيل دخولك اولاً", LigthColor.delete);
    //     // print(checkid);
    //     // print(issignedin);
    //   } else {
    //     fechallorder(checkid);
    //     // setState(() {
    //     //   didDispose = true;
    //     // });
    //     print(checkid);
    //   }
    //   print(checkid);
    // }

    return Scaffold(
      body: didDispose == false
          ? Center(
              child: LottieBuilder.asset(
                'assets/animation/search_none.json',
                // height: 180,
                // width: 180,
              ),
            )
          : LiquidPullToRefresh(
              onRefresh: _handRefresh,
              color: LigthColor.supmaincolor,
              height: 100,
              backgroundColor: LigthColor.whiteColor,
              animSpeedFactor: 2,
              showChildOpacityTransition: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // ...allorder.map(
                      //   (allorders) =>
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            ...allorder!.map(
                              (allorders) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new Detalis_Booking(
                                                        id: allorders.id)));
                                        // print(estrahies.id);
                                      },
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: LigthColor.shadow,
                                                    blurRadius: 2.0,
                                                    spreadRadius: 1.0,
                                                    offset: Offset(2.0, 0.0),
                                                  ),
                                                ],
                                                color: LigthColor.whiteColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 40),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),

                                                      // "فندق موفبيك ",
                                                      "${allorders.clientName}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: "Rubik",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    // T
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),

                                                      // "ليا",
                                                      " ${allorders.service} - ${allorders.companyName}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "Rubik",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 1,
                                                    ),

                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),

                                                      // "لةاس",
                                                      "${allorders.stateOrder}",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily: "Rubik",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),

                                                      // "بيس",
                                                      "${allorders.createAt} : التاريخ",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Rubik",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 110),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  color: LigthColor.allorder,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: LigthColor.shadow,
                                                      blurRadius: 2.0,
                                                      spreadRadius: 1.0,
                                                      offset: Offset(2.0, 0.0),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, left: 20),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      40,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            LigthColor.shadow,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 1.0,
                                                        offset:
                                                            Offset(2.0, 0.0),
                                                      ),
                                                    ],
                                                    color: LigthColor.allorder,
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, right: 20),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      40,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              LigthColor.shadow,
                                                          blurRadius: 2.0,
                                                          spreadRadius: 1.0,
                                                          offset:
                                                              Offset(2.0, 0.0),
                                                        ),
                                                      ],
                                                      color:
                                                          LigthColor.allorder)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 17, left: 10),
                                            child: Image.asset(
                                              "assets/images/alldeatails.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
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

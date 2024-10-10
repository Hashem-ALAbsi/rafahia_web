import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

import '../../../api/apiurl.dart';
import '../../../api/helper/api_orders.dart';
import '../../../models/datausers/internalstorage.dart';

import '../../../models/ordersmodels/isbooked_order_model.dart';
import '../../../uitles/colors.dart';
import '../../../widget/flutter_toast.dart';
import 'details_booking.dart';

class Accept_Booking extends StatefulWidget {
  int id;
  Accept_Booking({super.key, required this.id});

  @override
  State<Accept_Booking> createState() => _Accept_BookingState();
}

class _Accept_BookingState extends State<Accept_Booking> {
  late bool didDispose = false;
  late List<IsBookedOrder>? isbookedorder = [];

  Future<void> fechallorder(int id) async {
    // id = widget.id;
    isbookedorder = await Apiorder.fetchdataorderaccept(id);
    // print(allorder);
    if (isbookedorder!.isEmpty) {
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
                      ...isbookedorder!.map(
                        (acceptorders) => Padding(
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
                                                  id: acceptorders.id)));
                                  // print(estrahies.id);
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
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
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),

                                                // "فندق موفبيك ",
                                                "${acceptorders.clientName}",
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
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),

                                                // "ليا",
                                                " ${acceptorders.service} - ${acceptorders.companyName}",
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
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),

                                                // "لةاس",
                                                "${acceptorders.stateOrder}",
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
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),

                                                // "بيس",
                                                "${acceptorders.createAt} : التاريخ",
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
                                          margin: EdgeInsets.only(top: 110),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20)),
                                            color: LigthColor.acceptorder,
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
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: LigthColor.shadow,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(2.0, 0.0),
                                                ),
                                              ],
                                              color: LigthColor.acceptorder,
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
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: LigthColor.shadow,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(2.0, 0.0),
                                                ),
                                              ],
                                              color: const Color.fromARGB(
                                                  255, 115, 177, 162),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 17, left: 10),
                                      child: Image.asset(
                                        "assets/images/acceptbook.png",
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8,
                                        width:
                                            MediaQuery.of(context).size.width /
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

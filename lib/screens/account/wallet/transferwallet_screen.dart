import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

import '../../../api/helper/api_orders.dart';
import '../../../models/ordersmodels/transfers_wallet.dart';
import '../../../uitles/colors.dart';
import '../../booking/show_booking/details_booking.dart';

class TransferWalletSctreen extends StatefulWidget {
  int id;
  TransferWalletSctreen({super.key, required this.id});

  @override
  State<TransferWalletSctreen> createState() => _TransferWalletSctreenState();
}

class _TransferWalletSctreenState extends State<TransferWalletSctreen> {
  late bool _stutes = false;
  bool didDispose = false;
  late List<TransferWallet>? transferwalletlist = [];
  Future<void> _fetchdatatransferwallet(int id) async {
    transferwalletlist = await Apiorder.fetchdatatransferwallet(id);
    if (transferwalletlist!.isEmpty) {
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
    await _fetchdatatransferwallet(widget.id);
    // return await getFile();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchdatatransferwallet(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LigthColor.maingreencolor,
        title: Text(
          "الحوالات",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: LigthColor.whiteColor,
              fontFamily: "Rubik"),
        ),
        //LigthColor.maingreencolor,
        toolbarHeight: 88,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              color: LigthColor.whiteColor,
              size: 20,
            ),
          ),
        ),
      ),
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
                      ...transferwalletlist!.map(
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
                                                  id: acceptorders.idorder)));
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
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
                                              top: 10, right: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // Text(
                                              //   textScaleFactor:
                                              //       ScaleSize.textScaleFactor(
                                              //           context),

                                              //   ": المرسل",
                                              //   //  ${transferwalletlistes.clientname",
                                              //   // textDirection:
                                              //   //     TextDirection.ltr,
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       fontFamily: "Rubik",
                                              //       fontWeight:
                                              //           FontWeight.w500),
                                              // ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              // T
                                              Text(
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),
                                                // ": رقم الطلب",

                                                " المرسل :  ${acceptorders.clientname}",
                                                textDirection:
                                                    TextDirection.rtl,
                                                //   style: TextStyle(
                                                //       fontSize: 12,
                                                //       fontFamily: "Rubik",
                                                //       fontWeight:
                                                //           FontWeight.w500),
                                                // ),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Rubik",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),

                                              Text(
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),

                                                // ": المستلم",
                                                "المستلم : ${acceptorders.companyname}",
                                                textDirection:
                                                    TextDirection.rtl,
                                                // ${transferwalletlistes.companyname}
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Rubik",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),
                                                "حجز الخدمة : ${acceptorders.servicename}",
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Rubik",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),
                                                "المبلغ :${acceptorders.price.toString()} ريال",
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Rubik",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),
                                                "${acceptorders.createAt} : التاريخ",
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Rubik",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(top: 140),
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
                              )
                            ],
                          ),
                        ),
                      ),
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

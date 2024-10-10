import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../api/apiurl.dart';
import '../../api/helper/api_image.dart';
import '../../api/helper/api_service.dart';
import '../../models/imagemodels/image_service_model.dart';
import '../../models/servicemodels/service_model.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import 'calender.dart';
import 'class_date.dart';

//import '../../servicecompanys/servicecompany_list.dart';
//الخاصة بتفاصيل الخدمات  داخل الانشطة
class ServiceDetailsScreen extends StatefulWidget {
  final int? id;

  ServiceDetailsScreen({required this.id});

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  var checkid;
  var service;
  var data;

  bool didDispose = false;
  late bool _succes;
  String _stutes = "";

  //bool didDispose2 = false;

  final today = DateTime.now();

  //final String baseUrl = "http://192.168.1.102:7094";

  //تفاصيل الخدمة

  var detailservice;
  Future<void> _getdetailsservice(int? id) async {
    detailservice = await ApiService.fetchServiceDetails(id);
    // serviceimages = await ApiImage.fetchImageServiseDetails(id);
    // allcompany = await ApiService.fetchServiceDetails(1);
    // await _getallimages(id);
    // await _getallimages(widget.id);
    didDispose = true;
    setState(() {});
    //print(hotelsugge!.map((e) => e.name));
    // print(detailservice['name']);
    // print(allcompany['name']);
  }

  late List<Image_service>? serviceimages = [];
  Future<void> _getallimages(int? id) async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    serviceimages = await ApiImage.fetchImageServiseDetails(id);
    // didDispose = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(commenti!.map((e) => e.commentname));
  }

  @override
  void initState() {
    _getdetailsservice(widget.id);
    _getallimages(widget.id);
    super.initState();
  }

//==================
  // late DateTime? arrive;
  // late DateTime? leave;
  // late Datetimeorder datetimeorder = Datetimeorder();
  // Date_Piker _date_piker = Date_Piker();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: didDispose == false
                ? Center(
                    child: LottieBuilder.asset(
                      'assets/animation/loading_3bool.json',
                      // height: 180,
                      // width: 180,
                    ),
                  )
                : CustomScrollView(slivers: [
                    SliverAppBar(
                      backgroundColor: LigthColor.maingreencolor,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: FaIcon(FontAwesomeIcons.angleLeft,
                            color: LigthColor.whiteColor),
                      ),
                      expandedHeight: 400,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        // title: Text(
                        //   "${detailservice['name']}",
                        //   style: TextStyle(
                        //       fontSize: 28, fontWeight: FontWeight.w700),
                        // ),
                        centerTitle: true,
                        expandedTitleScale: 1.5,
                        collapseMode: CollapseMode.parallax,
                        background: Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ), // Set the desired radius here
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                detailservice["imageService"].toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ...serviceimages!.map(
                                      (imagelist) => Card(
                                        child: InkWell(
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  imagelist.date.toString(),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      height: 500,
                                                      width: 400,
                                                      // color: Color.fromARGB(255, 33, 91, 138),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            LigthColor.caleder,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                        ), // Set the desired radius here
                                                        image: DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                            imagelist.date
                                                                .toString(),
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: LigthColor.graycolor,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                  " ${detailservice['name']}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: LigthColor.caleder,
                                    fontFamily: "Rubik",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 0, right: 8),
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.shadow,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 0.0),
                                        ),
                                      ],
                                      color: LigthColor.nostarsColor,
                                    )),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              100,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                        color: LigthColor.caleder,
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
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    "${detailservice['number']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Rubik",
                                      color: LigthColor.massegeColor,
                                    ),
                                  ),
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    " : الرقم",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Rubik",
                                      color: LigthColor.massegeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 0, right: 8),
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.shadow,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 0.0),
                                        ),
                                      ],
                                      color: LigthColor.nostarsColor,
                                    )),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              100,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                        color: LigthColor.caleder,
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
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    "${detailservice['numberPeople']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Rubik",
                                      color: LigthColor.massegeColor,
                                    ),
                                  ),
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    " تتسع لـ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Rubik",
                                      color: LigthColor.massegeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 0, right: 8),
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.shadow,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 0.0),
                                        ),
                                      ],
                                      color: LigthColor.nostarsColor,
                                    )),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              100,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                        color: LigthColor.caleder,
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
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    "ريال ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Rubik",
                                        color: LigthColor.massegeColor),
                                  ),
                                  Text(
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    "${detailservice['price']} ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: LigthColor.massegeColor),
                                  ),
                                  Image.asset(
                                    "assets/images/mony.png",
                                    height: 28,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                  "المبلغ الاجمالي لليوم الواحد ",
                                  style: TextStyle(
                                    color: LigthColor.graycolor,
                                    fontSize: 14,
                                    fontFamily: "Rubik",
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 7, right: 8, bottom: 10),
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.shadow,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 0.0),
                                        ),
                                      ],
                                      color: LigthColor.nostarsColor,
                                    )),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              100,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                        color: LigthColor.caleder,
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
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 5),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "الوصف",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w600,
                                          color: LigthColor.massegeColor))),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.4,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: LigthColor.whiteColor,
                                      /************************************/
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.maingreencolor,
                                          offset: const Offset(
                                            2.0,
                                            1.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 0.1,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            textScaleFactor:
                                                ScaleSize.textScaleFactor(
                                                    context),
                                            "${detailservice['description']}",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Rubik",
                                                color: LigthColor.massegeColor),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            //-------------------------------------------------------------------------
                            Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: Expanded(
                                        child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    LigthColor.maingreencolor),
                                          ),
                                          onPressed: () {
                                            ShowMasseg.ShowToastMasseg(
                                                "يرجى تحديد تاريخ الوصول والخروج قبل الحجز",
                                                LigthColor.delete);
                                            //Date_Piker
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    backgroundColor:
                                                        LigthColor.caleder,
                                                    title: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'معلومات الحجز ',
                                                        style: TextStyle(
                                                            fontFamily: "Rubik",
                                                            backgroundColor:
                                                                LigthColor
                                                                    .caleder,
                                                            color: LigthColor
                                                                .whiteColor,
                                                            fontSize: 24),
                                                      ),
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 600,
                                                            width: 400,
                                                            child: Date_Piker(
                                                                id: widget.id,
                                                                price: double.parse(
                                                                    detailservice[
                                                                            'price']
                                                                        .toString()),
                                                                servicename:
                                                                    detailservice[
                                                                        'name']),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );

                                                  // The "تم" button
                                                });
                                          },
                                          child: Text(
                                            " احجز",
                                            style: TextStyle(
                                                color: LigthColor.whiteColor,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //-------------------------------------------------
                                ))
                          ],
                        ),
                      ),
                    )
                  ]),),);
  }
   @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
    // _controller.dispons();
    super.dispose();
  }
}

//for resposive text
class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/screens/account/infor_user/change_pass.dart';
import 'package:rafahia_web/screens/nav_bar.dart';

import '../../api/helper/api_token.dart';
import '../../api/helper/api_userclient.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../booking/booking_screen.dart';
import '../favoritecompanys/favorite_screen.dart';
import 'infor_user/update_user.dart';
import 'wallet/my_wallet.dart';
import 'wallet/transferwallet_screen.dart';

class Account_screen extends StatefulWidget {
  int id;
  Account_screen({super.key, required this.id});

  @override
  State<Account_screen> createState() => _Account_screenState();
}

class _Account_screenState extends State<Account_screen> {
  var data;
  bool didDispose = false;
  late String? _useremail;
  late String? _username;

  Future<void> fetchUsername(int? id) async {
    // print("//////////////////////////////////////");
    // print(id);
    data = await ApiUserClient.fetchUsernameDetails(id);
    // await Future.delayed(Duration(seconds: 3));
    setState(() {
      _useremail = data['userEmail'].toString();
      _username = data['fullName'].toString();
      didDispose = true;
    });
    // print(data['fullName'].toString());
  }

  Future<void> _handRefresh() async {
    // didDispose = false;
    await fetchUsername(widget.id);
    //await Future.delayed(Duration(seconds: 2));
    // issignedin = true;
    // return await getFile();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUsername(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return didDispose == false
        ? Center(
            child: LottieBuilder.asset(
              'assets/animation/loading_3bool.json',
              // height: 180,
              // width: 180,
            ),
          )
        : LiquidPullToRefresh(
            onRefresh: _handRefresh,
            // () => _handRefresh(),
            color: LigthColor.supmaincolor,
            height: 200,
            backgroundColor: LigthColor.whiteColor,
            animSpeedFactor: 2,
            showChildOpacityTransition: true,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: LigthColor.maingreencolor,
                expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
                pinned: true,
                leading: Container(
                  color: LigthColor.maingreencolor,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1.5,
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    children: [
                      Stack(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 60),
                          //   child: Image.asset("assets/images/account.png",
                          //       height: 140),
                          // ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 100, right: 100, top: 40, bottom: 10),
                            child: Align(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: LigthColor.whiteColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 130,
                                        color: LigthColor.maingreencolor,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 110, top: 115),
                                      height: 25,
                                      width: 25,
                                      decoration: const BoxDecoration(
                                          color: LigthColor.iconservice,
                                          shape: BoxShape.circle),
                                    ),

                                    // Container(
                                    //     height: 200,
                                    //     width: 200,
                                    //     decoration: const BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: Color.fromARGB(163, 87, 124, 163),
                                    //     ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _username == null
                          ? Text(
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              "  مرحبا بك ",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: LigthColor.whiteColor,
                                  fontFamily: "Rubik"),
                            )
                          : Text(
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              // textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              "مرحبا ${_username?.toString()}",
                              // ${data['fullName']}
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: LigthColor.whiteColor,
                                  fontFamily: "Rubik"),
                            ),
                      // data['userEmail'] == null
                      // ?
                      // Text(
                      //     textScaleFactor: ScaleSize.textScaleFactor(context),
                      //     "YorEmail.gmail.com",
                      //     //"hashem@galam.com",
                      //     style: TextStyle(
                      //         fontFamily: "Rubik",
                      //         fontSize: 15,
                      //         color: LigthColor.emails))
                      // :
//,
                      SizedBox(
                        height: 10,
                      ),
                      // data['userEmail'] == null
                      //     ? Text(
                      //         textScaleFactor:
                      //             ScaleSize.textScaleFactor(context),
                      //         "YorEmail.gmail.com",
                      //         //"hashem@galam.com",
                      //         style: TextStyle(
                      //             fontFamily: "Rubik",
                      //             fontSize: 15,
                      //             color: LigthColor.emails))
                      //     :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.copy_all,
                              size: 30,
                              color: LigthColor.subwhiteColor,
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: _useremail.toString()),
                              );
                              ShowMasseg.ShowToastMasseg(
                                  "تم النسخ بنجاح", LigthColor.acceptorder);
                              // ShowMasseg.ShowToastMasseg(
                              //     "تم النسخ بنجاح", LigthColor.acceptorder);
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              _useremail?.toString() ?? "hashem@galam.com",
                              //"hashem@galam.com",
                              style: TextStyle(
                                  fontSize: 15, color: LigthColor.emails)),
                        ],
                      ),
//                       Text(
//                           textScaleFactor: ScaleSize.textScaleFactor(context),
// // ""
//                           // ${data['userEmail']}
//                           "hashem@galam.com",
//                           style: TextStyle(
//                               fontSize: 15, color: LigthColor.emails)),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            // setState(() {
                            //   didDispose = false;
                            // });
                            // didDispose = false;
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new UpdatUser(
                                          id: widget.id,
                                        )));
                            print(didDispose);
                          },
                          child: Text(
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            "تعديل البيانات الشخصية",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500,
                                color: LigthColor.walletbak),
                          ))
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Booking_Screen()));
                        },
                        child: Container(
                          color: LigthColor.whiteColor,
                          height: 90,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new Booking_Screen()));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.angleLeft)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "حجوزاتي",
                                    style: TextStyle(
                                        fontFamily: "Rubik", fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("assets/images/booking.png",
                                      height: 23)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new FovaretScreen()));
                        },
                        child: Container(
                          color: LigthColor.whiteColor,
                          height: 70,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new FovaretScreen()));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.angleLeft)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "المفضلة",
                                    style: TextStyle(
                                        fontFamily: "Rubik", fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("assets/images/favort.png",
                                      height: 23)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "المحفطة",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: LigthColor.supmaincolor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new My_Wallet(
                                        id: widget.id,
                                      )));
                        },
                        child: Container(
                          color: LigthColor.whiteColor,
                          height: 70,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new My_Wallet(
                                                  id: widget.id,
                                                )));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.angleLeft)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " الرصيد",
                                    style: TextStyle(
                                        fontFamily: "Rubik", fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("assets/images/wallet.png",
                                      height: 23)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new TransferWalletSctreen(
                                        id: widget.id,
                                      )));
                        },
                        child: Container(
                          color: LigthColor.whiteColor,
                          height: 70,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new TransferWalletSctreen(
                                                  id: widget.id,
                                                )));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.angleLeft)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " الحوالات",
                                    style: TextStyle(
                                        fontFamily: "Rubik", fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("assets/images/wall.png",
                                      height: 23)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "المعلومات الشخصية",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: LigthColor.supmaincolor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new UpdatUser(
                                        id: widget.id,
                                      )));
                        },
                        child: Container(
                          color: LigthColor.whiteColor,
                          height: 70,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new UpdatUser(
                                                  id: widget.id,
                                                )));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.angleLeft)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "بياناتي الشخصية",
                                    style: TextStyle(
                                        fontFamily: "Rubik", fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("assets/images/updateaccount.png",
                                      height: 23)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: LigthColor.whiteColor,
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        var height =
                                            MediaQuery.of(context).size.height;
                                        var width =
                                            MediaQuery.of(context).size.width;
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          backgroundColor:
                                              LigthColor.maingreencolor,
                                          title: Align(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'معلومات كلمة المرور ',
                                              style: TextStyle(
                                                  fontFamily: "Rubik",
                                                  color: LigthColor.whiteColor,
                                                  fontSize: 22),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 300,
                                                  width: 300,
                                                  child: Changepass(
                                                    id: widget.id,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: FaIcon(FontAwesomeIcons.angleLeft)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "كلمة المرور",
                                  style: TextStyle(
                                      fontFamily: "Rubik", fontSize: 17),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/pass.png",
                                    height: 23)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "معلومات مهمة",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: LigthColor.supmaincolor),
                      ),
                      Container(
                        color: LigthColor.whiteColor,
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         // builder: (context) => new Notiation_Screen())),
                                  //         builder: (context) =>
                                  //             new ConnectWithUs()));
                                },
                                icon: FaIcon(FontAwesomeIcons.angleLeft)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "تواصل معنا",
                                  style: TextStyle(
                                      fontFamily: "Rubik", fontSize: 17),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/connet.png",
                                    height: 23)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: LigthColor.whiteColor,
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             new About_Screen()));
                                },
                                icon: FaIcon(FontAwesomeIcons.angleLeft)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "من  نحن",
                                  style: TextStyle(
                                      fontFamily: "Rubik", fontSize: 17),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/who.png", height: 23)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: LigthColor.whiteColor,
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         // builder: (context) => new Notiation_Screen())),
                                  //         builder: (context) =>
                                  //             new Poltic()));
                                },
                                icon: FaIcon(FontAwesomeIcons.angleLeft)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "سياسة الخصوصية",
                                  style: TextStyle(
                                      fontFamily: "Rubik", fontSize: 17),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/policy.png",
                                    height: 23)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          AwesomeDialog(
                            titleTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 15),
                            descTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 16),
                            buttonsTextStyle: TextStyle(
                                fontFamily: "Rubik",
                                color: LigthColor.whiteColor),
                            btnOkText: "نعم",
                            btnCancelText: "إلغاء",
                            btnCancelColor: LigthColor.favorColor,
                            btnOkColor: LigthColor.nanm1n,
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              // await updateFile();
                              // if (_logoutdone == true) {
                              AwesomeDialog(
                                titleTextStyle: TextStyle(
                                    fontFamily: "Rubik", fontSize: 15),
                                descTextStyle: TextStyle(
                                    fontFamily: "Rubik", fontSize: 15),
                                buttonsTextStyle: TextStyle(
                                    fontFamily: "Rubik",
                                    color: LigthColor.whiteColor),
                                btnOkText: "تم",

                                btnOkColor: LigthColor.maingreencolor,
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                //btnOkOnPress: () => exit(0),
                                btnOkOnPress: () async {
                                  int userid = 0;
                                  await ApiToken.setId(userid);
                                  // await ApiToken.clearToken();
                                  // Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Nav_barr()));
                                },

                                title: 'نجح',
                                desc: 'تمت العملية بنجاح',
                              ).show();
                            },
                            title: 'تنبيه',
                            desc: 'هل أنت متاكد من تسجيل الخروج؟',
                          ).show();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          // child: InkWell(

                          child: Text(
                            "تسجيل الخروج  ",
                            style: TextStyle(
                                fontFamily: "Rubik",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: LigthColor.favorColor),
                          ),
                          // ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    didDispose = true;
    print(didDispose);
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

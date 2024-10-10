import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/api/helper/api_orders.dart';

import '../../../uitles/colors.dart';
import '../../../widget/animations.dart';
import '../../../widget/flutter_toast.dart';
import '../../../widget/wiget_regester_login.dart';
import 'crate_wallet.dart';
import 'no_wallet.dart';

class My_Wallet extends StatefulWidget {
  int id;
  My_Wallet({super.key, required this.id});

  @override
  State<My_Wallet> createState() => _My_WalletState();
}

class _My_WalletState extends State<My_Wallet> {
  String? _walletnumber;
  String? _walletvalue;
  var walletdata;

  bool _visible = false;
  int walletid = 0;
  bool _isActive = false;
  bool didDispose = false;
  bool? _success;

  final TextEditingController _bank_balanceController = TextEditingController();

  Future<void> _fetchWalletDetails(int id) async {
    walletdata = await Apiorder.fetchWalletDetails(id);
    if (walletid == null || walletdata == 0) {
      setState(() {
        didDispose = true;
      });
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => new No_wallet(
                    id: id,
                  )));
    } else {
      setState(() {
        _walletnumber = walletdata['walletNumber'].toString();
        _walletvalue = walletdata['value'].toString();
        walletid = walletdata['id'];
        // _success = true;
        _isActive = walletdata['isActive'];
        didDispose = true;
      });
    }
  }

  Future<void> _updateWaller(String _bank) async {
    _success = await Apiorder.updateWaller(_bank, walletid);
    // if(_success )
  }

  Future<void> _handRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    didDispose = false;
    return await _fetchWalletDetails(widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWalletDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LigthColor.maingreencolor,
        toolbarHeight: 80,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              color: LigthColor.walletbak,
            ),
          ),
        ),
      ),
      body: AnimatingBg2(
        child: didDispose == false
            ? Center(
                child: LottieBuilder.asset(
                  'assets/animation/loading_3bool.json',
                  // height: 180,
                  // width: 180,
                ),
              )
            : Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: LigthColor.maingreencolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(700),
                          bottomRight: Radius.circular(700)),
                      border: Border(
                          bottom: BorderSide(
                              color: LigthColor.bieagcolor, width: 20))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      "قم بشحن محفظتك ",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Rubik",
                          color: LigthColor.walletbak,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: LottieBuilder.asset('assets/animation/wallet.json',
                        height: MediaQuery.of(context).size.height / 1.9,
                        width: MediaQuery.of(context).size.width / 1.9),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, top: 300, bottom: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: const LinearGradient(
                              transform: GradientRotation(100),
                              colors: [
                                LigthColor.wallet1color,
                                LigthColor.wallet2color,
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: LigthColor.massegeColor.withOpacity(.25),
                              offset: Offset(0, 15),
                              blurRadius: 45,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                      ),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: LigthColor.favorColor),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: LigthColor.logocard,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 50, top: 60),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.copy_all,
                                            size: 30,
                                            color: LigthColor.subwhiteColor,
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      _walletnumber.toString()),
                                            );
                                            ShowMasseg.ShowToastMasseg(
                                                "تم النسخ بنجاح",
                                                LigthColor.acceptorder);
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          textScaleFactor:
                                              ScaleSize.textScaleFactor(
                                                  context),
                                          _walletnumber?.toString() ??
                                              "0000000000",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: LigthColor.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, top: 20),
                                      child: Text(
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        "الرصيد المتاح",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: LigthColor.subwhiteColor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, top: 10),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                                Icons.remove_red_eye_outlined,
                                                size: 25,
                                                color: LigthColor.whiteColor),
                                            onPressed: () {
                                              setState(() {
                                                _visible = !_visible;
                                                // print(_visible);
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Visibility(
                                            visible: _visible,
                                            child: Text(
                                              textScaleFactor:
                                                  ScaleSize.textScaleFactor(
                                                      context),
                                              _walletvalue?.toString() ??
                                                  "0000000000",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: LigthColor.whiteColor),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            textScaleFactor:
                                                ScaleSize.textScaleFactor(
                                                    context),
                                            " YER",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: LigthColor.whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 200, 218, 233),
        onPressed: () {
          DialogBuild(context);
        },
        tooltip: 'أشحن المحفظة',
        child: Image.asset(
          "assets/images/addmony.png",
          height: 40,
        ),
      ),
    );
  }

  Future DialogBuild(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "أضف رصيد للمحفظة",
                style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 20,
                    color: LigthColor.maingreencolor),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SizedBox(
                      height: 55,
                      child: InputEdit(
                        readonly: false,
                        hint: " رصيد المحفظة ",
                        controller: _bank_balanceController,
                        texttype: TextInputType.number,
                        validator: (p0) {
                          if (p0 == "") {
                            return "أدخل رصيد المحفظة ";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LigthColor.buttons,
                  ),
                  onPressed: () async {
                    await _updateWaller(_bank_balanceController.text);
                    if (_success == false) {
                      ShowMasseg.ShowToastMasseg(
                          "لم تتم الاضافة", LigthColor.favorColor);
                    } else {
                      ShowMasseg.ShowToastMasseg(
                          "تمت الاضافة بنجاح", LigthColor.maingreencolor);
                    }
                    _handRefresh();
                    Navigator.of(context).pop();
                    // exit(0);
                  },
                  child: Text(
                    "اضافة",
                    style: TextStyle(color: LigthColor.whiteColor),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LigthColor.buttons,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "الغاء",
                    style: TextStyle(color: LigthColor.whiteColor),
                  ))
            ],
          );
        });
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

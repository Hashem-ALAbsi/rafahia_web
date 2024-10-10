import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/api/helper/api_orders.dart';
import 'package:rafahia_web/uitles/colors.dart';

import '../../../api/apiurl.dart';

import '../../../models/datausers/internalstorage.dart';
import '../../../widget/flutter_toast.dart';
import '../../../widget/wiget_regester_login.dart';
import 'my_wallet.dart';

class Create_Wallet extends StatefulWidget {
  int id;
  Create_Wallet({super.key, required this.id});

  @override
  State<Create_Wallet> createState() => _Create_WalletState();
}

class _Create_WalletState extends State<Create_Wallet> {
  final TextEditingController _bank_balanceController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  bool? _success;
  bool didDispose = false;

  String _stutes = ' اضغط على الزر ';

  Future<void> _createWaller(String email, String value) async {
    _success = await Apiorder.createWaller(email, value);
    setState(() {
      didDispose = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    didDispose = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: LigthColor.maingreencolor,
        title: Text(
          textScaleFactor: ScaleSize.textScaleFactor(context),
          "  إنشاء محفظة",
          style: TextStyle(
            color: LigthColor.whiteColor,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {
            setState(() {
              didDispose = false;
            });
            await _createWaller(
                _emailController.text, _bank_balanceController.text);
            if (_success == false) {
              AwesomeDialog(
                titleTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 15),
                descTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 15),
                buttonsTextStyle: TextStyle(
                    fontFamily: "Rubik", color: LigthColor.whiteColor),
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'خطأ',
                desc: 'لم يتم انشاء المحفضة',
              ).show();
            } else {
              AwesomeDialog(
                  titleTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 15),
                  descTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 15),
                  buttonsTextStyle: TextStyle(
                      fontFamily: "Rubik", color: LigthColor.whiteColor),
                  btnOkText: "تم",
                  btnOkColor: LigthColor.maingreencolor,
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'نجح',
                  desc: 'تم انشاء المحفضة بنجاح',
                  // btnCancelOnPress: () {
                  //   Navigator.pop();
                  // },
                  btnOkOnPress: () {
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new My_Wallet(
                                  id: widget.id,
                                )));
                  }).show();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 15),
            child: Text(
              "حفظ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: LigthColor.whiteColor,
                  fontSize: 20),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.angleRight,
              color: LigthColor.whiteColor,
              size: 25,
            ),
          ),
        ],
      ),
      body: didDispose == false
          ? Center(
              child: LottieBuilder.asset(
                'assets/animation/loading_butifol.json',
                // height: 180,
                // width: 180,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        color: LigthColor.whiteColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              "قم بإنشاء محفظتك لتتمتع بمميزات رفاهية",
                              style: TextStyle(
                                  fontSize: 16, color: LigthColor.graycolor),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FaIcon(
                              FontAwesomeIcons.person,
                              color: LigthColor.subwhiteColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
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
                          SizedBox(
                            height: 10,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: SizedBox(
                              height: 55,
                              child: InputEdit(
                                readonly: false,
                                hint: "  الإيميل ",
                                controller: _emailController,
                                texttype: TextInputType.text,
                                validator: (p0) {
                                  if (p0 == "") {
                                    return "أدخل  الايميل  ";
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
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

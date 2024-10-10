import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;

import '../../../api/helper/api_userclient.dart';
import '../../../models/datausers/data_user_model.dart';
import '../../../uitles/colors.dart';
import '../../../widget/wiget_regester_login.dart';

class UpdatUser extends StatefulWidget {
  final int? id;
  const UpdatUser({super.key, required this.id});

  @override
  State<UpdatUser> createState() => _UpdatUserState();
}

class _UpdatUserState extends State<UpdatUser> {
  int? clientid;
  var userdata;

  late bool _success;
  bool? _isupdate;
  bool didDispose = false;
  // bool didDispose = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _stutes = ' اضغط على الزر ';
  bool isAuthenticated = false;

  String? selectedgendersexually;
  String? selectedgendermaritalstste;
  String? selectedgendercountries;

  late List<Countries>? countries = [];
  late List<Sexually>? sexually = [];
  late List<MaritalState>? maritalstste = [];

  Future<void> _fetchUserDetail(int? id) async {
    userdata = await ApiUserClient.fetchUserDetails(id);
    setState(() {
      _firstNameController.text = userdata['firstName'].toString();
      _lastNameController.text = userdata['laststName'].toString();
      _phoneController.text = userdata['phoneNumbar'].toString();
      _usernameController.text = userdata['userName'].toString();
      _ageController.text = userdata['age'].toString();
      // _countryIdController.text= userdata['countryId'];
      // _maritalStateIdController.text= userdata['marital_StateId'];
      // _sexuallyIdController.text= userdata['sexuallyId'];
      selectedgendercountries = userdata['countryId'].toString();
      selectedgendermaritalstste = userdata['marital_StateId'].toString();
      selectedgendersexually = userdata['sexuallyId'].toString();
      clientid = id;
      // _fetchcountries();
      // _fetchsexually();
      // _fetchmaritalstste();
      //print(hotel['name']);
      didDispose = true;
    });
  }

  Future<void> _fetchcountries() async {
    countries = await ApiUserClient.fetchcountries();
    setState(() {});
  }

  Future<void> _fetchsexually() async {
    sexually = await ApiUserClient.fetchsexually();
    // setState(() {});
  }

  Future<void> _fetchmaritalstste() async {
    maritalstste = await ApiUserClient.fetchmaritalstste();
    // setState(() {});
  }

  Future<void> _updateUser(Map<String, dynamic> userData, int? id) async {
    _isupdate = await ApiUserClient.updateUser(userData, id);
    // // setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchUserDetail(widget.id);
    _fetchcountries();
    _fetchsexually();
    _fetchmaritalstste();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LigthColor.whiteColor,
        appBar: AppBar(
          toolbarHeight: 88,
          backgroundColor: LigthColor.maingreencolor,
          elevation: 0,
          title: Text(
              textScaleFactor: ScaleSize.textScaleFactor(context),
              "حسابي",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: LigthColor.whiteColor,
                  fontFamily: "Rubik")),
          centerTitle: true,
          leading: InkWell(
              onTap: () async {
                setState(() {
                  // didDispose = false;
                });
                final userData = {
                  'firstName': _firstNameController.text,
                  'lastName': _lastNameController.text,
                  //'email': _emailController.text,
                  'phoneNumber': _phoneController.text,
                  'sexuallyId': selectedgendersexually,
                  'countryId': selectedgendercountries,
                  'age': _ageController.text,
                  'marital_StateId': selectedgendermaritalstste,
                  'username': _usernameController.text,
                  //'password': _passwordController.text,
                };
                // Convert phone to integer before sending
                userData['sexuallyId'] =
                    int.parse(userData['sexuallyId']!).toString();
                userData['age'] = int.parse(userData['age']!).toString();
                userData['marital_StateId'] =
                    int.parse(userData['marital_StateId']!).toString();
                userData['countryId'] =
                    int.parse(userData['countryId']!).toString();
                await _updateUser(userData, widget.id);
                if (_isupdate == false) {
                  AwesomeDialog(
                    titleTextStyle:
                        TextStyle(fontFamily: "Rubik", fontSize: 15),
                    descTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 16),
                    buttonsTextStyle: TextStyle(
                        fontFamily: "Rubik", color: LigthColor.whiteColor),
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'خطأ',
                    desc: 'تأكد من إدخال جميع البيانات',
                  ).show();
                } else {
                  AwesomeDialog(
                    titleTextStyle:
                        TextStyle(fontFamily: "Rubik", fontSize: 15),
                    descTextStyle: TextStyle(fontFamily: "Rubik", fontSize: 16),
                    buttonsTextStyle: TextStyle(
                        fontFamily: "Rubik", color: LigthColor.whiteColor),
                    btnOkText: "تم",

                    btnOkColor: LigthColor.maingreencolor,
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'نجح',
                    desc: 'تمت العملية بنجاح',
                    // btnCancelOnPress: () {
                    //   Navigator.pop();
                    // },
                    btnOkOnPress: () {
                      // setState(() {
                      //   _fetchUserDetails(clientid);
                      // });
                      // Navigator.pushReplacement(
                      //       context,
                      //       new MaterialPageRoute(
                      //           builder: (context) => new Account_screen()));

                      Navigator.of(context).pop();
                    },
                  ).show();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 30),
                child: Text(
                  "حفظ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: LigthColor.whiteColor,
                      fontSize: 20,
                      fontFamily: "Rubik"),
                ),
              )),
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
            : SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            "المعلومات الشخصية",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Rubik",
                                color: LigthColor.massegeColor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: LigthColor.bordservice,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                " عدل بياناتك لتحصل على تجربة مثالية ",
                                style: TextStyle(
                                    fontFamily: "Rubik",
                                    fontSize: 12,
                                    color: LigthColor.caleder),
                                textDirection: TextDirection.rtl,
                              ),
                              Image.asset("assets/images/updateaccount.png",
                                  height: 29)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 55,
                            child: InputEdit(
                              readonly: false,
                              hint: "الاسم الاول",
                              //onChanged:,
                              controller: _firstNameController,

                              texttype: TextInputType.text,
                              validator: (p0) {
                                if (p0 == "") {
                                  return "ادخل الاسم الاول";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 55,
                            child: InputEdit(
                              readonly: false,
                              hint: "الاسم الاخير",
                              controller: _lastNameController,
                              texttype: TextInputType.text,
                              validator: (p0) {
                                if (p0 == "") {
                                  return "ادخل  اللقب";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 55,
                            child: InputEdit(
                              readonly: false,
                              hint: "رقم الهاتف ",
                              controller: _phoneController,
                              texttype: TextInputType.number,
                              validator: (p0) {
                                if (p0 == "") {
                                  return "ادخل رقم الهاتف";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 55,
                            child: InputEdit(
                              readonly: true,
                              hint: "اسم المستخدم ",
                              controller: _usernameController,
                              texttype: TextInputType.text,
                              validator: (p0) {
                                if (p0 == "") {
                                  return "ادخل اسم المستخدم";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 55,
                            child: InputEdit(
                              readonly: false,
                              hint: "العمر  ",
                              controller: _ageController,
                              texttype: TextInputType.text,
                              validator: (p0) {
                                if (p0 == "") {
                                  return "ادخل العمر ";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            // await _fetchmaritalstste();
                            await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "اختر حالة الاجتماعية",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: LigthColor.supmaincolor,
                                            ),
                                          ),
                                          ...maritalstste!.map((item) {
                                            return RadioListTile<String>(
                                              title: Text(item.name.toString()),
                                              value: item.id.toString(),
                                              groupValue:
                                                  selectedgendermaritalstste,
                                              activeColor: LigthColor.caleder,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedgendermaritalstste =
                                                      value;
                                                  Navigator.pop(context);
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ]);
                                  },
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: LigthColor.caleder),
                              borderRadius: BorderRadius.circular(10),
                              color: LigthColor.whiteColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 20,
                                  color: LigthColor.supmaincolor,
                                ),
                                Text(
                                  " الحالة الاجتماعية",
                                  style: TextStyle(
                                      color: LigthColor.supmaincolor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            // await _fetchsexually();
                            await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "اختر الجنس",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: LigthColor.supmaincolor,
                                            ),
                                          ),
                                          ...sexually!.map((item) {
                                            return RadioListTile<String>(
                                              title: Text(item.name.toString()),
                                              value: item.id.toString(),
                                              groupValue:
                                                  selectedgendersexually,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedgendersexually =
                                                      value;
                                                  Navigator.pop(context);
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ]);
                                  },
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LigthColor.caleder,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 20,
                                  color: LigthColor.supmaincolor,
                                ),
                                Text(
                                  " الجنس",
                                  style: TextStyle(
                                      color: LigthColor.supmaincolor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            // await _fetchcountries();
                            await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return SingleChildScrollView(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "اخترالمدينة ",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: LigthColor.supmaincolor,
                                              ),
                                            ),
                                            ...countries!.map((item) {
                                              return RadioListTile<String>(
                                                title:
                                                    Text(item.name.toString()),
                                                value: item.id.toString(),
                                                groupValue:
                                                    selectedgendercountries,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedgendercountries =
                                                        value;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              );
                                            }).toList(),
                                            // ),
                                          ]),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LigthColor.caleder,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: LigthColor.whiteColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 20,
                                  color: LigthColor.supmaincolor,
                                ),
                                Text(
                                  " مكان الاقامة ",
                                  style: TextStyle(
                                      color: LigthColor.supmaincolor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ));
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   didDispose = false;
  // }
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

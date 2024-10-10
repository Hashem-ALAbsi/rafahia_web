import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rafahia_web/api/helper/api_userclient.dart';

import '../../../uitles/colors.dart';

class Changepass extends StatefulWidget {
  int id;
  Changepass({super.key, required this.id});

  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  TextEditingController _currentpass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  TextEditingController _confirmNewPass = TextEditingController();

  var data;
  bool? _succes;
  bool isAuthenticated = false;
  String _stutes = "";

  Future<void> _changepass(Map<String, dynamic> userData, int? id) async {
    _succes = await ApiUserClient.changepass(userData, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 375,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                      fontFamily: "Rubik",
                      color: LigthColor.maingreencolor,
                    ),
                    maxLength: 50,
                    autofocus: true,
                    controller: _currentpass,
                    cursorColor: LigthColor.maingreencolor,
                    autocorrect: true,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 65, 133, 189),
                        )),
                        hintText: 'ادخل كلمة المرور الحالية',
                        hintStyle: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 12,
                            color: LigthColor.graycolor)),
                  ),
                  TextField(
                    style: TextStyle(
                      fontFamily: "Rubik",
                      color: LigthColor.maingreencolor,
                    ),
                    maxLength: 50,
                    autofocus: true,
                    controller: _newPass,
                    cursorColor: LigthColor.maingreencolor,
                    autocorrect: true,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: LigthColor.supmaincolor)),
                        hintText: 'ادخل كلمة المرور الجديده',
                        hintStyle: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 12,
                            color: LigthColor.graycolor)),
                  ),
                  TextField(
                    style: TextStyle(
                        fontFamily: "Rubik", color: LigthColor.supmaincolor),
                    maxLength: 50,
                    autofocus: true,
                    controller: _confirmNewPass,
                    cursorColor: LigthColor.maingreencolor,
                    autocorrect: true,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: LigthColor.supmaincolor)),
                        hintText: 'ادخل تأكيد كلمة المرور الجديده',
                        hintStyle: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 12,
                            color: LigthColor.graycolor)),
                  ),
                  InkWell(
                    onTap: () async {
                      final orderData = {
                        'currentpass': _currentpass.text,
                        'newPass': _newPass.text,
                        'confirmNewPass': _confirmNewPass.text
                      };
                      await _changepass(orderData, widget.id);

                      if (_succes == false) {
                        AwesomeDialog(
                          width: 500,
                          titleTextStyle:
                              TextStyle(fontFamily: "Rubik", fontSize: 15),
                          descTextStyle:
                              TextStyle(fontFamily: "Rubik", fontSize: 16),
                          buttonsTextStyle: TextStyle(
                              fontFamily: "Rubik",
                              color: LigthColor.whiteColor),
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: _stutes.toString(),
                        ).show();
                      } else {
                        AwesomeDialog(
                            width: 500,
                            titleTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 15),
                            descTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 16),
                            buttonsTextStyle: TextStyle(
                                fontFamily: "Rubik",
                                color: LigthColor.whiteColor),
                            btnOkText: "تم",
                            btnOkColor: LigthColor.maingreencolor,
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'نجح',
                            desc: _stutes.toString(),
                            // btnCancelOnPress: () {
                            //   Navigator.pop();
                            // },
                            btnOkOnPress: () {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     new MaterialPageRoute(
                              //         builder: (context) => new LoginPage()));
                            }).show();
                      }
                    },
                    child: Center(
                      child: Container(
                        child: Text(
                          'تغيير',
                          style: TextStyle(
                              fontFamily: "Rubik",
                              fontSize: 18,
                              color: LigthColor.buttons),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

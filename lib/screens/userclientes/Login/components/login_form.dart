import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../api/helper/api_userclient.dart';
import '../../../../uitles/colors.dart';
import '../../../../widget/wiget_regester_login.dart';
import '../../../nav_bar.dart';
import '../../Signup/signup_screen.dart';
import 'already_have_an_account_acheck.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  var data;
  late String mm = "";
  bool isAuthenticated = false;
  bool didDispose = true;
  late bool? _success;
  String _stutes = ' اضغط على الزر ';

  Future<void> LoginUserWeb(BuildContext context) async {
    _success = await ApiUserClient.Loginuser(
        emailcontroller.text, passcontroller.text);
    setState(() {
      didDispose = true;
      // if (_success == false) {
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formstate,
        child: didDispose == false
            ? Center(
                child: LottieBuilder.asset(
                  'assets/animation/loading_butifol.json',
                  // height: 180,
                  // width: 180,
                ),
              )
            : Column(
                children: [
                  InputFild(
                    texttype: TextInputType.text,
                    icon: Icons.email,
                    hint: " ادخل الايميل ",
                    controller: emailcontroller,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل الايميل رجاءَ";
                      }
                    },
                  ),
                  Inputpass(
                    icon: Icons.key,
                    hint: "ادخل كلمة المرور  ",
                    controller: passcontroller,
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (formstate.currentState!.validate()) {
                        setState(() {
                          didDispose = false;
                        });
                        await LoginUserWeb(context);
                        if (_success == false) {
                          AwesomeDialog(
                            titleTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 15),
                            descTextStyle:
                                TextStyle(fontFamily: "Rubik", fontSize: 14),
                            buttonsTextStyle: TextStyle(
                                fontFamily: "Rubik",
                                color: LigthColor.whiteColor),
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'خطأ',
                            desc: 'اسم المستخدم او كلمة المرور غلط',
                          ).show();
                        } else {
                          AwesomeDialog(
                              titleTextStyle:
                                  TextStyle(fontFamily: "Rubik", fontSize: 15),
                              descTextStyle:
                                  TextStyle(fontFamily: "Rubik", fontSize: 15),
                              buttonsTextStyle: TextStyle(
                                  fontFamily: "Rubik",
                                  color: LigthColor.whiteColor),
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
                                // Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Nav_barr()));
                              }).show();
                        }
                      } else {
                        print("Not Valid");
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 59, 89, 114),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Signup()));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "لا تملك حساب في رفاهية ؟ ",
                            ),
                            TextSpan(
                                text: "انشاء حساب",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 87, 124, 163),
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}

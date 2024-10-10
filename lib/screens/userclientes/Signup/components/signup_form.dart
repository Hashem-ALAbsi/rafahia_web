import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/api/helper/api_userclient.dart';

import '../../../../models/datausers/data_user_model.dart';
import '../../../../uitles/colors.dart';
import '../../../../widget/wiget_regester_login.dart';
import '../../Login/components/already_have_an_account_acheck.dart';
import '../../Login/login_screen.dart';

class Signupform extends StatefulWidget {
  const Signupform({super.key});

  @override
  State<Signupform> createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
// late bool _selectedValue = false;
  late bool? _success;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _maritalStateIdController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryIdController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexuallyIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

//final String apiUrl = 'http://192.168.1.102:7094/api/Auth/registerClient';
  String _stutes = ' اضغط على الزر ';
  bool isAuthenticated = false;
  bool didDispose = true;
//late GetSexually _selectedOption;
  String? selectedgendersexually = "1";
  String? selectedgendermaritalstste = "1";
  String? selectedgendercountries = "1";

  late List<Countries>? countries = [];
  late List<Sexually>? sexually = [];
  late List<MaritalState>? maritalstste = [];

  Future<void> _registerUser(Map<String, dynamic> userData) async {
    _success = await ApiUserClient.registerUser(userData);
    setState(() {
      didDispose = true;
    });
  }

  Future<void> _fetchcountries() async {
    countries = await ApiUserClient.fetchcountries();
    setState(() {});
  }

  Future<void> _fetchsexually() async {
    sexually = await ApiUserClient.fetchsexually();
    setState(() {});
  }

  Future<void> _fetchmaritalstste() async {
    maritalstste = await ApiUserClient.fetchmaritalstste();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchcountries();
    _fetchsexually();
    _fetchmaritalstste();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formstate,
        child: didDispose == false
            ? Center(
                child: LottieBuilder.asset(
                  'assets/animation/loading_butifol.json',
                  height: 200,
                  width: 200,
                ),
              )
            : Column(
                children: [
                  InputFild(
                    texttype: TextInputType.name,
                    hint: " الاسم الاول",
                    controller: _firstNameController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل الاسم الاول";
                      }
                    },
                  ),
                  InputFild(
                    texttype: TextInputType.name,
                    hint: " الاسم الاخير",
                    controller: _lastNameController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل اللقب";
                      }
                    },
                  ),
                  InputFild(
                    texttype: TextInputType.emailAddress,
                    hint: "الايميل",
                    controller: _emailController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل الايميل رجاءً";
                      }
                    },
                  ),
                  InputFild(
                    texttype: TextInputType.number,
                    hint: "رقم الهاتف",
                    controller: _phoneController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل رقم الهاتف";
                      }
                    },
                    // This ensures only numbers can be entered
                  ),
                  InputFild(
                    texttype: TextInputType.name,
                    hint: "اسم المستخدم",
                    controller: _usernameController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل اسم المستخدم";
                      }
                    },
                  ),
                  Inputpass(
                    controller: _passwordController,
                    hint: " كلمة المرور",
                  ),
                  InputFild(
                    texttype: TextInputType.number,
                    hint: "العمر",
                    controller: _ageController,
                    validator: (p0) {
                      if (p0 == "") {
                        return "ادخل العمر";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      // setState(() {
                      //   _selectedValue = false;
                      // });
                      _fetchmaritalstste();
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return
                                  // _selectedValue == false
                                  //     ? Center(
                                  //         child:
                                  //             CircularProgressIndicator())
                                  //     :
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                    Text(
                                      " اختر حالة الاجتماعية",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    ...maritalstste!.map((item) {
                                      return RadioListTile<String>(
                                        title: Text(item.name.toString()),
                                        value: item.id.toString(),
                                        groupValue:
                                            selectedgendermaritalstste ?? "1",
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedgendermaritalstste = value;
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
                      width: 330,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: LigthColor.maingreencolor,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 200, 219, 236),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        " الحالة الاجتماعية",
                        style: TextStyle(
                          color: LigthColor.caleder,
                          fontSize: 14,
                          fontFamily: "Rubik",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      // setState(() {
                      //   _selectedValue = false;
                      // });
                      _fetchsexually();
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return
                                  // _selectedValue == false
                                  //     ? Center(
                                  //         child:
                                  //             CircularProgressIndicator())
                                  //     :
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                    Text(
                                      "اختر الجنس",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Rubik",
                                      ),
                                    ),
                                    ...sexually!.map((item) {
                                      return RadioListTile<String>(
                                        title: Text(item.name.toString()),
                                        value: item.id.toString(),
                                        groupValue:
                                            selectedgendersexually ?? "1",
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedgendersexually = value;
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
                      width: 330,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: LigthColor.maingreencolor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 200, 219, 236)),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        " الجنس",
                        style: TextStyle(
                          color: LigthColor.caleder,
                          fontSize: 14,
                          fontFamily: "Rubik",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      // setState(() {
                      //   _selectedValue = false;
                      // });
                      _fetchcountries();
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return
                                  // _selectedValue == false
                                  //     ? Center(
                                  //         child:
                                  //             CircularProgressIndicator())
                                  //     :
                                  SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "اخترالمدينة ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Rubik",
                                        ),
                                      ),
                                      ...countries!.map((item) {
                                        return RadioListTile<String>(
                                          title: Text(item.name.toString()),
                                          value: item.id.toString(),
                                          groupValue:
                                              selectedgendercountries ?? "1",
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedgendercountries =
                                                  value ?? "1";
                                              Navigator.pop(context);
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ]),
                              );
                            },
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 330,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: LigthColor.maingreencolor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 200, 219, 236)),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        " مكان الاقامة ",
                        style: TextStyle(
                          color: LigthColor.caleder,
                          fontSize: 14,
                          fontFamily: "Rubik",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (formstate.currentState!.validate()) {
                        setState(() {
                          didDispose = false;
                        });
                        final userData = {
                          'firstName': _firstNameController.text,
                          'lastName': _lastNameController.text,
                          'email': _emailController.text,
                          'phoneNumber': _phoneController.text,
                          'sexuallyId': selectedgendersexually,
                          'countryId': selectedgendercountries,
                          'age': _ageController.text,
                          'marital_StateId': selectedgendermaritalstste,
                          'username': _usernameController.text,
                          'password': _passwordController.text,
                        };
                        // Convert phone to integer before sending
                        userData['sexuallyId'] =
                            int.parse(userData['sexuallyId']!).toString();
                        userData['age'] =
                            int.parse(userData['age']!).toString();
                        userData['marital_StateId'] =
                            int.parse(userData['marital_StateId']!).toString();
                        userData['countryId'] =
                            int.parse(userData['countryId']!).toString();
                        await _registerUser(userData);
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
                            desc: 'اسم المستخدم او الايميل موجود مسبقا',
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginScreenn();
                                    },
                                  ),
                                );
                                // Navigator.of(context).pop();
                                // Navigator.pushReplacement(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => new LoginPage()));
                              }).show();
                        }
                      } else {
                        print("Not Valit");
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 59, 89, 114),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      alignment: Alignment.center,
                      child: Text(
                        " انشاء حساب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Rubik",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreenn()));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "أمتلك حساب بالفعل",
                            ),
                            TextSpan(
                                text: " تسجيل الدخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 87, 124, 163),
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ));
  }
}

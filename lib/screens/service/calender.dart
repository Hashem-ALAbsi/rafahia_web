import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafahia_web/api/helper/api_orders.dart';
import 'package:rafahia_web/screens/userclientes/components/wiget_regester_login.dart';

import '../../api/apiurl.dart';
import 'package:http/http.dart' as http;
import '../../models/datausers/internalstorage.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import 'class_date.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

final today = DateUtils.dateOnly(DateTime.now());

class Date_Piker extends StatefulWidget {
  Date_Piker({
    this.id,
    required this.price,
    required this.servicename,
    Key? key,
    Key? ket,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;
  int? id;
  double price;
  String servicename;
  @override
  State<Date_Piker> createState() => _Date_PikerState();
}

class _Date_PikerState extends State<Date_Piker> {
  var checkid;
  var service;
  var data;
  BaseUrl _baseUrl = new BaseUrl();
  CreateOrderCompany _createOrderCompany = new CreateOrderCompany();
  bool didDispose = false;
  late bool _succes;
  String _stutes = "";
  bool isAuthenticated = false;
  final TextEditingController _pepolenumperController = TextEditingController();
  final TextEditingController _emiallController = TextEditingController();
  final TextEditingController _walletController = TextEditingController();

  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2024, 5, 1),
    DateTime(2024, 5, 5),
  ];
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [
    DateTime(today.year, today.month, 1),
    DateTime(today.year, today.month, 5),
    DateTime(today.year, today.month, 14),
    DateTime(today.year, today.month, 17),
    DateTime(today.year, today.month, 25),
  ];
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(1999, 5, 6),
    DateTime(1999, 5, 21),
  ];

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];
  // DateTime _dateTimein = DateTime();
  DateTime? arrive;
  DateTime? leave;
  // late Datetimeorder datetimeorder =
  //     Datetimeorder();
  // Future<void> createorder(Map<String, dynamic> orderData) async {
  //   //checkid = service['clientId'];
  //   //var idclient = await FileOperations.readFile();
  //   // String url = "http://192.168.1.102:7094/api/Auth/ClientLogin/${idclient}}";
  //   //String url = "http://192.168.1.102:7094/api/Auth/ClientLogin";
  //   //print("//////");
  //   // int clid = checkid;
  //   // int? iid = widget.id;
  //   // const dateToSend = new Date();
  //   // DateTime tin = orderData['time_in'];
  //   // DateTime tout = DateTime.now();
  //   // print(tin);
  //   // print(iid);
  //   // print(orderData);
  //   try {
  //     var response = await http.post(
  //       Uri.parse(
  //           "${_baseUrl.baseurl.trim()}${_createOrderCompany.url.trim()}${checkid}/${widget.id}"),
  //       headers: <String, String>{
  //         // 'Content-Type': 'multipart/form-data',
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(orderData),
  //       // body: (orderData),
  //       // body: json.encode({"time_in": arrive.toString(), "time_out": leave.toString()})
  //       // body: jsonEncode({"time_in": arrive.toString(), "time_out": leave.toString()}),
  //     );
  //     //print(response);
  //     //;charset=UTF-8
  //     // headers: {"Content-type": "application/json"},
  //     // body: json.encode({"time_in": arrive, "time_out": leave}));
  //     // {"time_in": "${ctimein}", "time_out": "${ctimeout}"}

  //     //print(response.body);
  //     //("/////////////////////////////");

  //     print(response.statusCode);

  //     setState(() {
  //       if (response.statusCode == 200) {
  //         data = json.decode(response.body);
  //         isAuthenticated = data['isAuthenticated'];
  //         if (!isAuthenticated) {
  //           // print(data['message']);
  //           _succes = false;
  //           ShowMasseg.ShowToastMasseg(
  //               "${data['message']}", LigthColor.favorColor);
  //         } else {
  //           _succes = true;
  //           ShowMasseg.ShowToastMasseg(
  //               "${data['message']}", LigthColor.maingreencolor);
  //           // String userid = data['id'].toString();
  //           //await FileOperations.writeFile(userid.toString());
  //           //print(data['message']);
  //           //print(userid);
  //           // Navigator.push(context,
  //           //     new MaterialPageRoute(builder: (context) => new Home_screen()));
  //           // _stutes = "Success";

  //           // print(_stutes);
  //         }

  //         // SharedPreferences pref = await SharedPreerences.getInstance();
  //         //await pref.setString("id", 'id');

  //         // Handle successful response
  //       } else if (response.statusCode == 400) {
  //         //print(data['message']);
  //         // _stutes = "Bad Request";
  //         _stutes = "التاريخ خطأ";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 401) {
  //         _stutes = "Unauthorized";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 403) {
  //         _stutes = "Forbidden : 403";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 404) {
  //         _stutes = "Not Found";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 500) {
  //         _stutes = "Internal Server Error";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg(
  //             "لايوجد اتصال بالانترنت", LigthColor.favorColor);
  //       } else {
  //         _stutes = "Unknown Error ${response.statusCode}";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg(
  //             "لايوجد اتصال بالانترنت", LigthColor.favorColor);
  //       }
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _stutes = "Error : Couldn't connect to server .";
  //       //_success = false;
  //     });
  //   }
  // }

  // Future<void> getFile(Map<String, dynamic> orderData) async {
  //   //_refrish == true;
  //   checkid = await FileOperations.readFile();
  //   if (checkid == null || checkid == 0) {
  //     ShowMasseg.ShowToastMasseg("!يرجى تسجيل دخولك اولا", LigthColor.delete);
  //     // didDispose = true;
  //     //_stutes = false;
  //     //return checkid;
  //     // Navigator.pushReplacement(context,
  //     //     new MaterialPageRoute(builder: (context) => new No_Account()));
  //   } else {
  //     if (_bywallet == false) {
  //       await createorder(orderData);
  //     } else {
  //       await bookingbywallet(orderData);
  //     }
  //     //print("$arrive ---- $leave");
  //     //_stutes = true;
  //     //Navigator.pop(context);
  //     //return checkid;
  //   }
  // }

  // TextEditingController walletnumbercontroller = TextEditingController();
  // CreateOrderByWallet _orderByWallet = CreateOrderByWallet();
  // bool _bywallet = false;

  // Future<void> bookingbywallet(Map<String, dynamic> orderData) async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse(
  //           "${_baseUrl.baseurl.trim()}${_orderByWallet.url.trim()}$checkid/${widget.id}"),
  //       headers: <String, String>{
  //         // 'Content-Type': 'multipart/form-data',
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(orderData),
  //     );

  //     print(response.statusCode);

  //     setState(() {
  //       if (response.statusCode == 200) {
  //         data = json.decode(response.body);
  //         isAuthenticated = data['isAuthenticated'];
  //         if (!isAuthenticated) {
  //           // print(data['message']);
  //           ShowMasseg.ShowToastMasseg(
  //               "${data['message'].toString()}", LigthColor.favorColor);
  //           _succes = false;
  //         } else {
  //           _succes = true;
  //           ShowMasseg.ShowToastMasseg(
  //               "${data['message'].toString()}", LigthColor.maingreencolor);
  //           // String userid = data['id'].toString();
  //           //await FileOperations.writeFile(userid.toString());
  //           //print(data['message']);
  //           //print(userid);
  //           // Navigator.push(context,
  //           //     new MaterialPageRoute(builder: (context) => new Home_screen()));
  //           // _stutes = "Success";

  //           // print(_stutes);
  //         }

  //         // SharedPreferences pref = await SharedPreerences.getInstance();
  //         //await pref.setString("id", 'id');

  //         // Handle successful response
  //       } else if (response.statusCode == 400) {
  //         //print(data['message']);
  //         // _stutes = "Bad Request";
  //         _stutes = "التاريخ خطأ";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //         //ShowMasseg.ShowToastMasseg("خطأ", Colors.red);
  //       } else if (response.statusCode == 401) {
  //         _stutes = "Unauthorized";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 403) {
  //         _stutes = "Forbidden : 403";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 404) {
  //         _stutes = "Not Found";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg("$_stutes", LigthColor.favorColor);
  //       } else if (response.statusCode == 500) {
  //         _stutes = "Internal Server Error";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg(
  //             "لايوجد اتصال بالانترنت", LigthColor.favorColor);
  //       } else {
  //         // ShowMasseg.ShowToastMasseg("${data['message'].toString()}", Colors.red);
  //         _stutes = "Unknown Error ${response.statusCode}";
  //         _succes = false;
  //         ShowMasseg.ShowToastMasseg(
  //             "لايوجد اتصال بالانترنت", LigthColor.favorColor);
  //       }
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _stutes = "Error : Couldn't connect to server .";
  //       //_success = false;
  //     });
  //     // ShowMasseg.ShowToastMasseg("${data['message'].toString()}", Colors.red);
  //   }
  // }

  late bool _success = false;
  late bool? isAuthenticat;
  Future<void> createorder(Map<String, dynamic> orderData) async {
    // print(widget.id);
    isAuthenticat = await Apiorder.createorder(orderData, widget.id?.toInt());
    setState(() {
      if (isAuthenticat == false) {
        _succes = false;
      } else {
        _succes = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            width: 375,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(
                              color: Color.fromARGB(255, 192, 184, 137))),
                      child: Text(
                        "${widget.servicename}",
                        style: TextStyle(
                          fontFamily: "Rubik",
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(
                              color: Color.fromARGB(255, 192, 184, 137))),
                      child: Text(
                        arrive?.toIso8601String() ?? "تاريخ الوصول",
                        style: TextStyle(
                          fontFamily: "Rubik",
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.all(
                              color: Color.fromARGB(255, 192, 184, 137))),
                      child: Text(leave?.toIso8601String() ?? "تاريخ المغادرة",
                          style: TextStyle(
                            fontFamily: "Rubik",
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.all(
                              color: Color.fromARGB(255, 192, 184, 137))),
                      child: Text("السعر الاجمالي : ${widget.price}",
                          style: TextStyle(
                            fontFamily: "Rubik",
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 33, 91, 138),
                      ),
                      //color: Color.fromARGB(255, 33, 91, 138),
                      // padding: const EdgeInsets.all(8),
                      // padding: const EdgeInsets.only(left: 20, right: 20),
                      child: InputFildpepolenum(
                        texttype: TextInputType.number,
                        hint: " الايميل ",
                        controller: _emiallController,
                        validator: (p0) {
                          if (p0 == "") {
                            return " ادخل الايميل ";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 33, 91, 138),
                      ),
                      //color: Color.fromARGB(255, 33, 91, 138),
                      // padding: const EdgeInsets.all(8),
                      // padding: const EdgeInsets.only(left: 20, right: 20),
                      child: InputFildpepolenum(
                        texttype: TextInputType.number,
                        hint: "المحفظة",
                        controller: _walletController,
                        validator: (p0) {
                          if (p0 == "") {
                            return "ادخل رقم المحفظة ";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 33, 91, 138),
                      ),
                      //color: Color.fromARGB(255, 33, 91, 138),
                      // padding: const EdgeInsets.all(8),
                      // padding: const EdgeInsets.only(left: 20, right: 20),
                      child: InputFildpepolenum(
                        texttype: TextInputType.number,
                        hint: "عدد الاشخاص",
                        controller: _pepolenumperController,
                        validator: (p0) {
                          if (p0 == "") {
                            return "ادخل عدد الاشخاص ";
                          }
                        },
                      ),
                    ),
                  ),
                  _buildCalendarDialogButton(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 33, 91, 138))),
                          onPressed: () async {
                            // setState(() {
                            //         _bywallet = false;
                            //         didDispose = false;
                            //       });
                            if (_pepolenumperController.text.isEmpty) {
                              _pepolenumperController.text = "1";
                            }
                            if (_walletController.text.isEmpty) {
                              _walletController.text = "";
                            }
                            final orderData = {
                              'time_in': arrive?.toIso8601String(),
                              'time_out': leave?.toIso8601String(),
                              'email': _emiallController.text,
                              'numberPeople': _pepolenumperController.text,
                              'cordNumber': _walletController.text,
                            };
                            orderData['numberPeople'] =
                                int.parse(orderData['numberPeople']!)
                                    .toString();

                            await createorder(orderData);

                            if (!_succes) {
                              AwesomeDialog(
                                titleTextStyle: TextStyle(
                                    fontFamily: "Rubik", fontSize: 15),
                                descTextStyle: TextStyle(
                                    fontFamily: "Rubik", fontSize: 16),
                                buttonsTextStyle: TextStyle(
                                    fontFamily: "Rubik",
                                    color: LigthColor.whiteColor),
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'خطأ',
                                desc: '!أدخل التاريخ الصحيح',
                              ).show();
                            } else {
                              AwesomeDialog(
                                  titleTextStyle: TextStyle(
                                      fontFamily: "Rubik", fontSize: 15),
                                  descTextStyle: TextStyle(
                                      fontFamily: "Rubik", fontSize: 16),
                                  buttonsTextStyle: TextStyle(
                                      fontFamily: "Rubik",
                                      color: LigthColor.whiteColor),
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'نجح',
                                  desc: 'تمت العملية بنجاح',
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
                          child: Text(
                            'حجز',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 33, 91, 138))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'الغاء',
                      style: TextStyle(color: Colors.white),
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

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);

    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: const Color.fromARGB(255, 33, 91, 138),
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Color.fromARGB(255, 33, 91, 138),
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Color.fromARGB(255, 176, 155, 41),
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;

        if (DateUtils.isSameDay(date, DateTime(2024, 1, 1))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () async {
                final values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: config,
                  dialogSize: const Size(325, 400),
                  borderRadius: BorderRadius.circular(15),
                  value: _dialogCalendarPickerValue,
                  dialogBackgroundColor: Colors.white,
                );
                if (values != null) {
                  // ignore: avoid_print
                  print(_getValueText(
                    config.calendarType,
                    values,
                  ));
                  setState(() {
                    _dialogCalendarPickerValue = values;
                    arrive = _dialogCalendarPickerValue[0];
                    leave = _dialogCalendarPickerValue[1];

                    // datetimeorder.dateTimein = _dialogCalendarPickerValue[0];
                    // datetimeorder.dateTimeout = _dialogCalendarPickerValue[1];
                    //Datetimeorder(dateTimein: _dialogCalendarPickerValue[0], dateTimeout: leave);
                  });
                  //print(datetimeorder.dateTimein);
                  print(leave);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 33, 91, 138),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "اختار التاريخ",
                    style: TextStyle(
                        fontSize: 18, color: LigthColor.maingreencolor),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

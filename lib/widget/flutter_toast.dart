// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rafahia_web/uitles/colors.dart';
// import 'package:rafahia_app_final_emy/uitles/colors.dart';

class ShowMasseg {
  static void ShowToastMasseg(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: color,
      textColor: LigthColor.whiteColor,
      // webBgColor: color,
      // fontSize: 16.0
      fontSize: 22,
    );

    // Fluttertoast.showToast(
    //       msg: msg,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: color,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
  }

  static void ShowToastMassegError(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: color,
        textColor: LigthColor.whiteColor,
        // webBgColor: color,
        // fontSize: 16.0
        fontSize: 22);
  }

  // static Future<void> Shownotification(String titlenof, String bodynof) async {
  //   await AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //     id: -1,
  //     channelKey: "basic_channel",
  //     title: titlenof,
  //     body: bodynof,
  //   ));
  // }
}

// void ShowAwesomeDiloge(BuildContext context,DialogType dialogType ){
//    AwesomeDialog(
//                     context: context,
//                     dialogType: DialogType.error,
//                     animType: AnimType.rightSlide,
//                     title: 'Error',
//                     desc: 'تأكد من ادخال جميع البيانات',
//                   ).show();
// }

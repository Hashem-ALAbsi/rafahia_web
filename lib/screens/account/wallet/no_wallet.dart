import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rafahia_web/screens/nav_bar.dart';

import '../../../uitles/colors.dart';
import '../../../widget/animations.dart';
import 'crate_wallet.dart';

class No_wallet extends StatefulWidget {
  int id;
   No_wallet({super.key,required this.id});

  @override
  State<No_wallet> createState() => _No_walletState();
}

class _No_walletState extends State<No_wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatingBg1(
        child: Dialog(
            elevation: 0.0,
            backgroundColor: LigthColor.whiteColor,
            child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: LigthColor.whiteColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: LigthColor.shadow,
                        blurRadius: 10.0,
                        offset: const Offset(5.0, 10.0)),
                  ],
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Stack(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Nav_barr()));
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  size: 30,
                                )),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40, left: 60, bottom: 20),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/nowallet.png'),
                                  height: 220,
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, bottom: 20),
                              child: Text('لا توجد لديك محفظة ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      fontFamily: "Rubik",
                                      color: LigthColor.favorColor)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            LigthColor.buttons),
                                  ),
                                  onPressed: ()
                                      // {
                                      //   Navigator.pushReplacement(
                                      //   context,
                                      //   new MaterialPageRoute(
                                      //       builder: (context) => new Create_Wallet()));
                                      // }
                                      =>
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              // builder: (context) => new Notiation_Screen())),
                                              builder: (context) =>
                                                  new Create_Wallet(id: widget.id,))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      " قم بإنشاء محفظتك  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Rubik",
                                          color: LigthColor.whiteColor,
                                          fontSize: 20),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ])
                    ]))),
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

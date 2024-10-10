import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafahia_web/screens/hotels/components/hotels_liste.dart';
import 'package:rafahia_web/uitles/colors.dart';

class Hotles_screen extends StatefulWidget {
  const Hotles_screen({super.key});

  @override
  State<Hotles_screen> createState() => _Hotles_screenState();
}

class _Hotles_screenState extends State<Hotles_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LigthColor.backscreen,
      appBar: AppBar(
        backgroundColor: LigthColor.maingreencolor,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            size: 25,
            color: LigthColor.whiteColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Color.fromARGB(255, 70, 113, 148),
        toolbarHeight: 75,
        title: Text(
          textScaleFactor: ScaleSize.textScaleFactor(context),
          "الفنادق",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: LigthColor.whiteColor,
              fontFamily: "Rubik"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                    child: Hotels_List(),
                  ),

                  //  Company_Addlast(),
                  SizedBox(height: 20),
                ],
              ),
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
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafahia_web/screens/favoritecompanys/favorite_list.dart';

import '../../uitles/colors.dart';

class FovaretScreen extends StatefulWidget {
  const FovaretScreen({super.key});

  @override
  State<FovaretScreen> createState() => _FovaretScreenState();
}

class _FovaretScreenState extends State<FovaretScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LigthColor.backscreen,
      appBar: AppBar(
        backgroundColor: LigthColor.backscreen,
        elevation: 0,
        // leading: IconButton(
        //   icon: FaIcon(
        //     FontAwesomeIcons.angleLeft,
        //     size: 25,
        //     color: LigthColor.maingreencolor,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        // backgroundColor: Color.fromARGB(255, 70, 113, 148),
        toolbarHeight: 75,
        title: Text(
          textScaleFactor: ScaleSize.textScaleFactor(context),
          "المفضلات",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: LigthColor.maingreencolor,
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
                    child: FavoriteList(),
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

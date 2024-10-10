import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_animated_buttons/widgets/pretty_wave_button.dart';
import 'package:rafahia_web/screens/chalet/chalet_sceen.dart';
import 'package:rafahia_web/screens/estraha/estraha_screen.dart';
import 'package:rafahia_web/screens/hotels/hotel_screen.dart';
import 'package:rafahia_web/uitles/colors.dart';
import 'package:rafahia_web/widget/animations.dart';

import '../../../api/helper/api_massegefirebase.dart';
import '../../chalet/components/chalet_liste.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: ContintsW(
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                "إستراحات",
                style: TextStyle(
                    color: LigthColor.whiteColor,
                    fontSize: 13,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              // String? token = await TestMasseging.getTokenFB();
              Navigator.push(context, FadeRoute1(Estraha_Screnn()));
            },
          ),
          GestureDetector(
            child: ContintsW(
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                "شاليهات",
                style: TextStyle(
                    color: LigthColor.whiteColor,
                    fontFamily: "Rubik",
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(context, FadeRoute1(Chalet_Screen()));
            },
          ),
          GestureDetector(
            child: ContintsW(
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                "فنادق",
                style: TextStyle(
                    color: LigthColor.whiteColor,
                    fontFamily: "Rubik",
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(context, FadeRoute1(Hotles_screen()));
            },
          ),
        ],
      ),
    );
  }
}

class ContintsW extends StatefulWidget {
  final Widget child;

  const ContintsW({
    super.key,
    required this.child,
  });

  @override
  State<ContintsW> createState() => _ContintsWState();
}

class _ContintsWState extends State<ContintsW> {
  @override
  Widget build(BuildContext context) {
    //for resonsive screen
    var screenSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      height: screenSize.height / 15,
      width: screenSize.width / 10,
      child: widget.child,
      decoration: BoxDecoration(
        color: LigthColor.maingreencolor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 99, 99, 99).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
    );
  }
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/screens/home/components/home_header.dart';
import 'package:rafahia_web/uitles/colors.dart';

import '../../../widget/animations.dart';
import '../../chalet/chalet_sceen.dart';
import '../../estraha/estraha_screen.dart';
import '../../hotels/hotel_screen.dart';
import 'discount_banner.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 580,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .5,
            child: LottieBuilder.asset(
              'assets/animation/welcomee.json',
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Padding(
                padding: const EdgeInsets.only(left: 100, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                        "مرحباً بك في رفاهية",
                        style: TextStyle(
                            color: LigthColor.maingreencolor,
                            fontSize: 40,
                            fontFamily: "Rubik")),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0, top: 20),
                        child: Text(
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            "أين تريد أن تكون رفاهيتك ؟",
                            style: TextStyle(
                                color: LigthColor.maingreencolor,
                                fontSize: 20,
                                fontFamily: "Rubik")),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: screenSize.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: ContintsW(
                              child: Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                "إستراحات",
                                style: TextStyle(
                                    color: LigthColor.whiteColor,
                                    fontSize: 10,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            onTap: () {
                              // String? token = await TestMasseging.getTokenFB();
                              Navigator.push(
                                  context, FadeRoute1(Estraha_Screnn()));
                            },
                          ),
                          GestureDetector(
                            child: ContintsW(
                              child: Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                "شاليهات",
                                style: TextStyle(
                                    color: LigthColor.whiteColor,
                                    fontFamily: "Rubik",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context, FadeRoute1(Chalet_Screen()));
                            },
                          ),
                          GestureDetector(
                            child: ContintsW(
                              child: Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                "فنادق",
                                style: TextStyle(
                                    color: LigthColor.whiteColor,
                                    fontFamily: "Rubik",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context, FadeRoute1(Hotles_screen()));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )
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

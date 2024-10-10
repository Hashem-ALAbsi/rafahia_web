// print(ApiCompany.hotles.map((e) => e.name));

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/screens/home/components/ads_carousel%20.dart';
import 'package:rafahia_web/screens/home/components/company_highest.dart';
import 'package:rafahia_web/screens/home/components/discount_banner.dart';
import 'package:rafahia_web/screens/home/components/estraha_suggestion.dart';
import 'package:rafahia_web/screens/home/components/home_header.dart';
import 'package:rafahia_web/screens/home/components/hotel_suggestion.dart';

import 'components/chalet_suggestion.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                  image: AssetImage('assets/images/blutt.png'),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Welcomepage(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 550),
                child: Column(
                  children: [
                    AdsImages(),
                    // DestinationCarousel(
                    //   key: GlobalKey(),
                    // ),
                    Hightest_company(),
                    SizedBox(
                      height: 20,
                    ),
                    Hotels_Suggetion(),
                    SizedBox(
                      height: 20,
                    ),
                    Chalet_Suggetion(),
                    SizedBox(
                      height: 20,
                    ),
                    Estraha_Suggetion(),
                  ],
                ),
              )
            ],
          ),

          // DiscountBanner(),
        ],
      ),
    ),);
  }
}

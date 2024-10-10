import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafahia_web/api/helper/api_company.dart';
import 'package:rafahia_web/api/helper/api_service.dart';
import 'package:rafahia_web/models/companymodels/companies_model_hight.dart';
import 'package:rafahia_web/models/estrahamodels/estraha_suggest_model.dart';
import 'package:rafahia_web/models/hotelsmodels/hotel_suggest_model.dart';
import 'package:rafahia_web/screens/home/components/section_title.dart';
import 'package:rafahia_web/screens/hotels/hotel_screen.dart';
import 'package:rafahia_web/uitles/colors.dart';

//import 'package:rafahia_app_final_emy/scrrens/home/components/discount_banner.dart';

import '../../../api/apiurl.dart';

import '../../../models/chaletmodels/chalet_suggest_model.dart';
import '../../../widget/animations.dart';
import '../../../widget/flutter_toast.dart';
import '../../details/detalis_company.dart';
import '../../estraha/estraha_screen.dart';

class Estraha_Suggetion extends StatefulWidget {
  const Estraha_Suggetion({super.key});

  @override
  State<Estraha_Suggetion> createState() => Estraha_SuggetionState();
}

class Estraha_SuggetionState extends State<Estraha_Suggetion> {
  bool didDispose = false;

  late List<Estraha_Suggest>? estrahasugge = [];
  // var allcompany;

  Future<void> _getallsuggetinoestraha() async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    estrahasugge = await ApiCompany.fetchCompanylastEstraaha();
    didDispose = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(estrahasugge!.map((e) => e.name));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getallsuggetinoestraha();
  }

  @override
  Widget build(BuildContext context) {
    //for resonsive screen
    var screenSize = MediaQuery.of(context).size * 1.00005;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextHomeMore(
              left_botton_text: "المزيد ",
              righe_text: " مقترح الاستراحات ",
              press: () {
                Navigator.push(context, FadeRoute1(Estraha_Screnn()));
              },
            )),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: didDispose == false
              ? Center(child: CircularProgressIndicator())
              : Row(children: [
                  ...estrahasugge!.map((estrahsug) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 2, bottom: 10),
                            child: Stack(
                              children: [
                                // Container(
                                //   width: double.infinity,
                                //   clipBehavior: Clip.antiAlias,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(
                                //           15) // Adjust the radius as needed
                                //       ),
                                //   child: Image.asset(
                                //     // "${company_highest.Data.toString()}",
                                //     "assets/images/hotelss.jpg",
                                //     fit: BoxFit.cover,
                                //     height: double.infinity,
                                //   ),
                                // ),
                                InkWell(
                                  child: Container(
                                    width: screenSize.width * 0.30,
                                    height: screenSize.height * 0.60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            15) // Adjust the radius as needed
                                        ),
                                    child: CachedNetworkImage(
                                      imageUrl: "${estrahsug.Data.toString()}",
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                    ),
                                  ),

                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new Company_Details(
                                                  id: estrahsug.id,
                                                  // id: estraha_suggestion
                                                  // .id
                                                )));
                                    print(estrahsug.id);
                                    print(
                                        "================================================");
                                  },
//                                   :
                                ),

                                // Stack(
                                //   children: [
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 1, right: 10),
                                //     child: Align(
                                //       alignment: Alignment.topRight,
                                //       child: Text(
                                //         " ${company_highest.name} ${company_highest.typeCompanyName} ",
                                //         style: TextStyle(
                                //           fontSize: 17,
                                //           fontFamily: "Rubik",
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //       ),
                                //     )),
                                Container(
                                  width: screenSize.width * 0.30,
                                  height: screenSize.height * 0.60,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color.fromARGB(90, 0, 0, 0),
                                        Color.fromARGB(81, 0, 0, 0),
                                        Color.fromARGB(54, 65, 65, 65),
                                        Color.fromARGB(41, 0, 0, 0),
                                      ],
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new Company_Details(
                                                    id: estrahsug.id,
                                                    // id: estraha_suggestion
                                                    // .id
                                                  )));
                                      print(estrahsug.id);
                                      print(
                                          "================================================");

                                      // print(estraha_suggestion.id);
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 330),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: screenSize.width * 0.3,
                                          height: screenSize.height * 0.088,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color.fromARGB(117, 18, 18, 18),
                                                Color.fromARGB(107, 0, 0, 0),
                                                Color.fromARGB(127, 65, 65, 65),
                                                Color.fromARGB(54, 0, 0, 0),
                                              ],
                                            ),
                                          ),
                                          child: Text(
                                            textScaleFactor:
                                                ScaleSize.textScaleFactor(
                                                    context),
                                            " ${estrahsug.name}",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Rubik",
                                                fontWeight: FontWeight.w600,
                                                color: LigthColor.whiteColor),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 11),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Text(
                                                //   // "${company_highest.addressId}"
                                                // //   "sss",
                                                //   style: TextStyle(
                                                //     fontSize: 12,
                                                //     fontFamily: "Rubik",
                                                //     fontWeight: FontWeight.w500,
                                                //     color: LigthColor.citycolor,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: LigthColor.starsColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: LigthColor.starsColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: LigthColor.starsColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: LigthColor.starsColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: LigthColor.starsColor,
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ]),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
    super.dispose();
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

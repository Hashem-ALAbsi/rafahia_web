import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rafahia_web/uitles/colors.dart';
import 'package:rafahia_web/widget/search_field.dart';

import '../../../api/apiurl.dart';
import '../../../api/helper/api_company.dart';
import '../../../models/hotelsmodels/hotel_model.dart';
import '../../details/detalis_company.dart';

class Hotels_List extends StatefulWidget {
  const Hotels_List({super.key});

  @override
  State<Hotels_List> createState() => _Hotels_ListState();
}

class _Hotels_ListState extends State<Hotels_List> {
  // late final HotelProvider _hotelProvider;

  bool didDispose = false;
  // List<Hotles_Company> hotles = [];
  // BaseUrl _baseUrl = new BaseUrl();
  // GetHotel _getHotel = new GetHotel();
  late List<Hotles_Company> _filteredHotels;
  final TextEditingController _searchController = TextEditingController();
  late List<Hotles_Company>? hotels = [];
  // var allcompany;

  Future<void> _getallhotel() async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    hotels = await ApiCompany.fetchgetHotel();
    _filteredHotels = hotels!;
    didDispose = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(hotels!.map((e) => e.name));
  }

  @override
  void initState() {
    super.initState();
    _getallhotel();
  }

// for searching
  void _searchAndFilter(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all hotels
      setState(() {
        _filteredHotels = hotels!;
      });
    } else {
      // If the search query is not empty, filter the list of hotels
      setState(() {
        _filteredHotels = hotels!.where((hotel) {
          return hotel.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Searchbar(
              presss: () {
                _searchController.clear();
                _searchAndFilter('');
              },
              onChanged: _searchAndFilter,
              searchcontroller: _searchController,
              text: "... البحث عن فندق",
              press: () {
                _searchController.clear();
                _searchAndFilter('');
              },
            ),
            didDispose == false
                ? Center(
                        child: LottieBuilder.asset(
                          'assets/animation/loading_3bool.json',
                          // height: 180,
                          // width: 180,
                        ),
                      )
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ..._filteredHotels.map(
                        (hottles) => Stack(
                          children: [
                            Container(
                                width: 400,
                                height: 138,
                                decoration: BoxDecoration(
                                    color: LigthColor.maingreencolor,
                                    borderRadius: BorderRadius.circular(15))),
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Company_Details(
                                                  id: hottles.id)));
                                  print(hottles.id);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: LigthColor.whiteColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              // "srag",
                                              '${hottles.name}',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color:
                                                      LigthColor.massegeColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Rubik"),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // "ds",
                                                  '${hottles.cityName} - ${hottles.addressName}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: LigthColor
                                                          .massegeColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Rubik"),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  size: 15,
                                                  color:
                                                      LigthColor.locaionColor,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: List<Widget>.generate(5,
                                                  (int index) {
                                                final bool isFilled =
                                                    index < double.parse('5');
                                                final Color iconColor = isFilled
                                                    ? LigthColor.starsColor
                                                    : LigthColor.starsColor;
                                                return Icon(
                                                  Icons.star,
                                                  color: isFilled
                                                      ? LigthColor.starsColor
                                                      : iconColor,
                                                  size: 20,
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 5, right: 5, top: 5),
                                        height: 140,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(
                                                  20)), // Set the desired radius here
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              // "assets/images/first.jpg"

                                              hottles.Data.toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                                top: 7,
                              ),
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.angleLeft,
                                  size: 20,
                                ),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             new DetailsScreen(
                                  //                 id: hottles.id)));

                                  // print(hottles.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
    super.dispose();
  }
}

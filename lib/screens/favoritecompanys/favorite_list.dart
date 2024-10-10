import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../api/helper/api_company.dart';
import '../../api/helper/api_token.dart';
import '../../models/favoritecompanymodels/favoritecompany_model.dart';
import '../../uitles/colors.dart';
import '../../widget/search_field.dart';
import '../details/detalis_company.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  bool didDispose = false;
  late bool? _isfavorit;
  // List<Hotles_Company> hotles = [];
  // BaseUrl _baseUrl = new BaseUrl();
  // GetHotel _getHotel = new GetHotel();
  late List<FavoriteCompany> _filteredfavoritecompany;
  final TextEditingController _searchController = TextEditingController();
  late List<FavoriteCompany>? _favoritecompany = [];
  // var allcompany;

  Future<void> _fetchdatafavoriteCompany() async {
    int id = await ApiToken.getId();
    // allcompany = await ApiService.fetchServiceDetails(1);
    _favoritecompany = await ApiCompany.fetchdatafavoriteCompany(id);
    _filteredfavoritecompany = _favoritecompany!;
    didDispose = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(estraha!.map((e) => e.name));
  }

  Future<void> _fetchdataDeletefavoriteCompany(int? id) async {
    _isfavorit = await ApiCompany.deletefavoriteCompany(id);
  }

  @override
  void initState() {
    super.initState();
    _fetchdatafavoriteCompany();
  }

// for searching
  void _searchAndFilter(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all hotels
      setState(() {
        _filteredfavoritecompany = _favoritecompany!;
      });
    } else {
      // If the search query is not empty, filter the list of hotels
      setState(() {
        _filteredfavoritecompany = _favoritecompany!.where((favoritecompany) {
          return favoritecompany.companyName!
              .toLowerCase()
              .contains(query.toLowerCase());
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
              text: "... البحث عن المفضلة",
              press: () {
                _searchController.clear();
                _searchAndFilter('');
              },
            ),
            didDispose == false
                ? Center(
                    child: LottieBuilder.asset(
                      'assets/animation/search_none.json',
                      // height: 180,
                      // width: 180,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ..._filteredfavoritecompany.map(
                        (favoritecompanys) => Stack(
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
                                                  id: favoritecompanys
                                                      .companyId)));
                                  print(favoritecompanys.companyId);
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
                                              '${favoritecompanys.companyName}',
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
                                                  '${favoritecompanys.cityName} - ${favoritecompanys.addressName}',
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

                                              favoritecompanys.data.toString(),
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
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 20,
                                    color: LigthColor.favorColor,
                                  ),
                                  onPressed: () {
                                    AwesomeDialog(
                                        titleTextStyle: TextStyle(
                                            fontFamily: "Rubik", fontSize: 15),
                                        descTextStyle: TextStyle(
                                            fontFamily: "Rubik", fontSize: 15),
                                        buttonsTextStyle: TextStyle(
                                            fontFamily: "Rubik",
                                            color: LigthColor.whiteColor),
                                        btnOkText: "نعم",
                                        btnCancelText: "إلغاء",
                                        btnCancelColor: LigthColor.favorColor,
                                        btnOkColor: LigthColor.nanm1n,
                                        context: context,
                                        dialogType: DialogType.info,
                                        animType: AnimType.rightSlide,
                                        title: 'أنتبه',
                                        desc:
                                            'هل أنت متأكد من الغاء هذه من المفضلة؟',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          setState(() {
                                            didDispose = false;
                                          });
                                          await _fetchdataDeletefavoriteCompany(
                                              favoritecompanys.id);
                                          await _fetchdatafavoriteCompany();
                                          // _refrish == false;
                                          // setState(() {
                                          //  _handRefresh();
                                          // });
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     new MaterialPageRoute(
                                          //         builder: (context) => new Nav_Bar()));
                                        }).show();
                                    //print(favoritecompanys.id);
                                  },
                                )),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     left: 8,
                            //     top: 7,
                            //   ),
                            //   child: IconButton(
                            //     icon: FaIcon(
                            //       FontAwesomeIcons.angleLeft,
                            //       size: 20,
                            //     ),
                            //     onPressed: () {
                            //       // Navigator.push(
                            //       //     context,
                            //       //     new MaterialPageRoute(
                            //       //         builder: (context) =>
                            //       //             new DetailsScreen(
                            //       //                 id: estrahas.id)));

                            //       // print(estrahas.id);
                            //     },
                            //   ),
                            // ),
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

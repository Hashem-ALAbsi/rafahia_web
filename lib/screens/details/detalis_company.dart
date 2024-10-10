import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rafahia_web/api/helper/api_commint_and_rating.dart';
import 'package:rafahia_web/api/helper/api_image.dart';
import 'package:rafahia_web/api/helper/api_service.dart';
import 'package:rafahia_web/models/commintmodels/commint_model.dart';
import 'package:rafahia_web/models/imagemodels/image_model.dart';
import 'package:rafahia_web/uitles/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../api/helper/api_company.dart';
import '../../api/helper/api_token.dart';
import '../../models/servicemodels/service_model.dart';
import '../../widget/flutter_toast.dart';
import '../service/all_detials_service.dart';

class Company_Details extends StatefulWidget {
  final int? id;
  Company_Details({super.key, this.id});

  @override
  State<Company_Details> createState() => _Company_DetailsState();
}

class _Company_DetailsState extends State<Company_Details> {
  //late List<Hotel_Suggest>? hotelsugge = [];
  bool did = false;
  late bool? _isfavorit;
  late bool? _success;
  // تلوين ايقونات الخدمات
  bool serviceicon1 = false;
  bool serviceicon2 = false;
  bool serviceicon3 = false;
  Color iconcolor1 = LigthColor.graycolor;
  Color iconcolor2 = LigthColor.graycolor;
  Color iconcolor3 = LigthColor.graycolor;
  TextEditingController commintcontroller = TextEditingController();
  TextEditingController ratingcontroller = TextEditingController();
  TextEditingController upcommintcontroller = TextEditingController();
  TextEditingController upratingcontroller = TextEditingController();
  late CameraPosition _kGooglePlex;
  late Set<Marker> _marker;
  Completer<GoogleMapController> _controller = Completer();
  late double _longtude;
  late double _latetude;
  late String _namecompany;
  var _longtude2;
  var _latetude2;

  Future<void> _getk(double la, double lo, String namec) async {
    try {
      _kGooglePlex = CameraPosition(
        //target: LatLng(int.parse(_Latetude), 44.257319),
        target: LatLng(la, lo),
        zoom: 13,
        //zoom: 18.4746,
      );
      _marker = {
        Marker(
            markerId: MarkerId("1"),
            infoWindow: InfoWindow(title: namec),
            onTap: () async {
              //ShowMasseg.ShowToastMasseg("hhhhhhhhhhh", Colors.red);
              await _openMap(la, lo);
            },
            // icon: await BitmapDescriptor.fromAssetImage(
            //     ImageConfiguration.empty, "assets/icon/pin_png.png"),
            position: LatLng(la, lo))
      };
    } catch (er) {}
  }

//=========================== company details
  var allcompany;
  Future<void> _getCompany(int? id) async {
    allcompany = await ApiCompany.fetchHotelDetails(id);
    // allcompany = await ApiService.fetchServiceDetails(1);
    // print(allcompany['longtude'].toString());
    setState(() {
      _longtude2 = allcompany['longtude'];
      _latetude2 = allcompany['latetud'];
      _namecompany = allcompany['name'];
      _latetude = double.parse(_latetude2);
      _longtude = double.parse(_longtude2);
      _getk(_latetude, _longtude, _namecompany);

      serviceicon1 = allcompany["rustorant"];
      serviceicon2 = allcompany["cooffee"];
      serviceicon3 = allcompany["swimmingbool"];

      iconcolor1 = serviceicon1 ? LigthColor.iconservice : LigthColor.graycolor;
      iconcolor2 = serviceicon2 ? LigthColor.iconservice : LigthColor.graycolor;
      iconcolor3 = serviceicon3 ? LigthColor.iconservice : LigthColor.graycolor;
      // _getallcommints(widget.id);
      // _getallimages(widget.id);
      // _getallservice(widget.id);
      did = true;
    });
    //print(hotelsugge!.map((e) => e.name));
    // print(allcompany['name']);
    // print(allcompany['name']);
  }

  Future<void> _openMap(double lat, double log) async {
    String googleURl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$log";
    await canLaunchUrlString(googleURl)
        ? await launchUrlString(googleURl)
        : throw 'cloud not launch $googleURl';
  }

//==========================================commints
  late List<Commintcompany>? commenti = [];
  // var comment;

  Future<void> _getallcommints(int? id) async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    commenti = await ApiCommintAndRating.fetchCommintDetails(id);
    // did = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(commenti!.map((e) => e.commentname));
  }

//============================================images
  late List<Image_company>? companyimages = [];
  Future<void> _getallimages(int? id) async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    companyimages = await ApiImage.fetchImageCompanyDetails(id);
    // did = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));
    // print(allcompany['name']);
    // print(commenti!.map((e) => e.commentname));
  }

//============================================= services
  late List<ServiceCompany>? allservicec = [];
  Future<void> _getallservice(int? id) async {
    // allcompany = await ApiService.fetchServiceDetails(1);
    allservicec = await ApiService.fetchdataservices(id);
    // did = true;
    setState(() {});
    //print(companyhight!.map((e) => e.name));

    // print(commenti!.map((e) => e.commentname));
  }

  //=======================================
  Future<void> _createfouviret(int? companyid) async {
    int id = await ApiToken.getId();
    if (id == 0) {
      ShowMasseg.ShowToastMasseg("يرجى تسجيل دخولك اولا", Colors.red);
    } else {
      _isfavorit = await ApiCompany.createfouviret(id, companyid);
    }
  }

  Future<void> _commintandRitang(BuildContext context) async {
    int id = await ApiToken.getId();
    if (id == 0) {
      ShowMasseg.ShowToastMasseg("يرجى تسجيل دخولك اولا", Colors.red);
    } else {
      _success = await ApiCommintAndRating.commintandRitang(
          id, widget.id, commintcontroller.text, ratingcontroller.text);
      await _getCompany(widget.id);
      // setState(() {});
    }
  }

  Future<void> _updatecommint(BuildContext context, int? idcommint) async {
    int id = await ApiToken.getId();
    if (id == 0) {
      ShowMasseg.ShowToastMasseg("يرجى تسجيل دخولك اولا", Colors.red);
    } else {
      _success = await ApiCommintAndRating.updatecommint(
          id, idcommint, upcommintcontroller.text, upratingcontroller.text);
      // setState(() {});
      // await _getCompany(widget.id);
    }
  }

  Future<void> _deletecommint(int? idcommint) async {
    int id = await ApiToken.getId();
    if (id == 0) {
      ShowMasseg.ShowToastMasseg("يرجى تسجيل دخولك اولا", Colors.red);
    } else {
      _success = await ApiCommintAndRating.deletecommint(id, idcommint);
      // setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.id);
    _getCompany(widget.id);
    _getallcommints(widget.id);
    _getallimages(widget.id);
    _getallservice(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size * 1.00005;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: LigthColor.anm1,
            title: Text(
              textScaleFactor: ScaleSize.textScaleFactor(context),
              "التفــاصيــــــــــــــل",
              style: TextStyle(
                  fontFamily: "Rubik",
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: LigthColor.whiteColor),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await _createfouviret(widget.id);
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    color: LigthColor.favorColor,
                    size: screenSize.height * 0.033,
                  ))
            ],
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
                color: LigthColor.whiteColor,
                size: screenSize.height * 0.033,
              ),
            ),
          ),
          body: did == false
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      //الصورة الكبيرة

                      CachedNetworkImage(
                        imageUrl: "${allcompany['imageCompany']}",
                        // 73
                        height: screenSize.height * 0.40,
                        width: screenSize.width * 1,
                        fit: BoxFit.cover, // Add this line
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                          " ${allcompany['name']}",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600,
                              color: LigthColor.massegeColor),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(10, (int index) {
                          final bool isFilled = index <
                              // double.parse('${rating.toString()}');
                              double.parse('${allcompany['addressId']}');

                          final Color iconColor = isFilled
                              ? Color.fromARGB(255, 228, 214, 89)
                              : Color.fromARGB(106, 241, 231, 148);
                          return Icon(
                            Icons.star,
                            color: isFilled
                                ? const Color.fromARGB(255, 255, 199, 59)
                                : Color.fromARGB(255, 242, 231, 162),
                            size: 20,
                          );
                        }).toList(),
                      ),
                      //الصور الصغيرة
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //didDispose2==false ? Center(child: CircularProgressIndicator()) :
                              ...companyimages!.map(
                                (imagelist) => Card(
                                  child: InkWell(
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        // color: Color.fromARGB(
                                        //     255, 33, 91, 138),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "${imagelist.date.toString()}"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 500,
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  color:
                                                      LigthColor.maingreencolor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ), // Set the desired radius here
                                                  image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      imagelist.date.toString(),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                            indicatorColor: Colors.amberAccent,
                            unselectedLabelColor: Colors.grey,
                            labelColor: Color.fromARGB(255, 33, 91, 138),
                            tabs: [
                              // التبويب الاول
                              Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                "اختر اقامتك",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              // التبويب الثاني
                              Text(
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                "المعلومات",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Rubik",
                                ),
                              )
                            ]),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(children: [
                            //=================================================================================  service
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SingleChildScrollView(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    ...allservicec!
                                        .map((servicecompanys) => Stack(
                                              children: [
                                                Container(
                                                    width: 400,
                                                    height: 138,
                                                    decoration: BoxDecoration(
                                                        color: LigthColor
                                                            .maingreencolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                SizedBox(
                                                  height: 150,
                                                  width: double.infinity,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     new MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             new HotelDetailsScreen(id: esttraha.id)));
                                                      // print(esttraha.id);
                                                    },
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        // عشان ينقلنا لواجهه التفاصيل للخدمات عبر id
                                                                        new ServiceDetailsScreen(
                                                                            id: servicecompanys.id)));
                                                        print(
                                                            servicecompanys.id);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 12),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                                color: LigthColor
                                                                    .whiteColor,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        146,
                                                                        146,
                                                                        146),
                                                                offset:
                                                                    const Offset(
                                                                  2.0,
                                                                  1.0,
                                                                ),
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.1,
                                                              )
                                                            ]),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 18,
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    textScaleFactor:
                                                                        ScaleSize.textScaleFactor(
                                                                            context),
                                                                    '${servicecompanys.name} ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: LigthColor
                                                                            .massegeColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Rubik"),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        textScaleFactor:
                                                                            ScaleSize.textScaleFactor(context),
                                                                        "ريال",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                LigthColor.massegeColor,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: "Rubik"),
                                                                      ),
                                                                      Text(
                                                                        textScaleFactor:
                                                                            ScaleSize.textScaleFactor(context),
                                                                        '${servicecompanys.price}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                LigthColor.massegeColor,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: "Rubik"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: List<Widget>.generate(
                                                                            5,
                                                                            (int
                                                                                index) {
                                                                          final bool
                                                                              isFilled =
                                                                              index < double.parse('5');
                                                                          final Color iconColor = isFilled
                                                                              ? LigthColor.starsColor
                                                                              : LigthColor.starsColor;
                                                                          return Icon(
                                                                            Icons.star,
                                                                            color: isFilled
                                                                                ? LigthColor.starsColor
                                                                                : iconColor,
                                                                            size:
                                                                                20,
                                                                          );
                                                                        }).toList(),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 140,
                                                              width: 250,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                ), // Set the desired radius here
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    // "assets/images/first.jpg"
                                                                    servicecompanys
                                                                            .Data
                                                                        .toString(),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
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
                                                        FontAwesomeIcons
                                                            .angleLeft,
                                                        size: 30,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) =>
                                                                    new ServiceDetailsScreen(
                                                                        id: servicecompanys
                                                                            .id)));
                                                      },
                                                    )),
                                              ],
                                            ))
                                  ]),
                                ))
                              ],
                            ),
                            //=================================================================================  details
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 20, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          textScaleFactor:
                                              ScaleSize.textScaleFactor(
                                                  context),
                                          "${allcompany['addressName']} - ${allcompany['cityName']}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Rubik",
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 126, 126, 126)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          color: LigthColor.locaionColor,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      child: GoogleMap(
                                        markers: _marker,
                                        mapType:
                                            //MapType.hybrid,
                                            MapType.normal,
                                        initialCameraPosition: _kGooglePlex,
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          // gmc = controller;
                                          _controller.complete(controller);
                                        },
                                      ),
                                      // child: Text("data"),
                                      //  GoogleMap(
                                      //   markers: _marker,
                                      //   mapType:
                                      //       //MapType.hybrid,
                                      //       MapType.normal,
                                      //   initialCameraPosition: _kGooglePlex,
                                      //   onMapCreated: (GoogleMapController
                                      //       controller)
                                      //   //     {
                                      //   //   // gmc = controller;
                                      //   //   _controller.complete(controller);
                                      //   // },
                                      // ),
                                      //alignment: Alignment.center,
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: LigthColor.citycolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    indent: screenSize.height * 0.1,
                                    endIndent: screenSize.height * 0.1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, right: 12),
                                    child: Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "التقييمات",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w600,
                                          color: LigthColor.massegeColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, right: 14),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          textScaleFactor:
                                              ScaleSize.textScaleFactor(
                                                  context),
                                          " من التقييمات العامة ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Rubik",
                                              color:
                                                  LigthColor.supmessageColor),
                                        ),
                                        Text(
                                          textScaleFactor:
                                              ScaleSize.textScaleFactor(
                                                  context),
                                          "${allcompany['addressId']} / 10",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Rubik",
                                              color:
                                                  LigthColor.supmessageColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "اراء المستخدمين",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        fontFamily: "Rubik",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // التعليقات
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          child: Row(children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20)),
                                            ...commenti!
                                                .map((commitcmop) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7.0),
                                                      child: Container(
                                                        height:
                                                            screenSize.height *
                                                                0.4,
                                                        width:
                                                            screenSize.width *
                                                                0.30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),

                                                          /************************************/
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      146,
                                                                      146,
                                                                      146),
                                                              offset:
                                                                  const Offset(
                                                                2.0,
                                                                1.0,
                                                              ),
                                                              blurRadius: 2.0,
                                                              spreadRadius: 0.1,
                                                            )
                                                          ],
                                                        ),
                                                        // المستخدم
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        textScaleFactor:
                                                                            ScaleSize.textScaleFactor(context),
                                                                        // " ايمان عبدالله ",
                                                                        "${commitcmop.clientname} ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontFamily:
                                                                              "Rubik",
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            98,
                                                                            25,
                                                                            68,
                                                                            103),
                                                                        radius: screenSize.height *
                                                                            0.02,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      textScaleFactor:
                                                                          ScaleSize.textScaleFactor(
                                                                              context),
                                                                      // "date",
                                                                      "${commitcmop.createAt}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              8,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: screenSize
                                                                      .height *
                                                                  0.002,
                                                              thickness: 1.0,
                                                              color: Color
                                                                  .fromARGB(
                                                                      146,
                                                                      133,
                                                                      133,
                                                                      133),
                                                              indent: 1.0,
                                                              endIndent: 1.0,
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .all(5),
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                height: screenSize
                                                                        .height *
                                                                    0.2,
                                                                width: screenSize
                                                                        .width *
                                                                    0.2,
                                                                child: Text(
                                                                  textScaleFactor:
                                                                      ScaleSize
                                                                          .textScaleFactor(
                                                                              context),
                                                                  // "التعلق",
                                                                  "${commitcmop.commentname}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 9,
                                                                    fontFamily:
                                                                        "Rubik",
                                                                  ),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      top: 10,
                                                                      left: 10),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            textScaleFactor:
                                                                                ScaleSize.textScaleFactor(context),
                                                                            // "ration",
                                                                            "${commitcmop.ratingvalue}",
                                                                            style:
                                                                                TextStyle(color: Color.fromARGB(255, 17, 17, 17), fontSize: 10),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            size:
                                                                                screenSize.height * 0.035,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                233,
                                                                                183,
                                                                                4),
                                                                          ),
                                                                        ]),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            upcommintcontroller.text =
                                                                                commitcmop.commentname.toString();
                                                                            upratingcontroller.text =
                                                                                commitcmop.ratingvalue.toString();
                                                                          });
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext ctx) {
                                                                                return AlertDialog(
                                                                                  title: Container(
                                                                                    alignment: Alignment.center,
                                                                                    child: const Text(
                                                                                      'شاركنا رئيك',
                                                                                      style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontFamily: "Rubik",
                                                                                        color: LigthColor.buttons,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  content: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      TextField(
                                                                                        style: TextStyle(
                                                                                          fontFamily: "Rubik",
                                                                                          color: LigthColor.supmaincolor,
                                                                                        ),
                                                                                        maxLength: 50,
                                                                                        autofocus: true,
                                                                                        controller: upcommintcontroller,
                                                                                        cursorColor: LigthColor.supmaincolor,
                                                                                        autocorrect: true,
                                                                                        textAlign: TextAlign.end,
                                                                                        decoration: InputDecoration(
                                                                                            focusedBorder: UnderlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                              width: 2,
                                                                                              color: LigthColor.supmaincolor,
                                                                                            )),
                                                                                            hintText: 'ادخل تعليقك',
                                                                                            hintStyle: TextStyle(
                                                                                              fontFamily: "Rubik",
                                                                                              fontSize: 12,
                                                                                              color: LigthColor.graycolor,
                                                                                            )),
                                                                                      ),
                                                                                      TextField(
                                                                                        maxLength: 2,
                                                                                        keyboardType: TextInputType.number,
                                                                                        autofocus: true,
                                                                                        controller: upratingcontroller,
                                                                                        cursorColor: LigthColor.supmaincolor,
                                                                                        autocorrect: true,
                                                                                        textAlign: TextAlign.end,
                                                                                        decoration: InputDecoration(
                                                                                            focusedBorder: UnderlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                              width: 2,
                                                                                              color: LigthColor.supmaincolor,
                                                                                            )),
                                                                                            hintText: 'ادخل التقييم من 1-10 ',
                                                                                            hintStyle: TextStyle(fontFamily: "Rubik", fontSize: 12)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  actions: [
                                                                                    // The "تم" button
                                                                                    TextButton(
                                                                                        onPressed: () async {
                                                                                          await _updatecommint(context, commitcmop.id);
                                                                                          setState(() {
                                                                                            _getCompany(widget.id);
                                                                                          });
                                                                                          // Navigator.pop(context);
                                                                                        },
                                                                                        child: const Text(
                                                                                          'تم',
                                                                                          style: TextStyle(
                                                                                            fontFamily: "Rubik",
                                                                                            fontSize: 13,
                                                                                            color: LigthColor.supmaincolor,
                                                                                          ),
                                                                                        )),
                                                                                  ],
                                                                                );
                                                                              });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              40,
                                                                          color:
                                                                              LigthColor.acceptorder,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              textScaleFactor: ScaleSize.textScaleFactor(context),
                                                                              "تعديل",
                                                                              style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Rubik"),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          AwesomeDialog(
                                                                              context: context,
                                                                              dialogType: DialogType.info,
                                                                              animType: AnimType.rightSlide,
                                                                              title: 'تنبيه',
                                                                              desc: 'هل انت متاكد من حذف التعليق؟',
                                                                              titleTextStyle: TextStyle(fontFamily: "Rubik"),
                                                                              btnCancelOnPress: () {
                                                                                // Navigator.pop(context);
                                                                              },
                                                                              btnOkOnPress: () async {
                                                                                await _deletecommint(commitcmop.id);
                                                                                print(commitcmop.id);
                                                                                setState(() {
                                                                                  _getCompany(widget.id);
                                                                                });
                                                                                //Navigator.of(context).pop();
                                                                                //await _fetchCommintDetails(widget.id);
                                                                              }).show();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              40,
                                                                          color:
                                                                              LigthColor.delete,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              textScaleFactor: ScaleSize.textScaleFactor(context),
                                                                              "حذف",
                                                                              style: TextStyle(fontSize: 10, color: Colors.white, fontFamily: "Rubik", fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                          ]))),

                                  // button booking
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 25),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: Expanded(
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        LigthColor
                                                            .maingreencolor),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      return AlertDialog(
                                                        title: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'شاركنا رئيك',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Rubik",
                                                                color: LigthColor
                                                                    .buttons),
                                                          ),
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            TextField(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Rubik",
                                                                color: LigthColor
                                                                    .supmaincolor,
                                                              ),
                                                              maxLength: 50,
                                                              autofocus: true,
                                                              controller:
                                                                  commintcontroller,
                                                              cursorColor:
                                                                  LigthColor
                                                                      .supmaincolor,
                                                              autocorrect: true,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              decoration:
                                                                  InputDecoration(
                                                                      focusedBorder:
                                                                          UnderlineInputBorder(
                                                                              borderSide:
                                                                                  BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: LigthColor
                                                                            .supmaincolor,
                                                                      )),
                                                                      hintText:
                                                                          'ادخل تعليقك',
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Rubik",
                                                                        fontSize:
                                                                            12,
                                                                        color: LigthColor
                                                                            .graycolor,
                                                                      )),
                                                            ),
                                                            TextField(
                                                              maxLength: 2,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              autofocus: true,
                                                              controller:
                                                                  ratingcontroller,
                                                              cursorColor:
                                                                  LigthColor
                                                                      .supmaincolor,
                                                              autocorrect: true,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              decoration:
                                                                  InputDecoration(
                                                                      focusedBorder:
                                                                          UnderlineInputBorder(
                                                                              borderSide:
                                                                                  BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: LigthColor
                                                                            .supmaincolor,
                                                                      )),
                                                                      hintText:
                                                                          'ادخل التقييم من 1-10 ',
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Rubik",
                                                                        fontSize:
                                                                            12,
                                                                        color: LigthColor
                                                                            .graycolor,
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          // The "تم" button
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await _commintandRitang(
                                                                    context);
                                                                // setState(() {
                                                                //   _getCompany(
                                                                //       widget
                                                                //           .id);
                                                                // });

                                                                // Navigator.of(
                                                                //         context)
                                                                //     .pop();
                                                              },
                                                              child: const Text(
                                                                'تم',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Rubik",
                                                                  fontSize: 13,
                                                                  color: LigthColor
                                                                      .supmaincolor,
                                                                ),
                                                              )),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                "شاركنا رئيك",
                                                textScaleFactor:
                                                    ScaleSize.textScaleFactor(
                                                        context),
                                                style: TextStyle(
                                                    fontFamily: "Rubik",
                                                    fontSize: 12,
                                                    color:
                                                        LigthColor.whiteColor),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 15),
                                    child: Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "نبذة عن ال${allcompany['typeCompanyName']} ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Rubik",
                                        color: LigthColor.massegeColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: LigthColor.whiteColor,
                                      border: Border.all(
                                        color: LigthColor.whiteColor,
                                      ),
                                      /************************************/
                                      boxShadow: [
                                        BoxShadow(
                                          color: LigthColor.shadow,
                                          offset: const Offset(
                                            2.0,
                                            1.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 0.1,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      // النبذة
                                      child: Text(
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        "${allcompany['note']}",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: "Rubik",
                                            color: LigthColor.massegeColor),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 5, right: 5, bottom: 2),
                                    //الخدمات
                                    child: Text(
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                      "الخدمات  ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Rubik",
                                          color: LigthColor.massegeColor),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    height: screenSize.height * 0.2,
                                    width: double.infinity,

                                    //الايقونات
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 14, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),
                                                      "كافي",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: iconcolor1,
                                                        fontFamily: "Rubik",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.mugHot,
                                                      color: iconcolor1,
                                                      size: 28,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),
                                                      "مطعم ",
                                                      style: TextStyle(
                                                        color: iconcolor2,
                                                        fontSize: 14,
                                                        fontFamily: "Rubik",
                                                      ),
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.utensils,
                                                      color: iconcolor1,
                                                      size: 28,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      textScaleFactor: ScaleSize
                                                          .textScaleFactor(
                                                              context),
                                                      "مسبح ",
                                                      style: TextStyle(
                                                        color: iconcolor1,
                                                        fontSize: 14,
                                                        fontFamily: "Rubik",
                                                      ),
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .personSwimming,
                                                      color: iconcolor1,
                                                      size: 28,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ])),
                    ],
                  ),
                )),
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

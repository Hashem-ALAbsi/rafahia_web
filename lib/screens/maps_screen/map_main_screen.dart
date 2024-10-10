import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rafahia_web/api/helper/api_company.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/companymodels/companies_map_model.dart';
import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';
import '../details/detalis_company.dart';

class MapCompanyScreen extends StatefulWidget {
  const MapCompanyScreen({super.key});

  @override
  State<MapCompanyScreen> createState() => _MapCompanyScreenState();
}

class _MapCompanyScreenState extends State<MapCompanyScreen> {
  late List<CompanysMap>? companymap = [];

  bool didDispose = false;
  bool clientlocation = false;
  late bool serviceEnabled;
  LatLng sourcelocation = LatLng(15.3253556, 44.2080536);
  // late Set<Marker> _marker;
  late Map<String, Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _gmc;
  late CameraPosition _kGooglePlex;
  var usermarker;

  _getk() {
    _kGooglePlex = CameraPosition(
      target: sourcelocation,
      zoom: 12,
    );
  }

  Future<void> _fetchMapDetails() async {
    companymap = await ApiCompany.fetchMapDetails();
    await _getmarker();
    setState(() {
      didDispose = true;
    });
  }

  Future<void> _getmarker() async {
    try {
      for (int i = 0; i < (companymap!.length); i++) {
        BitmapDescriptor markericon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icon/pin_png.png");

        _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(companymap![i].lam, companymap![i].lom),
          icon: markericon,
          infoWindow: InfoWindow(
            title: companymap![i].name,
            onTap: () async {
              //ShowMasseg.ShowToastMasseg("hhhhhhhhhhh", Colors.red);
              await _openMap(companymap![i].lam, companymap![i].lom);
            },
          ),
        );
      }
      usermarker = Marker(
        markerId: MarkerId("client"),
        position: sourcelocation,
        // icon: markericon,
        infoWindow: InfoWindow(
          title: "موقعي الحالي",
          onTap: () async {
            //ShowMasseg.ShowToastMasseg("hhhhhhhhhhh", Colors.red);
            await _openMap(sourcelocation.latitude, sourcelocation.longitude);
          },
        ),
      );
      _markers.addAll({"client": usermarker});
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  late double clientlat;
  late double clientlong;

  void _livelocation() async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        clientlat = position.latitude;
        clientlong = position.longitude;
        clientlocation = true;
      });
    });
    _getk();
  }

  void _ref() async {
    _getclientlocation();
  }

  Future<Position> _getclientlocation() async {
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ShowMasseg.ShowToastMasseg("يرجى تفعيل خاصية الموقع", Colors.red);

      // setState(() {
      //   clientlocation = false;
      // });
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      ShowMasseg.ShowToastMasseg("يرجى تفعيل خاصية الموقع", Colors.red);
      //clientlocation = false;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ShowMasseg.ShowToastMasseg("يرجى تفعيل خاصية الموقع", Colors.red);
        // clientlocation = false;
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ShowMasseg.ShowToastMasseg("يرجى تفعيل خاصية الموقع", Colors.red);
      // Permissions are denied forever, handle appropriately.
      // clientlocation = false;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    setState(() {
      clientlocation = true;
    });
    ShowMasseg.ShowToastMasseg(
        "تم اظهار جميع الاماكن القريبة منك", Colors.blue);
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openMap(double lat, double log) async {
    String googleURl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$log";
    await canLaunchUrlString(googleURl)
        ? await launchUrlString(googleURl)
        : throw 'cloud not launch $googleURl';
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchMapDetails();
    _getk();
    // _ref();
    _getclientlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LigthColor.backscreen,
      appBar: AppBar(
        toolbarHeight: 66,
        // toolbarHeight: 100,
        backgroundColor: LigthColor.backscreen,
        elevation: 0,
        title: Text(
          "الخريطة",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: LigthColor.maingreencolor,
              fontFamily: "Rubik"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: didDispose == false
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    // padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      markers: _markers.values.toSet(),
                      mapType: MapType.hybrid,
                      //كود اضهار المسار
                      // polylines: {
                      //   Polyline(
                      //       polylineId: PolylineId("route"),
                      //       points: polycoord,
                      //       color: Colors.red,
                      //       width: 7),
                      // },
                      // MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _gmc = controller;
                        // setState(() {
                        //   _controller.complete(controller);
                        // });
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      ...companymap!.map((company_suggestion) => Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, top: 20),
                                child: SizedBox(
                                  width: 450,
                                  //width: 260,
                                  height: 250,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new Company_Details(
                                                        id: company_suggestion
                                                            .id)));
                                        //               Navigator.push(
                                        // context,
                                        // MaterialPageRoute(
                                        //   builder: (context) => new HotelDetailsScreen(hotel:hottles.id );
                                        // print(company_suggestion.id);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: company_suggestion
                                                  .imageCompany
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            ),
                                            // Image.memory(
                                            //   base64Decode(
                                            //       company_suggestion.Data.toString()),
                                            //   fit: BoxFit.fill,
                                            // ),

                                            Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        249, 0, 0, 0),
                                                    Colors.black38,
                                                    Color.fromARGB(
                                                        66, 168, 162, 162),
                                                    Color.fromARGB(0, 0, 0, 0),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // alignment: Alignment.bottomLeft,
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 8),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                new Company_Details(
                                                                    id: company_suggestion
                                                                        .id)));
                                                    //               Navigator.push(
                                                    // context,
                                                    // MaterialPageRoute(
                                                    //   builder: (context) => new HotelDetailsScreen(hotel:hottles.id );
                                                    // print(
                                                    //     company_suggestion.id);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Color.fromARGB(
                                                        255, 25, 107, 155),
                                                    size: 28,
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 70, right: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .angleLeft,
                                                          size: 28,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {},
                                                      )),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "${company_suggestion.name}",
                                                              style: const TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                              "${company_suggestion.addressName}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                              " - ${company_suggestion.cityName}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .locationDot,
                                                            size: 18,
                                                            color: Colors.amber,
                                                          )
                                                        ],
                                                      ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.only(
                                                      //           left: 100),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment.end,
                                                      //     children: [
                                                      //       Text(
                                                      //         "${company_suggestion.}",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //                 Colors.white),
                                                      //       ),
                                                      //       SizedBox(
                                                      //         width: 2,
                                                      //       ),
                                                      //       Icon(
                                                      //         Icons.star,
                                                      //         color: Colors.amber,
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 30, left: 10),
                    alignment: const Alignment(-1, 1),
                    child: FloatingActionButton(
                      backgroundColor: LigthColor.print,
                      onPressed: () async {
                        didDispose = false;
                        await _getclientlocation().then((value) {
                          clientlat = value.latitude;
                          clientlong = value.longitude;
                          sourcelocation = LatLng(clientlat, clientlong);
                          setState(() {});
                          _livelocation();
                        });
                        _getmarker();
                        didDispose = true;
                      },
                      tooltip: ' المواقع القريبة',
                      child: Icon(
                        Icons.my_location_sharp,
                        color: LigthColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   // disabledElevation: 100,
      //   backgroundColor: LigthColor.print,
      //   onPressed: () async {
      //     didDispose = false;
      //     await _getclientlocation().then((value) {
      //       clientlat = value.latitude;
      //       clientlong = value.longitude;
      //       sourcelocation = LatLng(clientlat, clientlong);
      //       setState(() {});
      //       _livelocation();
      //     });
      //     _getmarker();
      //     didDispose = true;
      //   },
      //   tooltip: ' المواقع القريبة',
      //   child: Icon(
      //     Icons.my_location_sharp,
      //     color: LigthColor.whiteColor,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    didDispose = true;
    // _controller.dispons();
    super.dispose();
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:rafahia_app_final_emy/models/companymodels/companies._model.dart';
// import 'package:rafahia_app_final_emy/scrrens/home/components/discount_banner.dart';
// import 'package:rafahia_app_final_emy/scrrens/home/components/section_title.dart';

// import '../../../api/apiurl.dart';
// import '../../../models/companymodels/Company_model_addlist.dart';
// import '../../hotels/hotel_detial/all_detials_hotel.dart';

// class Company_Addlast extends StatefulWidget {
//   const Company_Addlast({super.key});

//   @override
//   State<Company_Addlast> createState() => Company_AddlastState();
// }

// class Company_AddlastState extends State<Company_Addlast> {
//   late List<Companyaddlast> comp_addlest = [];
//   BaseUrl _baseUrl = new BaseUrl();
//   GetCompanyaddlast _getCompanyaddlast = new GetCompanyaddlast();
//   bool didDispose = false;
//   // @override
//   // void dispose() {
//   //   didDispose = true;
//   //   super.dispose();
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _fetchdata();
//   }

//   //final String baseUrl = "http://192.168.1.102:7094";

//   Future<void> _fetchdata() async {
//     final Dio dio = new Dio();

//     try {
//       // http.Response response = await http.get(Uri.parse("$baseUrl/api/Auth/"));
//       var response = await dio
//           .get("${_baseUrl.baseurl.trim()}${_getCompanyaddlast.getcompanyaddlast.trim()}");
//       // print(response.statusCode);
//       // print(response.data);
//       var responsedata = response.data as List;
//       if (response.statusCode == 200) {
//         if (!didDispose) {
//           setState(() {
//             comp_addlest =
//                 responsedata.map((e) => Companyaddlast.fromJson(e)).toList();
//             didDispose = true;
//             //print(comp.);
//           });
//           //didDispose = true;
//         }
//       } else {
//         print(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
//             child: TextHomeMore(
//               left_botton_text: "عرض المزيد",
//               righe_text: "الاعلى تقييماً",
//               press: () {},
//             )),
//         SingleChildScrollView(
//           reverse: true,
//           scrollDirection: Axis.horizontal,
//           child: didDispose == false
//               ? Center(child: CircularProgressIndicator())
//               : Row(children: [
//                   ...comp_addlest.map((company_suggestion) => Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 20, top: 20),
//                             child: SizedBox(
//                               width: 242,
//                               height: 270,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: InkWell(onTap: () {
//                                   Navigator.push(
//                             context,
//                             new MaterialPageRoute(
//                                 builder: (context) =>
//                                     new HotelDetailsScreen(id: company_suggestion.id)));
//                         //               Navigator.push(
//                         // context,
//                         // MaterialPageRoute(
//                         //   builder: (context) => new HotelDetailsScreen(hotel:hottles.id );
//                         print(company_suggestion.id);
//                                 },
//                                   child: Stack(
//                                     children: [
//                                       Image.memory(
//                                         base64Decode(
//                                             company_suggestion.Data.toString()),
//                                         fit: BoxFit.fill,
//                                       ),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           gradient: LinearGradient(
//                                             begin: Alignment.bottomCenter,
//                                             end: Alignment.topCenter,
//                                             colors: [
//                                               Color.fromARGB(249, 0, 0, 0),
//                                               Colors.black38,
//                                               Color.fromARGB(66, 168, 162, 162),
//                                               Color.fromARGB(0, 0, 0, 0),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding:
//                                             EdgeInsets.only(top: 10, left: 8),
//                                         child: IconButton(
//                                             onPressed: () {
//                                               Navigator.push(
//                                                             context,
//                                                             new MaterialPageRoute(
//                                   builder: (context) =>
//                                       new HotelDetailsScreen(id: company_suggestion.id)));
//                                                         //               Navigator.push(
//                                                         // context,
//                                                         // MaterialPageRoute(
//                                                         //   builder: (context) => new HotelDetailsScreen(hotel:hottles.id );
//                                                         print(company_suggestion.id);
//                                             },
//                                             icon: Icon(
//                                               Icons.favorite,
//                                               color: Color.fromARGB(
//                                                   255, 25, 107, 155),
//                                               size: 28,
//                                             )),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 170, right: 15),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                                 padding: EdgeInsets.only(left: 8),
//                                                 child: IconButton(
//                                                   icon: FaIcon(
//                                                     FontAwesomeIcons.angleLeft,
//                                                     size: 28,
//                                                     color: Colors.white,
//                                                   ),
//                                                   onPressed: () {},
//                                                 )),
//                                             Column(
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     Text(
//                                                         "${company_suggestion.name}",
//                                                         style: const TextStyle(
//                                                             fontSize: 25,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white)),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     Align(
//                                                       alignment:
//                                                           Alignment.centerLeft,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 20,
//                                                     ),
//                                                     Text(
//                                                         "${company_suggestion.addressName}",
//                                                         style: const TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white)),
//                                                     SizedBox(
//                                                       width: 2,
//                                                     ),
//                                                     Text(
//                                                         "${company_suggestion.cityName}",
//                                                         style: const TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white)),
//                                                     SizedBox(
//                                                       width: 2,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     FaIcon(
//                                                       FontAwesomeIcons
//                                                           .locationDot,
//                                                       size: 18,
//                                                       color: Colors.amber,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       left: 100),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.end,
//                                                     children: [
//                                                       Text(
//                                                         "${company_suggestion.addressId}",
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 2,
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Colors.amber,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ))
//                 ]),
//         )
//       ],
//     );
//   }
// }

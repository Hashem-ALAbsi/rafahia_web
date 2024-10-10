import 'dart:convert';
import 'dart:js_interop';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rafahia_web/api/helper/api_company.dart';
import 'package:rafahia_web/api/helper/api_service.dart';
import 'package:rafahia_web/firebase_options.dart';
import 'package:rafahia_web/models/companymodels/companies_model_hight.dart';
import 'package:rafahia_web/screens/home/home_screen.dart';
import 'package:rafahia_web/screens/nav_bar.dart';

import 'models/servicemodels/service_model.dart';
import 'screens/details/detalis_company.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Nav_barr(),
      routes: {
        "homepage": ((context) => const Home_Screen()),
        "navbar": ((context) => Nav_barr()),
        "detailcompany": ((context) => Company_Details()),
      },
    );
  }
}

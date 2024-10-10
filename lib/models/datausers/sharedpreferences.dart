//import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Sharedpreferences {
  Future<int> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('pressed $counter times.');
    await prefs.setInt('counter', counter);
    return counter;
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:incdnc/service/get_it.dart';
import 'package:incdnc/time_pass.dart';

import 'app_string/pref.dart';
import 'model_class/my_http_overrides.dart';
import 'screens/homescreen.dart';
import 'screens/product_list.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.init();
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();
  var status = AppPreference.getBool("IsSignIn");
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    title: 'Figma',
    home: status==true? ProductList():const HomeScreen(),
  ));
}

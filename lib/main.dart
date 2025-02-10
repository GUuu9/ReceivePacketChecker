import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:packetchecker/screens/screen_home.dart';

void main() => runApp(
    GetMaterialApp(
      theme:  ThemeData(fontFamily: 'D2Coding'),
      home: ScreenHome(),
    )
);
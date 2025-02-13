import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_kart/Services/preferences.dart';

import 'Page/Splash_Screen_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.iniMemory();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    )
  );
}
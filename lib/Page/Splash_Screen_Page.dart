import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_kart/Page/Home_Page.dart';
import 'package:quick_kart/Page/Login_Page.dart';
import 'package:quick_kart/Services/allData.dart';
import 'package:quick_kart/Services/preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if(preferences.getIsLogin()){
          return HomePage();
        }else{
          return LoginPage();
        }
      },));
    },);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Lottie.asset(
              "${allData.animationPath}SplashScreen.json",
            ),
          ),
        ),
      ),
    );
  }
}

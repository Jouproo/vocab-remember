import 'dart:async';

import 'package:esaam_vocab/layout/layout_screen.dart';
import 'package:esaam_vocab/module/login/app_login_screen.dart';
import 'package:esaam_vocab/share/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../share/cash/cash_helper.dart';



class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 3), timerDone);
  }



  void timerDone() {
    navigateAndFinish(context,(CashHelper.getData(key: 'uId')==null)? AppLoginScreen(): LayoutScreen() ) ;
    //navigateTo(context, HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
         appBar: AppBar(
           backgroundColor: Colors.blue,
           elevation: 0.0,
             systemOverlayStyle: const SystemUiOverlayStyle(
               statusBarColor: Colors.blue,
               statusBarIconBrightness: Brightness.dark,
             ),
         ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // const Image(image: AssetImage(AppAssets.livingRoomImage),),

         Lottie.asset('icons/book.json'),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Esaam vocab".toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
            //  Theme.of(context).primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Beta version",
            style: TextStyle(
              color: Colors.black,
              //  Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

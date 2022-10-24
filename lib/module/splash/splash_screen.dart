import 'dart:async';

import 'package:esaam_vocab/share/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../layout/cubit/layout_screen.dart';
import '../../share/const/appassets.dart';

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
    navigateAndFinish(context, HomeScreen());
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
        ],
      ),
    );
  }
}

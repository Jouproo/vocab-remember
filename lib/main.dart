import 'package:bloc/bloc.dart';
import 'package:esaam_vocab/share/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'layout/cubit/layout_screen.dart';
import 'module/home/home_screen.dart';
import 'module/splash/splash_screen.dart';

void main() {

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
      // ThemeData.light().copyWith(
      //   primaryColor: const Color(0xFF42A5F5),
      // ),
      ThemeData(
        primaryColor:const Color(0xFF42A5F5),
       // primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
       appBarTheme: const AppBarTheme(
         backgroundColor: Colors.white,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
         statusBarIconBrightness: Brightness.dark,

       ),
           ) ,


      ),
      home:   SplashScreen(),
    );
  }
}


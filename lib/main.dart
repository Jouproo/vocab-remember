import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/layout_screen.dart';
import 'package:esaam_vocab/share/bloc_observer.dart';
import 'package:esaam_vocab/share/cash/cash_helper.dart';

import 'package:esaam_vocab/user_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'layout/cubit/layout_cubit.dart';
import 'layout/cubit/states.dart';
import 'module/Words/words_screen.dart';
import 'module/home/home_screen.dart';
import 'module/login/app_login_screen.dart';
import 'module/register/app_register_screen.dart';
import 'module/settings/settings_screen.dart';
import 'module/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CashHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       return   BlocProvider(
          create:  (BuildContext context) => AppCubit()..getUserData()..getWords()..createDatabase(),
            child:BlocConsumer<AppCubit,AppStates>(
              listener: (context,state){},
              builder: (context,stat){
                AppCubit cubit = AppCubit.get(context);
                return  MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme:
                  // ThemeData.light().copyWith(
                  //   primaryColor: const Color(0xFF42A5F5),
                  // ),
                  ThemeData(
                    primaryColor: Colors.blue ,
                    // const Color(0xFF42A5F5),
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,

                      ),
                    ) ,


                  ),
                  home: (CashHelper.getData(key: 'uId')==null)? AppLoginScreen(): LayoutScreen(),
                );
              },

            )
        );




  }
}


// import 'package:bloc/bloc.dart';
// import 'package:esaam_vocab/module/Words/words_screen.dart';
// import 'package:esaam_vocab/module/favorites/favorites_screen.dart';
// import 'package:esaam_vocab/module/photos/photos_screen.dart';
// import 'package:esaam_vocab/share/cubit/states.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AppCubit  extends Cubit<AppStates>{
//
//
//   AppCubit(super.initialState);
//
//   static AppCubit get(context) => BlocProvider.of(context);
//
//
//
//   int currentIndex = 0;
//
//   List <Widget> screens =
//   [
//     FavoritesScreen(),
//     PhotosScreen(),
//     WordsScreen(),
//
//   ];
//
//   List<String> titles = [
//     'Favorites ',
//     'Photos',
//     'Words',
//   ];
//
//   void changeIndex(int index) {
//     currentIndex = index;
//     emit(AppChangeBottomNavBarState());
//   }
//
//
//
//
//
//
// }
import 'package:bloc/bloc.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/module/Words/words_screen.dart';
import 'package:esaam_vocab/module/favorites/favorites_screen.dart';
import 'package:esaam_vocab/module/photos/photos_screen.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../module/home/home_screen.dart';

class LayoutCubit  extends Cubit<LayoutStates>{

  LayoutCubit(): super(AppInitialState()) ;


  static LayoutCubit get(context) => BlocProvider.of(context);



  int currentIndex = 0;

  List <Widget> screens =
  [
     Layout(),
     WordsScreen(),
     FavoritesScreen(),
     PhotosScreen(),
  ];

  List<String> titles = [
    'Home'
    'Words',
    'Favorites ',
    'Photos',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  bool showDefinition = false ;
  List<int> id = [];
  void changeShowDefinition({required int id,index }){
    if(words[index]['definitionStatus'] =='false'){
      updateData(status: 'true', id: id, item:'definitionStatus');
    }else{
      updateData(status: 'false', id: id, item:'definitionStatus');
    }

    emit(ChangeShowDefinition());
  }


  bool isFavorite = false ;

  void changeFavorite({required int id,required index}){
    if(words[index]['status'] =='new'){
      updateData(status: 'favorite', id: id, item:'status');
    }else{
      updateData(status: 'new', id: id, item:'status');
    }
    emit(ChangeFavoriteState());
    isFavorite = !isFavorite;
  }

  Database ? database;
  List<Map> words = [];
  List<Map> favorites = [];

  void createDatabase() {
    openDatabase(
      'vocab.db',
      version: 1,
      onCreate: (database, version) {

        print('database created');
        database.execute(
            'CREATE TABLE vocabulary ('
                'id INTEGER PRIMARY KEY, word TEXT, definition TEXT, '
                'name TEXT,status TEXT,definitionStatus TEXT )')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future<void> insertToDatabase({
   required String word,
    required String definition,
    required String name,
  }) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO vocabulary(word, definition, name,status,definitionStatus)'
            ' VALUES("$word", "$definition", "$name","new","false")',
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

    });
  }

  void getDataFromDatabase(database)
  {
    words = [];
    favorites = [];

    //emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM vocabulary').then((value) {

      value.forEach((element)
      {
          words.add(element);

          if(element['status'] == 'favorite'){
            favorites.add(element);
          }

      });
      print(words.toString());
      emit(AppGetDatabaseState());
    });
  }

  void deleteData({
     required int   id,
  }) async
  {
    database!.rawDelete('DELETE FROM vocabulary WHERE id = ?', [id])

        .then((value)
    {
      print('deleted');
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
    required item
  }) async
  {
    database!.rawUpdate(
      'UPDATE vocabulary SET $item = ? WHERE id = ?',
      [status, id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }


  ImageProvider<Object> getProfilePhoto() {
    final imageUrl = FirebaseAuth.instance.currentUser!.photoURL;
    if (imageUrl == null) {
      return const AssetImage('icons/profile.png');
    }
    return NetworkImage(imageUrl);
  }







}
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/model/word_model.dart';
import 'package:esaam_vocab/module/Words/words_screen.dart';
import 'package:esaam_vocab/module/favorites/favorites_screen.dart';
import 'package:esaam_vocab/module/login/app_login_screen.dart';
import 'package:esaam_vocab/module/photos/photos_screen.dart';
import 'package:esaam_vocab/share/cash/cash_helper.dart';
import 'package:esaam_vocab/share/components/components.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:esaam_vocab/share/const/colors/configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/image_word_model.dart';
import '../../model/user_model.dart';
import '../../module/home/home_screen.dart';
import '../../try.dart';

class AppCubit  extends Cubit<AppStates>{

  AppCubit(): super(AppInitialState()) ;


  static AppCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;

  final fireStore = FirebaseFirestore.instance;



  int currentIndex = 0;

  List <Widget> screens =
  [
     HomeScreen(),
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
                'name TEXT,wId TEXT,status TEXT,definitionStatus TEXT )')
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
     String ? name,
    String ? wId ,
    required String  status
  }) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO vocabulary(word, definition, name,wId,status,definitionStatus)'
            ' VALUES("$word", "$definition", "$name", "$wId","$status","false")',
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
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM vocabulary').then((value) {

      value.forEach((element)
      {
          if(element['status'] == 'favorite'){
            favorites.add(element);
          }else{
            words.add(element);
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

   bool isEmpty = false ;

  List<Map>  fav = [];

   Future<List<Map<String, dynamic>>?> searchScoutsMap( String word,  String definition) async {
    fav = [];
    Database ? db = database;
    print("This works? $db");
    var result = await db?.rawQuery(
        "SELECT * FROM vocabulary  WHERE word  Like '%$word%' AND definition Like '%$definition%'");
    debugPrint("result is working? $result");
        if(result!.isNotEmpty){
             fav = result ;
           }
       return result;
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
    final imageUrl = auth.currentUser?.photoURL;
    if (imageUrl == null) {
      return const AssetImage('icons/profile.png');
    }
    return NetworkImage(imageUrl);
  }

  String getName() {
    final name =  auth.currentUser!.displayName;
    if (name == null) {
      return ' ' ;
    }
   // emit(AppGetNameSuccessState());
    return name;
  }

  UsersModel ? userModel;

    void getUserData(){

      emit(AppGetUserLoadingState());

      fireStore.collection('users').doc(auth.currentUser?.uid)
          .get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
     // print('Document data: ${documentSnapshot.data()}');
      userModel = UsersModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>);
      debugPrint(userModel!.toMap().toString());
      emit(AppGetUserSuccessState());

      } else {
      debugPrint('Document does not exist on the database');
      }
      });
    }

  void createNewWord ({
    String ? dateTime,
    required String ? wordText,
    required String ? definitionText,
     String ? level,
    String ? session,
   }){
    emit(AppCreateWordLoadingState());
    CollectionReference words = fireStore.collection('Words');
    final ref = fireStore.collection('Words').doc();
    WordModel model = WordModel(
      name:userModel?.name,
      uId: userModel?.uId,
      dateTime: dateTime,
      wordText: wordText,
      definitionText: definitionText,
      isFavorite: isFavorite,
      level: level,
      session: session,
      wId: ref.id
    );

// upload the data and include docID in it

    words.doc(ref.id).set(model.toMap()).then((value) {
     // model.wId=value.id;
      debugPrint('id word  ${ref.id}');
      // debugPrint(' id word ${value.id}');
      getWords();
      emit(AppCreateWordSuccessState());

       }).catchError((e){
         showToast(msg: e );
         emit(AppCreateWordErrorState(e));
    });
     //   words.add(model.toMap()).then((value) {
     //     model.wId=value.id;
     //     debugPrint('id word  ${ words.firestore.collection('words').id}');
     //     id = value.id ;
     //    // debugPrint(' id word ${value.id}');
     //   getWords();
     //   debugPrint(value.toString());
     //   emit(AppCreateWordSuccessState());
     //    // debugPrint(' id word ${model.wId}');
     // });
  }


  List<WordModel>  allWords = [];

  void getWords(){
    allWords = [];
    fireStore.collection('Words').orderBy('dateTime').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
      //  debugPrint(doc.id);
        allWords.add(WordModel.fromJson(doc.data()! as Map<String, dynamic> )) ;
      });
      emit(AppGetWordSuccessState());
      debugPrint(' allWords  ${allWords.length}  ');
       debugPrint(allWords[1].toMap().toString());
    }).catchError((e){
      debugPrint(e.toString());
       emit(AppGetWordErrorState());
    });

  }

  void getLevelOrderWords({required String level}){
    allWords = [];
    fireStore.collection('Words')
        .where('level', whereIn: [level]).orderBy('dateTime').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //  debugPrint(doc.id);
        allWords.add(WordModel.fromJson(doc.data()! as Map<String, dynamic> )) ;
      });
      emit(AppGetWordSuccessState());
      debugPrint(' allWords  ${allWords.length}  ');
      debugPrint(allWords[1].toMap().toString());
    }).catchError((e){
      debugPrint(e.toString());
      emit(AppGetWordErrorState());
    });

  }


  void removeWord({required String wId ,required String rUid}){
     CollectionReference words = fireStore.collection('Words');
     uId= CashHelper.getData(key: 'uId');
     if(rUid==uId){
       words.doc(wId).delete()
           .then((value) {
         emit(AppRemoveWordSuccessState());
         getWords();
         showToast(msg: 'success Deleted ');
         debugPrint(" Deleted success");
       }).catchError((error) {
         emit(AppRemoveWordErrorState());
         debugPrint("Failed to delete user: $error");
       });
     }else{
       showToast(msg: 'Not allowed');
     }
}

  List<WordModel>  allSearchWords = [];

  void searchFromFirebase(String query)  {
    allWords = [];
      fireStore.collection('Words')
        .orderBy('text')
        .startAt([query])
        .endAt([query+'\uf8ff'])
        .get().then((QuerySnapshot querySnapshot) {
       querySnapshot.docs.forEach((doc) {
      //   allWords.where((element) => seen.add(WordModel.fromJson(doc.data()! as Map<String, dynamic> )));
         allWords.add(WordModel.fromJson(doc.data()! as Map<String, dynamic> )) ;
       });

      // var seen = Set<String>();
      // List<WordModel> searchWords = allWords.where((words) => seen.add(words.wordText!)).toList();
       debugPrint(allSearchWords.toString());
       emit(AppGetWordSuccessState());
       debugPrint(' allWords  ${allSearchWords.length}  ');
     }).catchError((e){
       debugPrint(e.toString());
       emit(AppGetWordErrorState());
     });

  }

  void allWordsSearch({required String query, })  {
    allSearchWords = [];
    var matchNames =  allWords.where((element) =>element.wordText!.contains(query))
        .map((e) => e );
    //allWords.where(p => p["name"].contains(search)).map(p => p["name"]);
    String result = "";
    for (var element in matchNames) {
      allSearchWords.add(element);
      debugPrint(element.wordText);

    }
    debugPrint('${allSearchWords.length}');


    debugPrint(result);
       emit(AppGetWordSuccessState());

  }

  List<Map>  yourSearchWords = [];

  void yourWordsSearch({required String query,})  {
    yourSearchWords = [];
    var matchNames =  words.where((element) =>element['word']!.contains(query))
        .map((e) => e );
    // words.where(p => p['word'].contains(query)).map(p => p["name"]);
    for (var element in matchNames) {
      yourSearchWords.add(element);
      debugPrint(element['word']);
    }
    debugPrint('${yourSearchWords.length}');

    emit(AppGetWordSuccessState());

  }


  bool isSearch = false ;

  void changSearchState(){
    isSearch = !isSearch ;
    emit(ChangeSearchState());

  }


  void doFalseSearch(){
    isSearch = false ;
    emit(ChangeSearchState());

  }

  bool isSetting = false ;

  void changeSettingState(){
    isSetting = !isSetting ;
    emit(ChangeSearchState());

  }




  Future<void> signOut({required BuildContext context}) async {
    try {

      await GoogleSignIn().signOut().then((value) {
        CashHelper.removeData(key: 'uId');
        emit(SinOutSuccessState());
        navigateTo(context, AppLoginScreen());
      });
      await auth.signOut().then((value) {
        emit(SinOutSuccessState());
        navigateTo(context, AppLoginScreen());
      });

    } on Exception catch (e) {
      emit(SinOutErrorState(e.toString()));
      showToast(msg: 'Logout Is Not Success');
      'Exception @signout: $e';
    }
  }


  File ? wordImage;
  var picker = ImagePicker();

  Future<void> getImage({bool isCamera = false}) async {
    final pickedFile = await picker.pickImage(
      source: (isCamera)? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      wordImage = File(pickedFile.path);
      emit(AppImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
    emit(AppImagePickedErrorState());
    }
  }

  void removeWordImage()
  {
    wordImage = null;
    emit(SocialRemovePostImageState());
  }


  void createImageWord({
    required String dateTime,
     String ? definitionText,
    String ? level,
   required String  wordImage,

  }) {
    emit(AppCreateWordImageLoadingState());
    CollectionReference words = fireStore.collection('WordImages');
    final ref = fireStore.collection('WordImages').doc();

    ImageWordModel model = ImageWordModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      wordImage: wordImage,
      definitionText: definitionText ?? '',
      level: level ?? '',
      wId: ref.id
    );

    words.doc(ref.id).set(model.toMap()).then((value) {
      // model.wId=value.id;
      debugPrint('id word  ${ref.id}');
       // debugPrint();
      getWordImage();
      emit(AppCreateWordImageSuccessState());

    }).catchError((e){
      emit(AppCreateWordImageErrorState());
      showToast(msg: e);
    });

  }

  void uploadWordImage({
    required String dateTime,
     String ? text,
     String ? level,
  })
  {
    emit(AppCreateWordImageLoadingState());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('wordImage/${Uri.file(wordImage!.path).pathSegments.last}')
        .putFile(wordImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        createImageWord(
          definitionText:text ,
          dateTime: dateTime,
          wordImage: value,
          level: level
        );
      }).catchError((error)
      {
        debugPrint(error);
      });
    }).catchError((error)
    {
      emit(AppCreateWordImageErrorState());
    });
  }


  List <ImageWordModel> wordImages = [];
  List <String> postsId = [];

  void getWordImage()
  {
    wordImages=[];
    fireStore.collection('WordImages').orderBy('dateTime').get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
          debugPrint(doc.id);
        wordImages.add(ImageWordModel.fromJson(doc.data()! as Map<String, dynamic> )) ;
      }
      emit(AppGetWordImageSuccessState());
      debugPrint(' wordImages  ${wordImages.length}  ');
      debugPrint(wordImages[1].toMap().toString());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AppGetWordImageErrorState());
    });
  }


  void deleteWordImage({required String wId ,required String rUid ,required String wordImage}){
    CollectionReference words = fireStore.collection('WordImages');
    uId= CashHelper.getData(key: 'uId');
    if(rUid==uId){
      words.doc(wId).delete().then((value) {
        firebase_storage.FirebaseStorage.instance.refFromURL(wordImage).delete();
        emit(AppRemoveWordSuccessState());
        getWordImage();
        showToast(msg: 'success Deleted ');
        debugPrint(" Deleted success");
      }).catchError((error) {
        emit(AppRemoveWordErrorState());
        debugPrint("Failed to delete user: $error");
      });
    }else{
      showToast(msg: 'Not allowed');
    }
  }


  Future<void> downloadImage(String wordImage ) async {
         emit(AppDownloadImageLoadingState());
       final storage  = firebase_storage.
       FirebaseStorage.instance.refFromURL(wordImage);
       final url = wordImage ;
       storage.getDownloadURL().toString();
       final  name =  storage .name ;
       debugPrint('url is   ${url}');
     final tempDir = await getTemporaryDirectory();
     final path = '${tempDir.path}/$name' ;
     await Dio().download(url, path).then((value) {
       emit(AppDownloadImageSuccessState());
       GallerySaver.saveImage(path,toDcim: true);
     }).catchError((onError){
       emit(AppDownloadImageErrorState());
       debugPrint(onError);
     });



    //First you get the documents folder location on the device...
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    //Here you'll specify the file it should be saved as
  //  File downloadToFile = File('${appDocDir.path}/downloaded-pdf.pdf');
    //Here you'll specify the file it should download from Cloud Storage
    // String fileToDownload = 'uploads/uploaded-pdf.pdf';

    //Now you can try to download the specified file, and write it to the downloadToFile.

     }






  }









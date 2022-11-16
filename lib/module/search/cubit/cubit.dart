
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/module/search/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/word_model.dart';


class AppSearchCubit extends Cubit<AppSearchStates> {

  AppSearchCubit() : super(SearchInitialState());


  static AppSearchCubit get(context) => BlocProvider.of(context);

  List<WordModel>  searchWords = [];

  void searchFromFirebase(String query)  {
    searchWords = [];
    FirebaseFirestore.instance
        .collection('Words')
        .orderBy('text')
        .startAt([query])
        .endAt([query+'\uf8ff'])
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //  debugPrint(doc.id);
        searchWords.add(WordModel.fromJson(doc.data()! as Map<String, dynamic> )) ;
      });
      emit(AppGetSWordSuccessState());
      debugPrint(' allWords  ${searchWords.length}  ');
    }).catchError((e){
      debugPrint(e.toString());
      emit(AppGetSWordErrorState(e));
    });

  }

 


}

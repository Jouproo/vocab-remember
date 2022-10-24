import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/module/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_model.dart';






class AppRegisterCubit extends Cubit<AppRegisterStates> {

  AppRegisterCubit() : super(AppRegisterInitialState());




  static AppRegisterCubit get(context) => BlocProvider.of(context);


  bool isObscure = true;


  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isObscure = !isObscure;
    suffix = isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppRegisterChangePasswordVisibilityState());
  }

  void userRegister({
        required String name,
        required String  email,
        required String password,
        required String phone,

      }) {
    emit(AppRegisterLoadingState());
           FirebaseAuth.instance.createUserWithEmailAndPassword(
               email: email,
               password: password
                ).then((value) {
                    createUser(
                     name: name,
                     email: email,
                     userId: value.user!.uid,
                     phone: phone);
               emit(AppRegisterSuccessState());
               }).catchError((error){
                 emit(AppRegisterErrorState(error));
           });
  }

  void createUser({
    required String name,
    required String  email,
    required String userId,
    required String phone,
  }){
    UsersModel model =  UsersModel(
        name: name,
        email: email,
        phone:  phone,
        uId: userId);

     FirebaseFirestore.instance.collection('users').doc(userId)
         .set(model.toMap()).then((value) {
           emit(AppUserCreateSuccessState());
     }).catchError((onError){
       emit(AppUserCreateErrorState(onError));
     });
  }



}



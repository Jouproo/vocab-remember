import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/module/register/cubit/states.dart';
import 'package:esaam_vocab/share/components/components.dart';
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

  Future<void> userSignUp({
        required String name,
        required String  email,
        required String password,
    required BuildContext context
      })   async {
    emit(AppRegisterLoadingState());
    try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                 email: email,
                 password: password
                  );
         createUser(
             name: name,
             email: email,
             userId: FirebaseAuth.instance.currentUser!.uid,
         );
    }on Exception catch (e) {
       debugPrint(' run typ  ${e.runtimeType}') ;
      emit(AppRegisterErrorState(e.toString()));
      log('Exception @createAccount: $e');
      showError(error: e, context: context,color:Colors.redAccent );

    }
    //        FirebaseAuth.instance.createUserWithEmailAndPassword(
    //            email: email,
    //            password: password
    //             )
    //         .then((value) {
    //                 createUser(
    //                  name: name,
    //                  email: email,
    //                  userId: value.user!.uid,
    //                 );
    //            emit(AppRegisterSuccessState());
    //
    //            }).catchError((error)  {
    //          debugPrint(error);
    //            emit(AppRegisterErrorState(error));
    //              //debugPrint(error);
    //            log('Exception @createAccount: $error');
    //            showError(error: error, context: context,color:Colors.redAccent );
    //        });
  }




  void createUser({
    required String name,
    required String  email,
    required String userId,

  }){
    UsersModel model =  UsersModel(
        name: name,
        email: email,
        uId: userId,
    );

     FirebaseFirestore.instance.collection('users').doc(userId)
         .set(model.toMap()).then((value) {
           emit(AppUserCreateSuccessState());
     }).catchError((onError){
       emit(AppUserCreateErrorState(onError));
     });
  }

  // _showDialog({required error, required BuildContext context}) {
  //   if (error.runtimeType == NoSuchMethodError) {
  //     error = 'UnIdentified Error!';
  //   } else if (error.runtimeType != String) {
  //     error = (error?.message != null) ? error?.message : 'UnIdentified Error';
  //   }
  //   final snackBar = SnackBar(content: Text('ERROR: $error'));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

}



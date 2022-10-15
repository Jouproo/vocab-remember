import 'package:esaam_vocab/module/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../shop_login_screen.dart';


class AppLoginCubit extends Cubit<AppLoginStates> {

  AppLoginCubit() : super(LoginInitialState());


  static AppLoginCubit get(context) => BlocProvider.of(context);

  //SocialLoginModel ? loginModel ;
  bool isObscure = true;


  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isObscure = !isObscure;
    suffix = isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password).then((value) {
                  emit(AppLoginSuccessState(value.user!.uid));
                  print(value.user!.uid);
                  }).catchError((error){
                   emit(AppLoginErrorState(error.toString()));
                  });


  }
}

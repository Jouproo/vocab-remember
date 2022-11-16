
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/module/login/cubit/states.dart';
import 'package:esaam_vocab/share/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../../model/user_model.dart';
import '../app_login_screen.dart';


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

  void userLogin({required String email, required String password,required context}) {
    emit(AppLoginLoadingState());
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password ).then((value) {
                  emit(AppLoginSuccessState(value.user!.uid));
                  debugPrint(value.user!.uid);
                  }).catchError((error){
                   emit(AppLoginErrorState(error.toString()));
                   showError(error: error, context: context,color:Colors.red );
                  });
  }


  void createUser({
    required String name,
    required String  email,
    required String userId,
    String ? image ,

  }){
    UsersModel model =  UsersModel(
      name: name,
      email: email,
      uId: userId,
      image: image
    );

    FirebaseFirestore.instance.collection('users').doc(userId)
        .set(model.toMap()).then((value) {
      emit(AppUserCreateSuccessState());
    }).catchError((onError){
      emit(AppUserCreateErrorState(onError));
    });
  }


  // Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   try {
  //     final googleSignIn = GoogleSignIn();
  //     final account = await googleSignIn.signIn();
  //     if (account == null) {
  //       final snackBar =
  //       const SnackBar(content: Text('ERROR: Sign In cancelled by user'));
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       return null;
  //     }
  //
  //     final googleAuth = await account.authentication;
  //     final creds = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken
  //     );
  //
  //     final user = await FirebaseAuth.instance.signInWithCredential(creds);
  //     return user.user;
  //   } on Exception catch (e) {
  //     'error is $e' ;
  //     showError(error: e, context: context);
  //     return null;
  //   }
  // }


  Future<UserCredential?> signInWithGoogle() async {
    emit(AppLoginLoadingState());
    // Trigger the authentication flow
    try{

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showToast(msg: 'ERROR: Sign In cancelled by user');
        return null ;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userData = FirebaseAuth.instance.currentUser;
      return await FirebaseAuth.instance.signInWithCredential(credential).
      then((value) {
        emit(AppLoginSuccessState(FirebaseAuth.instance.currentUser!.uid));
        createUser(
            name: userData!.displayName.toString(),
            email: userData.email.toString(),
            userId: userData.uid ,
            image: userData.photoURL
        );

       return null;
      });

    } on FirebaseException catch (e){
      emit(AppLoginErrorState(e.toString()));
          debugPrint(e.toString());
          // if(e.code == '')
          showToast(msg: e.toString());
    }
    return null;


  }




//   void userdata() {
//
//   final userData = FirebaseAuth.instance.currentUser;
//   createUser(
//       name: userData!.displayName.toString(),
//       email: userData.email.toString(), userId: FirebaseAuth.instance.currentUser!.uid);
// }



}

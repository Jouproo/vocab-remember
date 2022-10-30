import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/layout_screen.dart';
import '../../share/cash/cash_helper.dart';
import '../../share/components/bottom_bar_textfield.dart';
import '../../share/components/components.dart';
import '../../share/const/colors/configs.dart';
import '../register/cubit/states.dart';
import '../register/app_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

const loginSVG = 'icons/svgVectors/login.svg';

const googleLogo = 'icons/svgVectors/googleLogo.svg';
class AppLoginScreen extends StatelessWidget {

  var   emailController = TextEditingController();
  var  passwordController = TextEditingController();
  var  nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit,AppLoginStates>(
          listener: (context,state){
            if (state is AppLoginSuccessState){
              CashHelper.saveData
                  (
                  key: 'uId',
                  value: state.uId
                  ).
                   then((value) {
                     navigateAndFinish(context,  HomeScreen());

              });
              showToast(msg: 'Login success ',color: Colors.green);
            }
          },
          builder: (context,state){
            AppLoginCubit cubit = AppLoginCubit.get(context);
            return
              Scaffold(

                body:  SafeArea(
                  child: ListView(
                    children:   [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                        child: GestureDetector(
                          onTap: () {
                           navigateTo(context, AppRegisterScreen());
                          },
                          child: const Text(
                            'Sign Up',
                            style: kSmallTextStyle,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                             // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    loginSVG,
                                    width: 250.0,
                                    // color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                BottomBarTextField(
                                  controller: emailController,
                                  onChanged: (String value){
                                    debugPrint(value);
                                  },
                                  errorText:'email is Empty ',
                                  verMargin: 0.0,
                                  horMargin: 0.0,
                                  hint: 'Enter your email',
                                  icon: Icon(
                                    Icons.email,
                                    // FontAwesomeIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  inputType: TextInputType.emailAddress,
                                  label: 'Email',
                                  isPassword: false,

                                ),
                                const SizedBox(height: 20,),
                                BottomBarTextField(
                                  controller: passwordController,
                                  onChanged: (String value){
                                    debugPrint(value);
                                  },
                                  errorText:'Password is Empty ',
                                  verMargin: 0.0,
                                  horMargin: 0.0,
                                  hint: 'Enter your password',
                                  icon: Icon(
                                    Icons.lock,
                                    // FontAwesomeIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  inputType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  label: 'Password',


                                ),
                                const SizedBox(height: 10,),
                                ConditionalBuilder(
                                  condition: state is! AppLoginLoadingState,
                                  //AppLoginLoadingState,
                                  builder: (context) => defaultButton(
                                    backgroundColor: Colors.blue,
                                    text: 'Login',
                                    width: double.infinity,
                                    high: 60,
                                    onPressedFunction: (){
                                      if(formKey.currentState!.validate()){
                                        cubit.userLogin(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text
                                        );

                                      }
                                      // emailController.clear();
                                      // passwordController.clear();
                                    },

                                    radius: 05,
                                  ),
                                  fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                                ),
                                const Center(
                                  child:  Text(
                                    'Or Sign In via',
                                    textAlign: TextAlign.center,
                                    style: kSmallTextStyle,
                                  ),
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      cubit.signInWithGoogle();
                                    //  cubit.userdata();
                                      // final user =
                                      // await cubit.signInWithGoogle(context: context);
                                      // if (user != null) {
                                      //  // FirestoreInterface().addUser();
                                      //    navigateAndFinish(context, HomeScreen());
                                      //
                                      // }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: SvgPicture.asset(
                                        googleLogo,
                                        width: 37.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                )


              );
          }    )

    );
  }

}

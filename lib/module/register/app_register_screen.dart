import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../../layout/layout_screen.dart';
import '../../share/components/bottom_bar_textfield.dart';
import '../../share/components/components.dart';
import '../../share/const/appassets.dart';
import '../../validators/password.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

const signUpSVG = 'icons/svgVectors/SignUp.svg';


class AppRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  String ? email,  password  , name;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit,AppRegisterStates>(
          listener: (context,state){
              if (state is AppUserCreateSuccessState){
                navigateAndFinish(context,  LayoutScreen());
              }
              else if (state is AppRegisterErrorState){
                    showToast(msg: state.error);
              }
          },
          builder: (context,state){
            AppRegisterCubit cubit = AppRegisterCubit.get(context);
            return
            Scaffold(

              body: SafeArea(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 00.0, left: 20.0),
                      child: IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                            Icons.arrow_back
                        ) ,
                        color: Colors.blue,

                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: SingleChildScrollView(
                         child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children:   [
                              Center(
                                child: SvgPicture.asset(
                                  AppAssets.signUpSVG,
                                  width: 230.0,
                                  // color: Colors.blueAccent,
                                ),
                              ),
                              BottomBarTextField(
                               // controller: nameController,
                                onChanged: (String value){
                                  name = value ;
                                  if (kDebugMode) {
                                    print(email);
                                  }
                                },
                                errorText:'name ',
                                verMargin: 0.0,
                                horMargin: 0.0,
                                hint: 'Enter your name',
                                icon: Icon(
                                  Icons.person,
                                  // FontAwesomeIcons.lock,
                                  color: Theme.of(context).primaryColor,
                                ),
                                inputType: TextInputType.name,
                                label: 'Name',

                              ),
                              const SizedBox(height: 20,),
                              BottomBarTextField(
                                //controller: emailController,
                                onChanged: (String value){
                                  email = value ;
                                  if (kDebugMode) {
                                    print(email);
                                  }
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

                              ),
                              const SizedBox(height: 20,),
                              BottomBarTextField(
                             //   controller: passwordController,
                                onChanged: (String value){
                                  password = value ;
                                  print(password);
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
                              const SizedBox(height: 20,),
                              ConditionalBuilder(
                                condition: state is! AppRegisterLoadingState,
                                //AppLoginLoadingState,
                                builder: (context) => defaultButton(
                                  backgroundColor: Colors.blue,
                                  text: 'Sign Up',
                                  width: double.infinity,
                                  high: 60,
                                  onPressedFunction: (){
                                    if(formKey.currentState!.validate()){
                                      cubit.userSignUp(
                                          email: email!,
                                          password: password! ,
                                          name: name!,
                                          context: context
                                      );}
                                    // emailController.clear();
                                    // passwordController.clear();
                                  },

                                  radius: 05,
                                ),
                                fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                              ),


                            ],
                          ),
                    ),
                       ),
                     ),
                  ],

                ),
              ),

            );
          }    )

    );
  }
}

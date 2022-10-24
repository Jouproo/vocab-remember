import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/layout_screen.dart';
import '../../share/cash/cash_helper.dart';
import '../../share/components/components.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLoginScreen extends StatelessWidget {

  var   emailController = TextEditingController();
  var  passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit,AppLoginStates>(
          listener: (context,state){
            if(state is AppLoginErrorState){
              showToast(msg: state.error,color: Colors.red);
            }else if (state is AppLoginSuccessState){
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
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:   [
                          const Text('LOGIN',style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          const SizedBox(height: 20,),
                          const Text('Login to Browser',style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey
                          ),),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                              controller:emailController,
                              textInputType:TextInputType.emailAddress,
                              prefix: Icons.email,
                              label: 'Email Address ',
                              hint: 'Enter Email Address ',
                              validateText: 'Email Address is Empty ',
                              onChang: (value){
                                debugPrint(value);
                              },
                              onSubmit: (value){
                                debugPrint(value);
                              }
                          ),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                            controller:passwordController,
                            textInputType:TextInputType.visiblePassword,
                            prefix: Icons.lock,
                            label: 'Password ',
                            hint: 'Enter Password',
                            validateText: 'Password is Empty ',
                            onChang: (value){
                              debugPrint(value);
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text );
                              }
                            },
                            suffixFunction: (){
                           cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isObscure,
                            suffix: cubit.suffix
                          ),
                          const SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition: state is! AppLoginLoadingState,
                             builder: (context) => defaultButton(
                               backgroundColor: Colors.blue,
                               text: 'Login',
                               width: double.infinity,
                               onPressedFunction: (){
                                 if(formKey.currentState!.validate()){
                                   cubit.userLogin(
                                       email: emailController.text,
                                       password: passwordController.text );
                                 }

                                 // emailController.clear();
                                 // passwordController.clear();
                               },
                               radius: 10,
                             ),

                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, AppRegisterScreen());
                                },
                                child: const Text(
                                  'Register Now',
                                ),
                              ),],),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

            );
          }    )

    );
  }

}

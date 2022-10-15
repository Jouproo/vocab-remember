import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../layout/layout_screen.dart';
import '../../share/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit,AppRegisterStates>(
          listener: (context,state){
              if (state is AppUserCreateSuccessState){
                navigateAndFinish(context,  HomeScreen());
              }
          },
          builder: (context,state){
            AppRegisterCubit cubit = AppRegisterCubit.get(context);
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
                          const Text('Register',style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          const SizedBox(height: 20,),
                          const Text('Register now ',style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey
                          ),),
                          SizedBox(height: 20,),

                          defaultTextFormField(
                              controller:nameController,
                              textInputType:TextInputType.name,
                              prefix: Icons.person,
                              label: 'Name ',
                              hint: 'Enter Your Name',
                              validateText: 'Your Name is Empty ',
                              // onChang: (value){
                              //   debugPrint(value);
                              // },
                              // onSubmit: (value){
                              //   debugPrint(value);
                              // }
                          ),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                              controller:emailController,
                              textInputType:TextInputType.emailAddress,
                              prefix: Icons.email,
                              label: 'Email Address ',
                              hint: 'Enter Email Address ',
                              validateText: 'Email Address is Empty ',
                          ),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                            controller:passwordController,
                            textInputType:TextInputType.visiblePassword,
                            prefix: Icons.lock,
                            label: 'Password ',
                            hint: 'Enter Password',
                            validateText: 'Password is Empty ',

                            suffixFunction: (){
                           cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isObscure,
                            suffix: cubit.suffix
                          ),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                            controller:phoneController,
                            textInputType:TextInputType.phone,
                            prefix: Icons.phone,
                            label: 'Phone Number ',
                            hint: 'Enter Your Phone Number ',
                            validateText: 'Your Phone Number is Empty ',
                            // onSubmit: (value){
                            //   if(formKey.currentState!.validate()){
                            //     cubit.userRegister(
                            //       email: emailController.text,
                            //       password: passwordController.text ,
                            //       name: nameController,
                            //       phone: phoneController,
                            //     );
                            //   }
                            // },
                          ),
                          const SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition: state is! AppRegisterLoadingState,
                            //AppLoginLoadingState,
                             builder: (context) => defaultButton(
                               backgroundColor: Colors.blue,
                               text: 'Register',
                               width: double.infinity,
                               onPressedFunction: (){
                                 if(formKey.currentState!.validate()){
                                   cubit.userRegister(
                                     email: emailController.text,
                                     password: passwordController.text ,
                                     name: nameController.text,
                                     phone: phoneController.text,
                                   );}
                                 // emailController.clear();
                                 // passwordController.clear();
                               },
                               radius: 10,
                             ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),


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

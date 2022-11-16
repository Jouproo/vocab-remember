import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../share/components/components.dart';

class AddNewPhoto extends StatelessWidget {
   AddNewPhoto({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var definitionController = TextEditingController();
   var levelController = TextEditingController();
  var photoController = TextEditingController();
  var dateController = TextEditingController();
  var searchController = TextEditingController();

  bool inUpload = false ;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
          if(state is AppCreateWordImageSuccessState){
            showToast(msg: 'Success ' , color: Colors.green);
            Navigator.of(context).pop();
            AppCubit.get(context).removeWordImage();
          }
          if(state is AppCreateWordImageLoadingState){
            inUpload = true ;
          }
          if(state is AppCreateWordErrorState){
            showToast(msg: state.error.toString(),color: Colors.red);
          }

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            appBar: AppBar(
              leading:   IconButton(
                onPressed:() {
                    Navigator.of(context).pop();
                },
                icon:  Icon(Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),


              ),
              title: const Text('Add Photo' ,style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black)),
              actions: [
                IconButton(
                  onPressed:() {
                  },
                  icon:  Icon(Icons.add_a_photo,
                    color: Theme.of(context).primaryColor,
                  ),


                ),
                IconButton(
                  onPressed:() {
                  },
                  icon:  Icon(Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),


                ),

              ],
              elevation: 3.0,
            ),
            body:  ConditionalBuilder(
                condition: inUpload == false ,
                builder:(context)=> SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                   border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),
                               // InputBorder.none,
                                hintText: 'Add Description or Definition if you have ',
                                hintStyle: Theme.of(context).textTheme.caption,
                                prefixIcon:Icon(Icons.description_outlined) ,

                              ),
                              controller: definitionController,
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  border:  OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                //InputBorder.none,
                                hintText: 'Add leve ?  ',
                                hintStyle: Theme.of(context).textTheme.caption,
                                prefixIcon:Icon(Icons.star) ,

                              ),
                              controller: levelController,
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(onPressed: (){
                                        cubit.getImage();
                                      },
                                        icon:Icon( Icons.image_outlined ,
                                           size: 30,
                                          color: Theme.of(context).primaryColor,
                                        ),


                                      ),
                                       Text('Add From Gallery' ,
                                        style: TextStyle( fontWeight: FontWeight.bold ,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(onPressed: (){
                                        cubit.getImage(isCamera: true);
                                      },
                                        icon:Icon( Icons.camera_alt_outlined ,
                                          size: 30,
                                          color: Theme.of(context).primaryColor,
                                        ),

                                      ),

                                      Text('Add From Gallery' ,
                                        style: TextStyle( fontWeight: FontWeight.bold ,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  ),



                                ],
                              ),
                            )


                          ],
                        ),
                      ),

                      if(cubit.wordImage != null)
                      Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                 // height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0,),
                                  image: DecorationImage(
                                    image: FileImage(cubit.wordImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.close,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: ()
                                {
                                 cubit.removeWordImage();

                                },
                              ),
                            ],
                          ),
                        ),

                      TextButton(
                        clipBehavior:Clip.hardEdge ,
                        onPressed: () {
                          var now = DateTime.now();
                          String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                          if(cubit.wordImage==null){
                            showToast(msg: 'pleas pick image' ,
                            color: Colors.red);
                          }else{
                            cubit.uploadWordImage(
                                dateTime: formattedDate ,
                                text: definitionController.text ,
                                level: levelController.text.toUpperCase()
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          const [
                            Icon(
                              Icons.add_a_photo,
                              size: 22.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo to list',
                              style: TextStyle(
                                fontWeight: FontWeight.bold ,
                                fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                      ),
                      // defaultButton(
                      //     text: 'add to list',
                      //     onPressedFunction: (){
                      //     },
                      //      backgroundColor: Theme.of(context).primaryColor
                      //     // width:MediaQuery.of(context).size.width * 0.65
                      // ),
                    ],
                  ),
                ),
              ),
                fallback: (context)=> const Center(child: CircularProgressIndicator()),

            ),

          );
        }
    );
  }
}

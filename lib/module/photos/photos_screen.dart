import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:esaam_vocab/module/photos/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../share/components/components.dart';

class PhotosScreen extends StatelessWidget {

   PhotosScreen({Key? key}) : super(key: key);


bool inDownload = false ;

  @override
  Widget build(BuildContext context) {

   return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
          if(state is AppDownloadImageLoadingState){
            inDownload = true ;
          }else{
            inDownload = false ;
          }

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(

            appBar: AppBar(

              title: const Text('Photos' ,style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black)),
              actions: [
                IconButton(
                  onPressed:() {
                    navigateTo(context , AddNewPhoto());
                  },
                  icon:  Icon(Icons.add_a_photo,
                    color: Theme.of(context).primaryColor,
                  ),


                ),
                IconButton(
                  onPressed:() {
                    showToast(msg: 'there is no search' , color:  Colors.amber);
                  },
                  icon:  Icon(Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),


                ),

              ],
              elevation: 3.0,
            ),
            body:   ConditionalBuilder(
          condition: cubit.wordImages.isNotEmpty  || cubit.userModel != null,
            builder:(context)=> SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(inDownload == true)
                  const LinearProgressIndicator(color: Colors.red ),
                  ListView.separated(
                    // reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildWordImageItem(cubit.wordImages[index],context,index),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemCount: cubit.wordImages.length,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          )

          );
        }
    );

  }
}

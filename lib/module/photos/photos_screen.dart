import 'package:esaam_vocab/module/photos/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../share/components/components.dart';

class PhotosScreen extends StatelessWidget {

   PhotosScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

   return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
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
                  },
                  icon:  Icon(Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),


                ),

              ],
              elevation: 3.0,
            ),
            body:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15 ,),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(
                          10.0,
                        ),
                        topStart: Radius.circular(
                          10.0,
                        ),
                        topEnd: Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    child:const Center(
                      child:  Text(
                        'photos ',
                        style: TextStyle(fontSize: 18 ,
                            fontWeight: FontWeight.bold ),
                      ),
                    ),
                  ),
                ),
              ],
            ) ,

          );
        }
    );

  }
}

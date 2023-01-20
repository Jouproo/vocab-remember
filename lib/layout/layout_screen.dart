
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {

   LayoutScreen({Key? key}) : super(key: key);

 //  var scaffoldKey = GlobalKey<ScaffoldState>();
   //var formKey = GlobalKey<FormState>();
   var wordController = TextEditingController();
   var definitionController = TextEditingController();
   var dateController = TextEditingController();



   @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
         listener: (context,state){},
         builder: (context,stat){
           AppCubit cubit = AppCubit.get(context);
           return  Scaffold(
           //  key: scaffoldKey,
             body: cubit.screens[cubit.currentIndex],

             bottomNavigationBar: BottomNavigationBar(
               type: BottomNavigationBarType.fixed,
               elevation: 0.0,
               // backgroundColor: Colors.red,
               currentIndex: cubit.currentIndex,
               onTap: (index){
                 cubit.changeIndex(index);
               },
               items: const [
                 BottomNavigationBarItem(
                   icon: Icon(
                     Icons.home,
                   ),
                   label: 'Home ',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(
                     Icons.list_alt,
                   ),
                    label: 'words ',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(
                     Icons.favorite,
                   ),
                   label: 'favorites',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(
                     Icons.photo,
                   ),
                   label: 'photos',
                 ),
               ],
             ),

           );
                 },
         );

   }
  }



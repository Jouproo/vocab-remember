
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/components/components.dart';
import 'layout_cubit.dart';

class HomeScreen extends StatelessWidget {

   HomeScreen({Key? key}) : super(key: key);

   var scaffoldKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();
   var wordController = TextEditingController();
   var definitionController = TextEditingController();
   var dateController = TextEditingController();



   @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getUserData()..getWords(),
         child:BlocConsumer<AppCubit,AppStates>(
         listener: (context,state){},
         builder: (context,stat){
           AppCubit cubit = AppCubit.get(context);
           return  Scaffold(
             key: scaffoldKey,
             body: cubit.screens[cubit.currentIndex],
             // floatingActionButton: FloatingActionButton(
             //   onPressed: (){
             //
             //     if (cubit.isBottomSheetShown){
             //
             //       if(formKey.currentState!.validate()){
             //         cubit.insertToDatabase(
             //             word: wordController.text,
             //             definition: definitionController.text,
             //             name: '',);
             //         Navigator.pop(context);
             //       }
             //
             //     }else{
             //       scaffoldKey.currentState!.showBottomSheet(
             //               (context) => Container(
             //             color: Colors.white,
             //             padding:  const EdgeInsets.all(
             //               20.0,
             //             ),
             //               child: Form(
             //               key: formKey,
             //               child: Column(
             //                 mainAxisSize: MainAxisSize.min,
             //                 children: [
             //                   defaultTextFormField(
             //                     controller: wordController,
             //                     textInputType:TextInputType.text,
             //                     validateText: 'title must not be empty',
             //                     label: 'Enter New Word',
             //                     prefix: Icons.title_outlined,
             //                     radius: 15
             //                   ),
             //                   const SizedBox(
             //                     height: 10,
             //                   ),
             //                   defaultTextFormField(
             //                     controller: definitionController,
             //                     textInputType:TextInputType.text,
             //                     label: 'Enter Definition',
             //                     prefix: Icons.title_outlined,
             //                     radius: 15
             //                   ),
             //
             //                 ],
             //               ),
             //             ),
             //           ),
             //                   elevation: 20,
             //
             //           ).closed.then((value) {
             //             cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
             //             wordController.clear();
             //             definitionController.clear();
             //       });
             //
             //       cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
             //
             //     }
             //
             //    // cubit.insertToDatabase(word: 'welcome', definition: 'its mean hello ', name: 'yousef');
             //   },
             //   child: Icon (
             //       cubit.fabIcon
             //   ),
             // ),
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

         )
    );}
  }



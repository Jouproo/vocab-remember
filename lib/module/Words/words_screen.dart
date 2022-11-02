import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/module/Words/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../share/components/components.dart';
import '../../user_test.dart';

class WordsScreen extends StatelessWidget {

   WordsScreen({Key? key}) : super(key: key);


   var scaffoldKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();
   var wordController = TextEditingController();
   var definitionController = TextEditingController();
   var dateController = TextEditingController();


   @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
       listener: (context, state){},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return
            Scaffold(
              //backgroundColor: Theme.of(context).primaryColor,
              key: scaffoldKey,
              // appBar: AppBar(
              //   elevation: 0.0,
              //   title: const Center(
              //     child:  Text('All Words' ,style: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontWeight: FontWeight.bold,
              //         fontSize: 25,
              //         color: Colors.black)),
              //   ),
              // ),
              body:   SafeArea(
                 child: Column(
                   children: [
                     const Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16.0),
                       child: Text('All Words' ,style: TextStyle(
                           fontFamily: 'Montserrat',
                           fontWeight: FontWeight.bold,
                           fontSize: 25,
                           color: Colors.black)),
                     ),
                     Expanded(
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         padding: const EdgeInsets.only(top: 5),
                         decoration: const BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(30),
                             topRight: Radius.circular(30),
                           ),
                         ),
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),

                             child: allWordsBuilder(allWords: cubit.allWords,),
                           ),
                         ),
                       ),
                     ),

                     // Expanded(
                     //   child: Container(
                     //     width: MediaQuery.of(context).size.width,
                     //     padding: const EdgeInsets.only(top: 5),
                     //     decoration: const BoxDecoration(
                     //       color: Colors.white,
                     //       borderRadius: BorderRadius.only(
                     //         topLeft: Radius.circular(30),
                     //         topRight: Radius.circular(30),
                     //       ),
                     //     ),
                     //     child: ListView.builder(
                     //             itemCount: cubit.allWords.length ,
                     //             itemBuilder: (BuildContext context, int index) {
                     //               if (index == 0) {
                     //                 return const SizedBox(
                     //                   height: 10.0,
                     //                 );
                     //               }
                     //               return WordsCard(
                     //              word:'${cubit.allWords[index].wordText}',
                     //               onPressed:(){} ,
                     //               date: '${cubit.allWords[index].definitionText}',
                     //                   icon:Icons.favorite ,
                     //               );
                     //             },
                     //           )
                     //
                     //
                     //
                     //   ),
                     // ),
                   ],
                 ),

              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  var now = DateTime.now();
                  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                  if (cubit.isBottomSheetShown){

                    if(formKey.currentState!.validate()){
                      cubit.createNewWord(
                          wordText: wordController.text,
                          definitionText: definitionController.text,
                          level: 'A2C' ,
                          session: '1' ,
                        dateTime: now.toString()
                      );

                      cubit.insertToDatabase(
                        word: wordController.text,
                        definition: definitionController.text,
                        name: '',);
                      Navigator.pop(context);
                    }

                  }else{
                    scaffoldKey.currentState!.showBottomSheet(
                          (context) => Container(
                        color: Colors.white,
                        padding:  const EdgeInsets.all(
                          20.0,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextFormField(
                                  controller: wordController,
                                  textInputType:TextInputType.text,
                                  validateText: 'title must not be empty',
                                  label: 'Enter New Word',
                                  prefix: Icons.title_outlined,
                                  radius: 15
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultTextFormField(
                                  controller: definitionController,
                                  textInputType:TextInputType.text,
                                  label: 'Enter Definition',
                                  prefix: Icons.title_outlined,
                                  radius: 15
                              ),

                            ],
                          ),
                        ),
                      ),
                      elevation: 20,

                    ).closed.then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                      // wordController.clear();
                      // definitionController.clear();
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  }

                  // cubit.insertToDatabase(word: 'welcome', definition: 'its mean hello ', name: 'yousef');
                },
                child: Icon (
                    cubit.fabIcon
                ),
              ),

            );

          //NewWord()
        }
        );


  }
}

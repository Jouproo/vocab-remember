
import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout_screen.dart';
import '../../model/word_model.dart';
import '../../share/components/components.dart';


class WordsScreen extends StatelessWidget {

   WordsScreen({Key? key}) : super(key: key);


   var scaffoldKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();
   var wordController = TextEditingController();
   var definitionController = TextEditingController();
   var levelController = TextEditingController();
   var dateController = TextEditingController();
   var searchController = TextEditingController();


   String topText = 'All Words';
   bool isSearch = false ;

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
       listener: (context, state){},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                leading:  IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                    icon:const Icon(Icons.arrow_back),
                  color: Colors.black,

                ),
                elevation: 1.0 ,
                title: (cubit.isSearch) ? searchTextField(
                  onSubmitted: (){
                    cubit.doFalseSearch();
                  },
                  prefixIcon: Icons.arrow_back,
                  controller: searchController,
                  prefixFunction: (){
                    cubit.changSearchState();
                  },
                  onChang: (query){
                    cubit.allWordsSearch(query: query);
                    },
                  suffixFunction: (){
                    searchController.clear();
                    },
                  )
                    : Text(topText ,style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black)) ,
                actions: [
                  if(cubit.isSearch==false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            cubit.changSearchState();
                          } , icon: const Icon(
                              Icons.search) ,
                            color: Colors.blue
                          ),
                          PopupMenuButton<String>(

                            shape:  const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),),
                            position: PopupMenuPosition.values.last,
                            padding: const EdgeInsets.all(10.0) ,
                            offset:  const Offset(-15, 0),
                            iconSize:30,
                            color: Colors.grey,
                            onSelected: (value){
                              topText = value ;
                              cubit.getLevelOrderWords(level: value);
                            },
                            icon: const Icon(
                                Icons.sort ,
                              color: Colors.black,
                            ),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  value: 'All Words ',
                                  child: const Text('All Words'),
                                  onTap: (){
                                    cubit.getWords();
                                  },

                                ),
                                const PopupMenuItem(
                                  value: 'A2A',
                                  child: Text('A2A'),

                                ),
                                const PopupMenuItem(
                                  value: 'A2B',
                                  child: Text('A2B'),

                                ),
                                const PopupMenuItem(
                                  value: 'A2C',
                                  child:  Text('A2C'),

                                ),
                                const PopupMenuItem(
                                  value: 'A2D',
                                  child: Text('A2D'),

                                ),
                                const PopupMenuItem(
                                  value: 'B2A',
                                  child: Text('B2A'),

                                ),
                                const PopupMenuItem(
                                  value: 'B2B',
                                  child: Text('B2B'),

                                ),
                                const PopupMenuItem(
                                  value: 'B2C',
                                  child: Text('B2C'),

                                ),
                                const PopupMenuItem(
                                  value: 'B2D',
                                  child: Text('B2D'),

                                ),
                              ];
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
              backgroundColor: Colors.grey[200],
              key: scaffoldKey,
              body:   SafeArea(
                 child: Column(
                   children: [
                     Expanded(
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         padding: const EdgeInsets.only(top: 5),
                         decoration: const BoxDecoration(
                           color: Colors.white38,
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(30),
                             topRight: Radius.circular(30),
                           ),
                         ),
                         child: Align(
                           alignment: Alignment.topCenter,
                           child: Padding(
                             padding: const EdgeInsets.all(06.0),
                             child: (cubit.isSearch)? communityWordsBuilder(allWords: cubit.allSearchWords,):
                             communityWordsBuilder(allWords: cubit.allWords,)
                             ,
                           ),
                         ),
                       ),
                     ),
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
                          level: levelController.text.toUpperCase() ,
                          session: '1' ,
                        dateTime: now.toString()
                      );
                      // cubit.insertToDatabase(
                      //   word: wordController.text,
                      //   definition: definitionController.text,
                      //   name: '',
                      //
                      // );
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
                              const SizedBox(
                                height: 10,
                              ),
                              defaultTextFormField(
                                  controller: levelController,
                                  textInputType:TextInputType.text,
                                  label: 'Enter level ',
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
                      wordController.clear();
                      definitionController.clear();
                      levelController.clear();
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






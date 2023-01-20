import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/components/components.dart';



class YourWordsScreen extends StatelessWidget {

   YourWordsScreen({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var wordController = TextEditingController();
  var definitionController = TextEditingController();
  var levelController = TextEditingController();
  var dateController = TextEditingController();
   var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
             // leading: IconButton(
             //   onPressed:() {
             //     if(cubit.isSearch) {
             //       cubit.changSearchState();
             //     }else{
             //       navigateTo(context, LayoutScreen());
             //      // Navigator.of(context).pop();
             //     }
             //   },
             //   icon:  Icon(Icons.arrow_back,
             //     color: Theme.of(context).primaryColor,
             //   ),
             // ),
                title: (cubit.isSearch) ? searchTextField(
                  controller: searchController,
                  prefixFunction: (){
                    cubit.changSearchState();
                  },
                  prefixIcon: Icons.arrow_back,
                  onChang: (query){
                    cubit.yourWordsSearch(query: query);},

                  suffixFunction: (){
                    searchController.clear();
                  },
                )
                    : const Text('Your Words ' ,style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black)),
              actions: [
                if(cubit.isSearch==false)
                IconButton(
                  onPressed:() {
                    cubit.changSearchState();
                  },
                  icon:  Icon(Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),


                ),
              ],
              elevation: 3.0,
            ),
            body:   SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: (cubit.isSearch) ? wordsBuilder(words:  cubit.yourSearchWords,):
                    wordsBuilder(words:  cubit.words,)
                )
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                var now = DateTime.now();
                // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                if (cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                      word: wordController.text,
                      definition: definitionController.text,
                      status: 'new'
                    );
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
        }
    );


  }
}
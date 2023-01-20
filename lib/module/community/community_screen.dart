
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/layout/layout_screen.dart';
import 'package:esaam_vocab/module/yourWords/your_words_screen.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../share/appspaces.dart';
import '../../share/components/components.dart';
import '../../share/const/colors/colors.dart';
import '../../share/const/colors/configs.dart';
import '../Words/words_screen.dart';
import '../search/search_bar.dart';



class CommunityScreen extends  StatelessWidget {
   CommunityScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>
      (
        listener: (states,context){},
        builder: (cubit,states){
      AppCubit cubit =  AppCubit.get(context) ;
      var userModel = AppCubit.get(context).userModel;

        return Scaffold(

          body: SafeArea(
            key: scaffoldKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                                 //  navigateTo(context, LayoutScreen())
                          icon:const Icon(Icons.arrow_back)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child:(userModel?.name == null) ?const Text('Hi ... ' ,
                              style:kMeaningTextStyle): Text('Hi ${userModel?.name} ' ,
                              style:kMeaningTextStyle)
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:AppCubit.get(context).getProfilePhoto(),
                        backgroundColor: Colors.transparent,
                      ),
                      IconButton(onPressed: (){
                        cubit.changeSettingState();
                      },
                          icon:const Icon(Icons.settings)),
                      // PopupMenuButton<String>(
                      //   position: PopupMenuPosition.values.last,
                      //   onSelected: (_) {},
                      //   itemBuilder: (BuildContext context) {
                      //     return [
                      //       const PopupMenuItem(
                      //         value: 'reset_likes',
                      //         child: Text('setting'),
                      //       ),
                      //     ];
                      //   },
                      // ),
                    ],
                  ),
                  if(cubit.isSetting)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Column(
                          children: [
                            IconButton(onPressed: (){
                                }, icon: const Icon(Icons.brightness_medium_outlined)),
                            const Text('Chang Mode' ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: (){
                            }, icon: const Icon(Icons.edit_off)),
                            const Text('Edit Profile' ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: (){
                              cubit.signOut(context: context);
                              },
                                icon: const Icon(Icons.logout)),
                            const Text('Logout' ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold ,
                                color: Colors.blue
                              ),
                            )
                          ],
                        ),
                        // PopupMenuButton<String>(
                        //   position: PopupMenuPosition.values.last,
                        //   onSelected: (_) {},
                        //   itemBuilder: (BuildContext context) {
                        //     return [
                        //       const PopupMenuItem(
                        //         value: 'reset_likes',
                        //         child: Text('setting'),
                        //       ),
                        //     ];
                        //   },
                        // ),
                      ],
                    ),
                  ) ,
                   const SizedBox(
                     height: 15.0,
                   ),
                  SearchBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue ,
                      //Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             const Text(
                              'Last word ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                // await WordAudio()
                                //     .playAudio(homeProvider.wordOfTheDay['word']);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                '${cubit.allWords[cubit.allWords.length-1].wordText}',
                                style: kCustomCardWordTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                Clipboard.setData(ClipboardData(
                                    text: '${cubit.allWords[cubit.allWords.length-1].wordText}' ));
                                Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                              },
                              icon:  const Icon(Icons.copy,
                                color:  Colors.white,
                                // model['status']=='new'? Colors.grey :
                                size: 24,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          maxLines: 4,
                          '${cubit.allWords[cubit.allWords.length-1].definitionText}',
                          style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      homeBuildItem(
                        onTap:(){
                          showToast(msg: 'Wait soon');
                        } ,
                        image: AppAssets.note,
                        text: 'phrases',
                      ) ,
                      const SizedBox(
                        width: 20,
                      ),
                      homeBuildItem(
                        onTap:(){
                          navigateTo(context, WordsScreen());
                        } ,
                        image: AppAssets.words,
                        text: ' Words ',
                      )

                    ],

                  )
                ],
              )),
        );
    },

        );


  }
}

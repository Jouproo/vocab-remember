
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/module/yourWords/your_words_screen.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../share/components/components.dart';
import '../../share/const/colors/configs.dart';
import '../search/search_bar.dart';



class HomeScreen extends  StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  void initState() {


  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>
      (
        listener: (states,context){
          if(states is AppChangeBottomNavBarState){
          }
        },
        builder: (cubit,states){
      AppCubit cubit =  AppCubit.get(context) ;
      var userModel = AppCubit.get(context).userModel;

        return Scaffold(

          body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child:(userModel?.name == null) ?Text('Hi ... ' ,
                              style:kMeaningTextStyle): Text('Hi ${userModel?.name} ' ,
                              style:kMeaningTextStyle)
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:AppCubit.get(context).getProfilePhoto(),
                        //  AssetImage(AppAssets.livingRoomImage),
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
                  ) ,
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
                              'word_of_the_day',
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
                        Text(
                          'Esaam Ready for you',
                          style: kCustomCardWordTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'be patient',
                          style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      homeBuildItem(
                        onTap:(){

                        } ,
                        image: AppAssets.note,
                        text: 'phrases',
                      ) ,
                      const SizedBox(
                        width: 20,
                      ),
                      homeBuildItem(
                        onTap:(){
                          navigateTo(context, YourWordsScreen());
                        } ,
                        image: AppAssets.phrase1,
                        text: 'Your Word ',
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:esaam_vocab/module/community/community_screen.dart';
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



class HomeScreen extends  StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {


        return Scaffold(
          body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SearchBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                        Expanded (
                           child: GestureDetector(
                            onTap: (){
                              navigateTo(context, CommunityScreen());
                                  },
                            child: Container(
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color: ChooseColor.defaultBackgroundColor
                             ),
                              child: Row(
                                children: [
                                  AppSpaces.horizontal15,
                                  Center(
                                    child: SizedBox(
                                      width: Get.width/ 5,
                                      height: Get.height / 10,
                                      child:SvgPicture.asset(
                                        AppAssets.note,
                                        width: 250.0,
                                      ),),),
                                  AppSpaces.horizontal25,
                                  Column(
                                      children: const [
                                        Text(
                                          'Community vocab',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          'Share with us',
                                          style: TextStyle(
                                          ),
                                        ),
                                      ]),
                                ],

                              ),),
                                        ),)
                    ],
                  )
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      homeBuildItem(
                        onTap:(){
                          showToast(msg: 'Wait soon');
                        } ,
                        image: AppAssets.phrases,
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
                        text: 'Add new category ',
                      )

                    ],

                  )
                ],
              )),
        );



  }
}

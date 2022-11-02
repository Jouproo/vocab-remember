
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../../share/const/colors/configs.dart';

class Layout extends  StatelessWidget {
  const Layout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();



    return BlocConsumer<AppCubit,AppStates>
      (
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
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                          child: Text('Hi ${userModel?.name} '   ,
                              style:kMeaningTextStyle),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:AppCubit.get(context).getProfilePhoto(),
                        //  AssetImage(AppAssets.livingRoomImage),
                        backgroundColor: Colors.transparent,

                      )
                    ],
                  ) ,
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 0.5,
                          color: kLightBlack,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {},
                          ),
                          const Text(
                            'search',
                            style: TextStyle(color: kBackgroundColor, fontSize: 17.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
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
                  )
                ],
              )),
        );
    },
        listener: (states,context){}
        );


  }
}

import 'package:esaam_vocab/share/appspaces.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:flutter/material.dart';

import '../../share/components/components.dart';
import '../../share/const/colors/configs.dart';

class Layout extends  StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
         padding: const EdgeInsets.symmetric(horizontal: 16.0),
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children:  [
                   Container(
                     margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                     child: const Text('OurVocab'  ,
                       style:kAppBarStyle
                     ),
                   ),
                   const CircleAvatar(
                     radius: 20.0,
                     backgroundImage: AssetImage(AppAssets.livingRoomImage),
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
  }
}

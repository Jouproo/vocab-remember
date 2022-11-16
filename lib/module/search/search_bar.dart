import 'dart:convert';
import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/share/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../layout/cubit/layout_cubit.dart';

import '../../model/word_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'search_screen.dart';
import '../../share/const/colors/configs.dart';

// Search bar used in HomeScreen

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       myShowSearch(context);
      } ,
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
              icon: const Icon(
                Icons.search,
                color: Color(0xFF42A5F5),
              ),
              onPressed: () => myShowSearch(context),
            ),
            const Text(
              'search',
              style: TextStyle(color: kBackgroundColor, fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }
}


 void myShowSearch(BuildContext context) {
  showSearch(context: context, delegate: DataSearch());
}


class DataSearch extends SearchDelegate<String> {

  List searchResult = [];
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return Theme.of(context).copyWith(
  //     primaryColor: Theme.of(context).primaryColor,
  //     appBarTheme: AppBarTheme(
  //       color: Theme.of(context).primaryColor,
  //     ),
  //     inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
  //       focusedBorder: InputBorder.none,
  //     ),
  //     textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
  //       cursorColor: Colors.white,
  //     ),
  //     textTheme: super.appBarTheme(context).textTheme.copyWith(
  //       headline6: super.appBarTheme(context).textTheme.headline6?.copyWith(
  //         fontWeight: FontWeight.normal,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () {
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return ListView.separated(
        physics: const ScrollPhysics(),
        itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(
                    10.0,
                  ),
                  topStart: Radius.circular(
                    10.0,
                  ),
                  topEnd: Radius.circular(
                    10.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 02.0,
                horizontal: 08.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child:  Text(
                          capitalize(searchResult[index]['text']),
                          style: kCardTextStyle,
                        ),
                      ),
                      Tooltip(
                        message:  'Copy to clipboard' ,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(
                                text:searchResult[index]['text']));
                            Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                          },
                          icon: const Icon(
                            Icons.content_copy,
                            size: 30.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(searchResult[index]['definitionText'] != null)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      // LayoutCubit.get(context).words
                      child: Text(
                        searchResult[index]['definitionText'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 0.0,
          color: Colors.grey[200],
        ),
        itemCount: searchResult.length
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
      FirebaseFirestore.instance
          .collection('Words')
          .orderBy('text')
          .startAt([query])
          .endAt([query+'\uf8ff'])
        .get().then((value) {
      searchResult = value.docs.map((e) => e.data()).toList();
    });

    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: () {
        showResults(context);
      },
      title: Text(
          searchResult[index]['text'],
        style: const TextStyle(fontSize: 18 ,
            fontWeight: FontWeight.bold ,
          color: Colors.red
        ),
      ),
      subtitle: Text(
          searchResult[index]['definitionText'],
        style: const TextStyle(fontSize: 15 ,
            fontWeight: FontWeight.bold ),
      ),
    ),
      itemCount: searchResult.length,
    );
  }
}





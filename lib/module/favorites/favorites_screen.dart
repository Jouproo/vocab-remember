import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/components/components.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Center(
                child:  Text('Favorites' ,style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black)),
              ),
            ),
            body:   SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  //Text('${cubit.words.length}'),
                   Align(
                       alignment: Alignment.topRight,
                       child: wordsBuilder(words: cubit.favorites)
                   ),
                )
            ),

          );
        }
    );


  }
}

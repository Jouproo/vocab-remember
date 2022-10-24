import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/components/components.dart';

class WordsScreen extends StatelessWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
       listener: (context, state){},
        builder: (context, state) {
          LayoutCubit cubit = LayoutCubit.get(context);
          return
            Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: const Center(
                  child:  Text('All Words' ,style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black)),
                ),
              ),
              body:   SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: wordsBuilder(words: cubit.words),
                    ),
                  )
              ),

            );
          Scaffold(
            appBar: AppBar(),
            body:   wordsBuilder(words: cubit.words),

          );
        }
        );


  }
}

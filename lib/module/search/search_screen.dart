// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../layout/cubit/layout_cubit.dart';
// import '../../share/components/components.dart';
// import 'cubit/cubit.dart';
// import 'cubit/states.dart';
//
// class SearchScreen extends StatelessWidget {
//
//   SearchScreen({Key? key}) : super(key: key);
//
//
//   var dateController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create:
//         (BuildContext context) => AppSearchCubit(),
//       child: BlocConsumer<AppSearchCubit,AppSearchStates>(
//           listener: (context, state){},
//           builder: (context, state) {
//             AppSearchCubit cubit = AppSearchCubit.get(context);
//             return Scaffold(
//               //backgroundColor: Theme.of(context).primaryColor,
//               body:   SafeArea(
//
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: TextField(
//
//                             decoration: const InputDecoration(
//                               border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20))),
//                               hintText: "Search Here",
//                             ),
//                             onChanged: (query) {
//                               cubit. searchFromFirebase(query);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: const EdgeInsets.only(top: 5),
//                         decoration: const BoxDecoration(
//                           color: Colors.white38,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(06.0),
//                           child: allWordsBuilder(allWords: cubit.searchWords,),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//
//               ),
//
//
//             );
//
//             //NewWord()
//           }
//       )
//     );
//
//
//
//
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaam_vocab/layout/layout_screen.dart';
import 'package:esaam_vocab/model/word_model.dart';
import 'package:esaam_vocab/share/components/components.dart';
import 'package:flutter/material.dart';
class NewWord extends StatelessWidget {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Words')
      .orderBy('dateTime').snapshots();

  List<WordModel>  allWords = [];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: OutlineInputBorder(),
                hintText: "Search Here",
              ),
              onChanged: (query) {
              //  searchFromFirebase(query);
              },
            ),
          ),
        ],
      ),

      body:   StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(

              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                allWords.add(WordModel.fromJson(data))  ;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(
                        05.0,
                      ),
                      topStart: Radius.circular(
                        05.0,
                      ),
                      topEnd: Radius.circular(
                        05.0,
                      ),
                    ),
                  ),
                  child: ListTile(

                    title: Text(data['text']),
                    subtitle: Text(data['definitionText']),
                  ),
                );
              }).toList(),
            );
        },
      )  ,


    );

  }

  //  NewWord({Key? key}) : super(key: key);
  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Words')
  //     .orderBy('dateTime').snapshots();
  //
  //
  // List<WordModel>  allWords = [];
  //
  //  //DocumentSnapshot ds = snapshot.data.documents[index];
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body:   StreamBuilder<QuerySnapshot>(
  //       stream: _usersStream,
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.hasError) {
  //           return const Text('Something went wrong');
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Text("Loading");
  //         }
  //
  //         return ListView.builder(
  //             itemCount:snapshot.data!.docs.length ,
  //             itemBuilder: (context,index){
  //               DocumentSnapshot ds = snapshot.data!.docs[index];
  //               // snapshot.data!.docs.map((DocumentSnapshot document) {
  //               //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //               //   allWords.add(WordModel.fromJson(data));
  //               // });
  //
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 05),
  //                 child: InkWell(
  //                   key:Key(ds['uId'].toString()) ,
  //                   onTap: (){
  //                     navigateTo(context, HomeScreen());
  //                   },
  //
  //                   child: Container(
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[300],
  //                       borderRadius: const BorderRadiusDirectional.only(
  //                         bottomEnd: Radius.circular(
  //                           05.0,
  //                         ),
  //                         topStart: Radius.circular(
  //                           05.0,
  //                         ),
  //                         topEnd: Radius.circular(
  //                           05.0,
  //                         ),
  //                       ),
  //                     ),
  //                     child: Align(
  //                       alignment: AlignmentDirectional.topStart,
  //                       child: Container(
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey[300],
  //                           borderRadius: const BorderRadiusDirectional.only(
  //                             bottomEnd: Radius.circular(
  //                               05.0,
  //                             ),
  //                             topStart: Radius.circular(
  //                               05.0,
  //                             ),
  //                             topEnd: Radius.circular(
  //                               05.0,
  //                             ),
  //                           ),
  //                         ),
  //                         padding: const EdgeInsets.symmetric(
  //                           vertical: 02.0,
  //                           horizontal: 08.0,
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             Expanded(
  //                               child: Text(
  //                                 '${ds['text']}',
  //                                 style: const TextStyle(fontSize: 18 ,
  //                                     fontWeight: FontWeight.bold ),
  //                               ),
  //                             ),
  //                             IconButton(
  //                               onPressed: ()
  //                               {
  //                                 //    AppCubit.get(context).changeFavorite(id: model.uId, index: index);
  //                                 // LayoutCubit.get(context).updateData(
  //                                 //   status: 'favorite',
  //                                 //   id: model['id'],
  //                                 //   item: 'status'
  //                                 // );
  //
  //                               },
  //                               icon:  Icon(
  //                                 Icons.favorite,
  //                                 color: Colors.red[700],
  //                                 // model['status']=='new'? Colors.grey :
  //                                 size: 25,
  //                               ),
  //                             ),
  //                             IconButton(
  //                               onPressed: ()
  //                               {
  //                                 // AppCubit.get(context).deleteData(id: model['id']);
  //                               },
  //                               icon:  const Icon(
  //                                 Icons.delete_outline,
  //                                 color: Colors.blueAccent,
  //                                 size: 25,
  //                               ),
  //                             ),
  //
  //
  //                           ],
  //                         ),
  //                       ),
  //
  //                     ),
  //                   ),
  //                 ),
  //               );
  //               allWordItemBuild(allWords[index],context, index);
  //               //  DocumentSnapshot ds = snapshot.data!.docs[index];
  //
  //             }
  //         );
  //
  //
  //
  //       },
  //     )  ,
  //   );
  // }
}







// class UserInformation extends StatefulWidget {
//
//
//   @override
//   _UserInformationState createState() => _UserInformationState();
//
// }
//
// class _UserInformationState extends State<UserInformation> {
//
//
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Words')
//       .orderBy('dateTime').snapshots();
//      int index ;
//   _UserInformationState(this.index);
//   List<WordModel>  allWords = [];
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       body:   StreamBuilder<QuerySnapshot>(
//         stream: _usersStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text("Loading");
//           }
//
//           return
//
//             ListView(
//
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//              allWords.add(WordModel.fromJson(data))  ;
//               return Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: const BorderRadiusDirectional.only(
//                     bottomEnd: Radius.circular(
//                       05.0,
//                     ),
//                     topStart: Radius.circular(
//                       05.0,
//                     ),
//                     topEnd: Radius.circular(
//                       05.0,
//                     ),
//                   ),
//                 ),
//                 child: ListTile(
//
//                   title: Text('${allWords[0].wordText}'),
//                   subtitle: Text(data['definitionText']),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       )  ,
//     );
//
//   }
// }


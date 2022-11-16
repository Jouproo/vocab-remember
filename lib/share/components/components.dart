
import 'package:animations/animations.dart';
import 'package:esaam_vocab/layout/layout_screen.dart';
import 'package:esaam_vocab/model/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../layout/cubit/layout_cubit.dart';
import '../appspaces.dart';
import '../const/colors/colors.dart';
import '../const/colors/configs.dart';



Widget defaultTextFormField(
    {
      required  TextEditingController controller,
      required TextInputType ? textInputType,
      double   radius = 0,
      required IconData  prefix,
      IconData ? suffix,
      bool isPassword = false,
      Function ? suffixFunction ,
      required String  label ,
      String ? hint,
      Function ? onChang,
      Function ? onSubmit,
      String ? validateText,
      Function ? onTap,

    }) =>
    TextFormField(
      validator: (value){
        if (value!.isEmpty){
          return validateText ;
        }
        return null;
      },
      controller: controller,
      keyboardType: textInputType,
      decoration:   InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(radius))),
        prefixIcon: Icon(prefix,),
        suffixIcon: IconButton(
            onPressed: (){
              suffixFunction!();
            },
            icon: Icon(suffix)
        ),
        labelText: label,
        hintText: hint,
        // hintStyle: TextStyle(fontSize: 15,),
      ),
      onChanged: (value){
        onChang!(value); },
      onFieldSubmitted: (value){
        onSubmit!(value);},
      obscureText: isPassword,
      onTap: (){
        onTap!();
      },
    );


Widget searchTextField({
   TextEditingController ? controller ,
     Function? suffixFunction,
     Function? prefixFunction,
    IconData ? prefixIcon ,
  required Function? onChang,
   Function? onSubmitted,
}) {
  return  TextField(
    controller: controller,
    onChanged: (value){
      onChang!(value);
    },
    onSubmitted: (value){
      onSubmitted!();
    },
    autofocus: true, //Display the keyboard when TextField is displayed
    cursorColor: Colors.blue,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 17,

    ),
    // textInputAction: TextInputAction.search, //Specify the action button on the keyboard
    decoration:  InputDecoration(
      suffixIcon: IconButton(onPressed: (){
        suffixFunction!();
      },
          icon: const Icon(Icons.close)),
         prefixIcon:IconButton(onPressed: (){
           prefixFunction!();
         },
             icon:  Icon(prefixIcon)) ,
      //Style of TextField
      enabledBorder: const UnderlineInputBorder( //Default TextField border
          borderSide: BorderSide(color: Colors.grey)
      ),
      focusedBorder: const UnderlineInputBorder( //Borders when a TextField is in focus
          borderSide: BorderSide(color: Colors.white)
      ),
      hintText: 'Search', //Text that is displayed when nothing is entered.
      hintStyle: TextStyle( //Style of hintText
        color: Colors.grey,
        fontSize: 20,
      ),
    ),
  );
}


         //Dismissible
// onDismissed: (direction){
// LayoutCubit.get(context).deleteData(id: model['id']);
// },
//SlidableAutoCloseBehavior
// closeWhenOpened: true,


Widget allWordItemBuild(WordModel model,context,index) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 05),
  child: Slidable(
    key: Key(model.uId.toString()),
    startActionPane:  ActionPane(
      dismissible: DismissiblePane(onDismissed: () {
        AppCubit.get(context).removeWord(wId: model.wId.toString(),rUid:model.uId.toString());
      }),
        extentRatio: 1/1,
      motion:const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context){
            AppCubit.get(context).insertToDatabase(
              word: '${model.wordText}',
              definition: ' ${model.definitionText}',
              wId: '${model.wId}',
              status: 'favorite'
            );
          },
          backgroundColor: Colors.grey,
          //Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.favorite,
          label: 'Favorite',
        ),
         SlidableAction(

          onPressed: (context){

          AppCubit.get(context).removeWord(wId:model.wId.toString(),rUid:model.uId.toString());
          },
          backgroundColor: Colors.grey,
          //Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',

        ),
        SlidableAction(
          onPressed: (context){
            Clipboard.setData(ClipboardData(
                text:'${model.wordText}' ));
            Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
          },
          backgroundColor: Colors.grey,
          //Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.content_copy,
          label: 'Copy',
        ),
        const SlidableAction(
          onPressed: doNothing,
          backgroundColor: Colors.grey,
          //Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.close,
          label: 'Close',
        ),
      ],
    ),

    child: Align(
     alignment: AlignmentDirectional.topStart,
      child: OpenContainer(

        openBuilder: (context, action) {
         return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Expanded(
             child: Container(

               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(15.0),
               ),
             ),
           ),
           Expanded(
             child: Container(
               padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
               margin: const EdgeInsets.symmetric(vertical: 10.0),
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color:
                 const Color(0xFF42A5F5),
               // Colors.blue,
                // Theme.of(context).primaryColor,
                 borderRadius: BorderRadius.circular(15.0),
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(
                         capitalize('${model.wordText}'),
                         style: wCardTextStyle,),
                       Tooltip(
                         message:  'Copy to clipboard' ,
                         child: IconButton(
                           padding: const EdgeInsets.all(0),
                           onPressed: (){
                             Clipboard.setData(ClipboardData(
                                 text:'${model.wordText}' ));
                             Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                           },
                           icon: const Icon(
                             Icons.content_copy,
                             size: 30.0,
                             color: Colors.white,
                           ),
                         ),
                       ),

                     ],
                   ),
                   Text(
                     '${model.definitionText}',
                     style: kCustomCardWordTextStyle.copyWith(
                       fontWeight: FontWeight.w400,
                       fontSize: 16.0,
                     ),
                     overflow: TextOverflow.ellipsis,
                     maxLines: 5,
                   ),
                   Expanded(
                     child: Row(
                        crossAxisAlignment:CrossAxisAlignment.end ,
                       children: [
                         Expanded(
                           child: InkWell(
                             onTap: (){
                              // navigateTo(context, HomeScreen());
                             },
                             child: Text(
                               '${model.level}',
                               style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                             ),
                           ),
                         ),
                         Expanded(
                           child: Text(
                            '${model.name}',
                             style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                           ),

                         ),
                         // Expanded(
                         //        child:  IconButton(
                         //          icon: const Icon(
                         //            Icons.volume_up,
                         //            color: Colors.white,
                         //          ),
                         //          onPressed: () async {
                         //            // await WordAudio()
                         //            //     .playAudio(homeProvider.wordOfTheDay['word']);
                         //          },
                         //        ),
                         //      )
                       ],
                     ),
                   )
                 ],

               ),
             ),
           ),
           Expanded(
             child: Container(

               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(15.0),
               ),
             ),
           ),

         ],
           );

        }, closedBuilder: ( context, action) {
        return Container(
          width: double.infinity,
          decoration:  BoxDecoration(
            color: Colors.grey[100],
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
                      capitalize('${model.wordText}'),
                      style: kCardTextStyle,
                    ),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      Clipboard.setData(ClipboardData(
                          text:'${model.wordText}' ));
                      Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                    },
                    icon:  const Icon(Icons.copy,
                      color:  Colors.blue,
                      // model['status']=='new'? Colors.grey :
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      AppCubit.get(context).removeWord(wId: model.wId.toString(),rUid:'${model.uId}');
                    },
                    icon:  const Icon(
                      Icons.delete_outline,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                  ),
                ],
              ),
              if(model.definitionText != null)
                Align(
                  alignment: AlignmentDirectional.topStart,
                  // LayoutCubit.get(context).words
                  child: Text(
                    ' ${model.definitionText}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

            ],
          ),
        );
      },

      ),
    ),
  ),
);
//Key(model.uId.toString()),

Widget allWordsBuilder({required List<WordModel> allWords}) => SlidableAutoCloseBehavior(
  closeWhenOpened: true,
  child:   ListView.separated(
      physics: const ScrollPhysics(),
      itemBuilder: (context , index){
        return allWordItemBuild(allWords[index],context, index);
      },
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 0.0,
        color: Colors.grey[200],
      ),
      itemCount: allWords.length
  ),
);


Widget wordItemBuild(Map model,context,index) => Dismissible(
  key: Key(model['id'].toString()),

  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 05),
    child: Align(
      alignment: AlignmentDirectional.topStart,
      child: OpenContainer(

        openBuilder: (context, action) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    // borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFF42A5F5),
                    // Colors.blue,
                    // Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            capitalize('${model['word']}'),
                            style: wCardTextStyle,),
                          Tooltip(
                            message:  'Copy to clipboard' ,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: (){
                                Clipboard.setData(ClipboardData(
                                    text:'${model['word']}' ));
                                Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                              },
                              icon: const Icon(
                                Icons.content_copy,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${model['definition']}',
                        style: kCustomCardWordTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ],

                  ),
                ),
              ),
              Expanded(
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    // borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

            ],
          );

        }, closedBuilder: ( context, action) {
        return Container(
          width: double.infinity,
          decoration:  BoxDecoration(
            color: Colors.grey[100],
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
                      capitalize('${model['word']}'),
                      style: kCardTextStyle,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color:model['status']=='new'? Colors.grey : Colors.red[400],
                    size: 25,
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      Clipboard.setData(ClipboardData(
                          text:'${model['word']}' ));
                      Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                    },
                    icon:  const Icon(Icons.copy,
                      color:  Colors.blue,
                      // model['status']=='new'? Colors.grey :
                      size: 24,
                    ),
                  ),
                ],
              ),
              if(model['definition'] != null)
                Align(
                  alignment: AlignmentDirectional.topStart,
                  // LayoutCubit.get(context).words
                  child: Text(
                    '${model['definition']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

            ],
          ),
        );
      },

      ),
    ),

  ),

  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

 Widget wordsBuilder({required List<Map> words}) => ListView.separated(
      itemBuilder: (context , index){
        return wordItemBuild(words[index],context, index);
      },
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 0.0,
        color: Colors.grey[300],
      ),
      itemCount: words.length
  );


Widget homeBuildItem (
    {
      required String image,
      required String text,
       // bool ? isSelected,
      required VoidCallback onTap,
      double ? fontSize = 18,
      Color? unSelectedImageColor,
    })=>    Expanded (
  child: GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //gradient: isSelected ? appGradient : null,
        color: ChooseColor.defaultBackgroundColor
        // color: !isSelected! ? ChooseColor.defaultBackgroundColor : ChooseColor.defaultColor,
        // color: !isSelected ? ChooseColor.defaultBackgroundColor: ChooseColor.defaultColor,
        //!isSelected ? Colors.grey[100] : const Color(0xFF1A5276),
      ),
      child: Column(
          children: [
            AppSpaces.vertical15,
            Center(
              child: SizedBox(
                width: Get.width/ 5,
                height: Get.height / 10,
                child:SvgPicture.asset(
                  image,
                  width: 250.0,
                  // color: isSelected ? Colors.white :  Get.theme.primaryColor,
                  //isSelected ? Colors.white : const Color(0xFF1A5276),
                  // color: Colors.blueAccent,
                ),
              ),
            ),
            AppSpaces.vertical15,
            Text(
              text,
              style: TextStyle(
                // color:  isSelected ? Colors.white : Colors.black,
                fontSize: fontSize , ),
            ),
            AppSpaces.vertical15,
          ]),
    ),
  ),
);

void navigateTo(context, widget)=>  Navigator.push(context,
    MaterialPageRoute(builder: (context)=> widget));

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=> widget), (route) => false);

void showToast({required String msg,  Color ? color}) =>  Fluttertoast.showToast(
    msg: msg ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color ,
    textColor: Colors.white,
    fontSize: 16.0
);

 showError({required error, required BuildContext context, Color ? color}) {
  if (error.runtimeType == NoSuchMethodError) {
    error = 'UnIdentified Error!';
  } else if (error.runtimeType != String) {
    error = (error?.message != null) ? error?.message : 'UnIdentified Error';
  }
   Fluttertoast.showToast(
      msg: error ,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color ,
      textColor: Colors.white,
      fontSize: 16.0
  );
  // final snackBar = SnackBar(content: Text('ERROR: $error'));
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget defaultButton({
  Color ? backgroundColor ,
  double width = double.infinity,
  double high = 50.0,
  required Function  onPressedFunction ,
  required String text,
  bool isUpperCase = true,
  double radius = 20,
}) => Container(
     margin: const EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 70.0,
        ),
     width: width,
     height:high ,
  decoration: BoxDecoration(color: backgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(radius))),
  child: MaterialButton(
    onPressed: (){
      onPressedFunction();
    },

    child: Text( isUpperCase? text.toUpperCase():text,
      style: kLargeTextStyle.copyWith(
        color: Colors.white,
      ),
    ),
  ),
);
Widget mainBuildItem (
    {
      required String image,
      required String text,
      required bool isSelected,
      required VoidCallback onTap,
      double ? fontSize = 18,
      Color? unSelectedImageColor,
    })=> Expanded (
          child: GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //gradient: isSelected ? appGradient : null,
        color: !isSelected ? ChooseColor.defaultBackgroundColor : ChooseColor.defaultColor,
        // color: !isSelected ? ChooseColor.defaultBackgroundColor: ChooseColor.defaultColor,
        //!isSelected ? Colors.grey[100] : const Color(0xFF1A5276),
      ),
      child: Column(
          children: [
            AppSpaces.vertical15,
            SizedBox(

            // height: Get.height/8,
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.fill,

                // color: isSelected ? Colors.white :  Get.theme.primaryColor,
                //isSelected ? Colors.white : const Color(0xFF1A5276),
              ),
            ),
            AppSpaces.vertical15,
            Text(
              text,
              style: TextStyle(
                color:  isSelected ? Colors.white : Colors.black,
                fontSize: fontSize , ),
            ),
            AppSpaces.vertical15,
          ]),
    ),
  ),
);

void doNothing(BuildContext context) {}
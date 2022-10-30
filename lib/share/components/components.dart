
import 'package:flutter/material.dart';
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
        suffixIcon:
        IconButton(
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
         //Dismissible
// onDismissed: (direction){
// LayoutCubit.get(context).deleteData(id: model['id']);
// },
  Widget wordItemBuild(Map model,context,index) => Dismissible(
    key: Key(model['id'].toString()),

    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 05),
      child: Column(
        children: [
          InkWell(
            key: Key(model['id'].toString()),
            onTap: (){
             // LayoutCubit.get(context).updateData(item: 'definitionStatus',status: 'true', id: model['id']);
              LayoutCubit.get(context). changeShowDefinition(id:model['id'],index: index ,);
            },
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 02.0,
                  horizontal: 08.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${model['word']}',
                        style: const TextStyle(fontSize: 18 ,
                            fontWeight: FontWeight.bold ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        LayoutCubit.get(context).changeFavorite(id: model['id'], index: index);
                        // LayoutCubit.get(context).updateData(
                        //   status: 'favorite',
                        //   id: model['id'],
                        //   item: 'status'
                        // );

                      },
                      icon:  Icon(
                        Icons.favorite,
                        color:model['status']=='new'? Colors.grey : Colors.red[700],
                        size: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        LayoutCubit.get(context).deleteData(id: model['id']);


                      },
                      icon:  const Icon(
                        Icons.delete_outline,
                        color: Colors.blueAccent,
                        size: 25,
                      ),
                    ),


                  ],
                ),
              ),

            ),
          ),

                if(model['definition'] != '')
          if(model['definitionStatus'] == 'true')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: AlignmentDirectional.topStart,
                   // LayoutCubit.get(context).words
              child: Text(
                'definition : ${model['definition']}',
                style: const TextStyle(fontSize: 15 ,
                    fontWeight: FontWeight.bold ),
              ),
            ),
          ),

        ],
      ),
    ),
    onDismissed: (direction){
      LayoutCubit.get(context).deleteData(id: model['id']);
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



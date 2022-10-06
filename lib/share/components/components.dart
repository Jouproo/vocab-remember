
import 'package:flutter/material.dart';

import '../../layout/cubit/layout_cubit.dart';



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

  Widget wordItemBuild(Map model,context,index) => Dismissible(
    key: Key(model['id'].toString()),

    child: Column(
      children: [
        InkWell(
          key: Key(model['id'].toString()),
          onTap: (){
           // LayoutCubit.get(context).updateData(item: 'definitionStatus',status: 'true', id: model['id']);
            LayoutCubit.get(context). changeShowDefinition(id:model['id'],index: index ,);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
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
                  vertical: 08.0,
                  horizontal: 10.0,
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
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 130),
                         // padding: const EdgeInsets.only(left:150),
                          child: IconButton(
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
                              color:model['status']=='new'? Colors.grey : Colors.redAccent,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
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

import 'package:flutter/material.dart';

class PhotosScreen extends StatelessWidget {

  const PhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15 ,),

          Align(
            alignment: AlignmentDirectional.center,
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
                vertical: 15.0,
                horizontal: 10.0,
              ),
              child:const Center(
                child:  Text(
                  'photos ',
                  style: TextStyle(fontSize: 18 ,
                      fontWeight: FontWeight.bold ),
                ),
              ),
            ),
          ),
        ],
      ) ,


    );
  }
}

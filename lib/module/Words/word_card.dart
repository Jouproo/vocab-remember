import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../share/const/colors/configs.dart';

class WordsCard extends StatelessWidget {
  WordsCard({
    required this.word,
    required this.date,
    required this.icon,
    required this.onPressed,
  });

  final String word;
  final String date;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(word),
      onDismissed: (direction) async {
        // HiveDB.instance.remove(word);
        // Provider.of<HomeProvider>(context, listen: false).getHistory();
      },
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
        // padding: const EdgeInsets.symmetric(
        //   vertical: 02.0,
        //   horizontal: 08.0,
        // ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(word),
                  style: kCardTextStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(date),
              ],
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:esaam_vocab/layout/cubit/layout_cubit.dart';
import 'package:esaam_vocab/share/const/appassets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../../share/const/colors/configs.dart';
import 'settings_card.dart';

class SettingsScreen extends StatefulWidget {
   SettingsScreen({ Key? key,  this.callBackFunction,}) : super(key: key);

   final Function ? callBackFunction;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, dynamic>> _settingsCardItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _settingsCardItems = [
//       {
//         'icon': Icons.favorite_border_outlined,
//         'title': 'like',
//         'function': () {
//           widget.callBackFunction!();
//           // Navigator.of(context).pushNamed(LikeScreen.id);
//         },
//       },
//       {
//         'icon': Icons.translate,
//         'title': 'languages',
//       },
//       {
//         'icon': Icons.description_outlined,
//         'title': 'about',
//         'function': () {
//           widget.callBackFunction!();
//
//           showAboutDialog(
//             context: context,
//             applicationName: 'MyVocab',
//             applicationVersion: '0.0.1',
//             applicationIcon: const Icon(FontAwesomeIcons.appStore),
//             applicationLegalese: '''
// This is just a simple open source vocabulary app built for practice. For suggestions or to view source code, visit MrUnfunny on Github''',
//           );
//         }
//       },
//       {
//         'icon': Icons.logout,
//         'title': 'logout',
//         // 'function': () => Auth().signOut(context: context),
//       },
//     ];
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(AppAssets.garage),
              backgroundColor: Colors.transparent,
              onBackgroundImageError: (exception, stackTrace) =>
                  log('$exception \n $stackTrace'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'youssef',
              style: kLargeTextStyle.copyWith(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _settingsCardItems.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                itemBuilder: (context, index) {
                  return SettingsCard(
                    icon: _settingsCardItems[index]['icon'] as IconData,
                    title: _settingsCardItems[index]['title'] as String,
                    onTap: _settingsCardItems[index]['function'] as void
                        Function(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

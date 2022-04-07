import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vividly_music_player/screens/setting_screen.dart';

import '../constants.dart';

PreferredSize AppBarNeu(BuildContext context) {
  return PreferredSize(
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SettingScreen.routename);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 10, right: 25),
                  child: Image.asset(
                    "assets/icons/menu_settings.png",
                    width: 25,
                    color: kPrimaryGrey,
                  )),
            ),
            Neumorphic(
              child: Container(
                  height: 70,
                  width: 285,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: const [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextField(
                          cursorColor: kPrimaryGrey,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      )),
                      Icon(
                        Icons.search,
                        color: kPrimaryGrey,
                        size: 25,
                      )
                    ],
                  )),
              style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.stadium(),
                  depth: -5,
                  color: kPrimaryWhite,
                  shadowDarkColorEmboss: kPrimaryGrey,
                  shadowLightColorEmboss: kPrimaryWhite),
            )
          ],
        ),
      ),
    ),
    preferredSize: Size.fromHeight(70),
  );
}

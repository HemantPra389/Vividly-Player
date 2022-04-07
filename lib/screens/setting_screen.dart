import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vividly_music_player/constants.dart';

class SettingScreen extends StatefulWidget {
  static const routename = 'setting_screen.dart';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  bool isSleep = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Settings',
              style: TextStyle(
                color: kPrimaryBlack,
                fontSize: 25,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryBlack,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
              title: Text(
                'Sleep Timer',
                style: TextStyle(
                    fontSize: 24, fontFamily: 'OpenSans', color: kPrimaryBlack),
              ),
              subtitle: Text(
                'Stop the song after the set time',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'OpenSans', color: kPrimaryGrey),
              ),
              trailing: NeumorphicSwitch(
                value: isSleep,
                style: NeumorphicSwitchStyle(
                  activeThumbColor: kPrimaryPink,
                  activeTrackColor: kPrimaryWhite,
                  inactiveThumbColor: kPrimaryWhite,
                  inactiveTrackColor: kPrimaryWhite,
                  trackDepth: -5,
                  thumbDepth: 5,
                ),
                height: 30,
                onChanged: (value) {
                  setState(() {
                    isSleep = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                    fontSize: 24, fontFamily: 'OpenSans', color: kPrimaryBlack),
              ),
              trailing: NeumorphicSwitch(
                value: isDarkMode,
                style: NeumorphicSwitchStyle(
                  activeThumbColor: kPrimaryPink,
                  activeTrackColor: kPrimaryWhite,
                  inactiveThumbColor: kPrimaryWhite,
                  inactiveTrackColor: kPrimaryWhite,
                  trackDepth: -5,
                  thumbDepth: 5,
                ),
                height: 30,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
                title: Text(
                  'Terms of Use',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'OpenSans',
                      color: kPrimaryBlack),
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'OpenSans',
                      color: kPrimaryBlack),
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
                title: Text(
                  'Automatic update',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'OpenSans',
                      color: kPrimaryBlack),
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: ListTile(
              title: Text(
                'Version',
                style: TextStyle(
                    fontSize: 24, fontFamily: 'OpenSans', color: kPrimaryBlack),
              ),
              subtitle: Text(
                'Current version 2.11.14',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'OpenSans', color: kPrimaryGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

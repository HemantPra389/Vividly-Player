import 'dart:developer';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vividly_music_player/Widgets/bottom_player.dart';
import 'package:vividly_music_player/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vividly_music_player/screens/music_screen.dart';
import 'package:vividly_music_player/provider/songProvider.dart';
import 'package:vividly_music_player/screens/setting_screen.dart';
import 'Widgets/appbarneu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SongProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => MyHomePage(),
          SettingScreen.routename: (ctx) => SettingScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    var storagestatus = await Permission.storage.status;
    if (!storagestatus.isGranted) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
  }

  NeumorphicButton neubtn(IconData icon, Color iconcolor, Function mybtn) {
    return NeumorphicButton(
        onPressed: () {
          mybtn();
        },
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            shadowDarkColor: kPrimaryGrey,
            depth: 4,
            shadowLightColor: Colors.white,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(28)),
            color: kPrimaryWhite),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: iconcolor,
            size: 28,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final audioQuery = new OnAudioQuery();
    var songprovider = Provider.of<SongProvider>(context);

    return Scaffold(
        appBar: AppBarNeu(context),
        backgroundColor: kPrimaryWhite,
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  neubtn(Icons.favorite, kPrimaryPink, () {
                    setState(() {
                      _isFav = !_isFav;
                    });
                  }),
                  neubtn(Icons.alarm, kPrimaryGrey, () {}),
                  neubtn(Icons.play_arrow, kPrimaryGrey, () {}),
                ],
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  height: 470,
                  child: FutureBuilder<List<SongModel>>(
                      future: _isFav
                          ? songprovider.getFavoriteSongs()
                          : songprovider.getSongs(),
                      builder: (context, item) {
                        if (item.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (item.data!.isEmpty) {
                          return const Center(
                            child: Text('No Songs in List Right Now'),
                          );
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Neumorphic(
                                style: const NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0,
                                    color: kPrimaryWhite),
                                child: InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    songprovider.setIndex(index);

                                    songprovider.playsong(index);

                                    return MusicScreen();
                                  })),
                                  child: Container(
                                    width: 500,
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Hero(
                                          tag: songprovider.songmodel[index].id,
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: kPrimaryPink,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Icon(
                                              Icons.music_note,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 130.0,
                                                child: Text(
                                                  item.data![index].title,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: kPrimaryBlack),
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        NeumorphicButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            songprovider.addSongById(index);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: songprovider
                                                        .favsonglist
                                                        .contains(songprovider
                                                            .songmodel[index]
                                                            .id)
                                                    ? Text(
                                                        'Saved sucessfully !!')
                                                    : Text(
                                                        'Removed successfully !!'),
                                                backgroundColor: songprovider
                                                        .favsonglist
                                                        .contains(songprovider
                                                            .songmodel[index]
                                                            .id)
                                                    ? Colors.green.shade400
                                                    : Theme.of(context)
                                                        .errorColor,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            songprovider.favsonglist.contains(
                                                    songprovider
                                                        .songmodel[index].id)
                                                ? Icons.favorite
                                                : Icons.favorite_border_sharp,
                                            color: songprovider.favsonglist
                                                    .contains(songprovider
                                                        .songmodel[index].id)
                                                ? kPrimaryPink
                                                : kPrimaryGrey,
                                            size: 20,
                                          ),
                                          style: const NeumorphicStyle(
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              shape: NeumorphicShape.flat,
                                              color: kPrimaryWhite),
                                        ),
                                        NeumorphicButton(
                                          onPressed: () {},
                                          child: const Icon(
                                            Icons.more_vert,
                                            color: kPrimaryGrey,
                                            size: 20,
                                          ),
                                          style: const NeumorphicStyle(
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              shape: NeumorphicShape.flat,
                                              color: kPrimaryWhite),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: item.data!.length,
                        );
                      })),
              Expanded(child: bottomPlayer(context))
            ],
          ),
        ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:vividly_music_player/Widgets/appbarneumusic.dart';
import 'package:vividly_music_player/constants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vividly_music_player/provider/songProvider.dart';

class MusicScreen extends StatefulWidget {
  static const routename = '/music-screen';

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  double musicThumb = 0;
  var songcurrentindex;

  NeumorphicButton neumusicctrl(
      IconData icon, double iconsize, Function myfun) {
    return NeumorphicButton(
        onPressed: () {
          myfun();
        },
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            shadowDarkColor: kPrimaryGrey,
            depth: 4,
            shadowLightColor: Colors.white,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(28)),
            color: kPrimaryWhite),
        child: Icon(
          icon,
          color: kPrimaryBlack,
          size: iconsize,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var songprovider = Provider.of<SongProvider>(context);
    setState(() {
      songcurrentindex = songprovider.songindex;
    });

    return Scaffold(
      backgroundColor: kPrimaryWhite,
      appBar: AppBarNeuMusic(context),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: songprovider.getSongs(),
            builder: (context, snapshot) => Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 55),
                  child: Hero(
                    tag: songprovider.songmodel[songcurrentindex].id,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          color: kPrimaryPink,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                          depth: 5,
                          shadowDarkColor: kPrimaryGrey),
                      child: Icon(
                        Icons.music_note,
                        size: 140,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        songprovider.songmodel[songcurrentindex].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: kPrimaryBlack,
                        ),
                      ),
                      Text(
                        songprovider.songmodel[songcurrentindex].artist ==
                                "<unknown>"
                            ? "Unknown Artist"
                            : songprovider.songmodel[songcurrentindex].artist!,
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: kPrimaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(songprovider.audioplayer.position
                                .toString()
                                .split(".")[0]
                                .substring(2)),
                            Text(songprovider.audioplayer.duration == null
                                ? "00:00"
                                : songprovider.audioplayer.duration!
                                    .toString()
                                    .split(".")[0]
                                    .substring(2))
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8, elevation: 5)),
                        child: Slider(
                          onChanged: (value) {},
                          value: songprovider.audioplayer.position.inSeconds
                              .toDouble(),
                          max: songprovider.audioplayer.duration == null
                              ? 0
                              : songprovider.audioplayer.duration!.inSeconds
                                  .toDouble(),
                          min: 0,
                          activeColor: kPrimaryBlack,
                          inactiveColor: kPrimaryGrey,
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: songprovider.audioplayer.currentIndexStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == false) {
                        setState(() {
                          songprovider.playnextSong();
                        });
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          neumusicctrl(Icons.skip_previous, 25, () {
                            songprovider.playprevioussong();
                          }),
                          neumusicctrl(
                              songprovider.songstatus
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              38, () {
                            setState(() {
                              songprovider.songstatus =
                                  !songprovider.songstatus;
                              if (!songprovider.songstatus) {
                                songprovider.audioplayer.pause();
                              } else {
                                songprovider.audioplayer.play();
                              }
                            });
                          }),
                          neumusicctrl(Icons.skip_next, 25, () {
                            songprovider.playnextSong();
                          }),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

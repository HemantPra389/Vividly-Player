import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:vividly_music_player/provider/songProvider.dart';

import '../constants.dart';

Neumorphic bottomPlayer(BuildContext context) {
  var songprovider = Provider.of<SongProvider>(context);
  return Neumorphic(
    style: NeumorphicStyle(
        color: kPrimaryYellow.withOpacity(.3),
        depth: 5,
        lightSource: LightSource.bottom,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.beveled(BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)))),
    child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SliderTheme(
                      data: const SliderThemeData(
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8, elevation: 5)),
                      child: Slider(
                        onChanged: (value) {
                          songprovider.audioplayer
                              .seek(Duration(seconds: value.toInt()));
                        },
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
                    ),
                  )
                ],
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        songprovider.isShuffle = !songprovider.isShuffle;
                      },
                      icon: Icon(
                        Icons.shuffle,
                        size: 25,
                        color: songprovider.isShuffle
                            ? kPrimaryBlack
                            : kPrimaryGrey,
                      )),
                  IconButton(
                      onPressed: () {
                        songprovider.playprevioussong();
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        size: 25,
                        color: kPrimaryBlack,
                      )),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        songprovider.songstatus = !songprovider.songstatus;
                        if (!songprovider.songstatus) {
                          songprovider.audioplayer.pause();
                        } else {
                          songprovider.audioplayer.play();
                        }
                      },
                      icon: Icon(
                        songprovider.songstatus
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50,
                        color: kPrimaryBlack,
                      )),
                  IconButton(
                      onPressed: () {
                        songprovider.playnextSong();
                      },
                      icon: Icon(
                        Icons.skip_next,
                        size: 25,
                        color: kPrimaryBlack,
                      )),
                  IconButton(
                      onPressed: () {
                        songprovider.isRepeat = !songprovider.isRepeat;
                        if (songprovider.isRepeat == false) {
                          songprovider.audioplayer.setLoopMode(LoopMode.all);
                        } else if (songprovider.isRepeat == true) {
                          songprovider.audioplayer.setLoopMode(LoopMode.one);
                        }
                      },
                      icon: Icon(
                        songprovider.isRepeat ? Icons.repeat_one : Icons.repeat,
                        size: 25,
                        color: kPrimaryGrey,
                      )),
                ],
              ),
            ),
          ],
        )),
  );
}

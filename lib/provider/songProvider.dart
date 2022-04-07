import 'dart:async';
import 'dart:developer';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart';

class SongProvider with ChangeNotifier {
  final audioplayer = AudioPlayer();
  double currenttime = 0;
  List<int> favsonglist = [];
  late int songindex;
  late List<SongModel> songmodel;
  var songstatus = false;
  bool isRepeat = false;
  bool isShuffle = false;

  Future<List<SongModel>> getSongs() async {
    var audioQuery = new OnAudioQuery();
    songmodel = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        path: '/storage/emulated/0/Download',
        ignoreCase: true);

    notifyListeners();
    return songmodel;
  }

  setIndex(int index) {
    songindex = index;
  }

  Future<void> playsong(int index) async {
    audioplayer
        .setAudioSource(AudioSource.uri(Uri.parse(songmodel[index].uri!)));
    audioplayer.play();

    songstatus = true;
  }

  playnextSong() {
    songindex++;
    playsong(songindex);
    setIndex(songindex);
    notifyListeners();
  }

  playprevioussong() {
    songindex--;
    playsong(songindex);
    setIndex(songindex);
    notifyListeners();
  }

  Future<List<SongModel>> getFavoriteSongs() async {
    return songmodel
        .where((element) => favsonglist.contains(element.id))
        .toList();
  }

  Future<void> addSongById(int index) async {
    if (favsonglist.contains(songmodel[index].id)) {
      favsonglist.remove(songmodel[index].id);
    } else {
      favsonglist.add(songmodel[index].id);
    }
    notifyListeners();
    print(favsonglist);
  }
}

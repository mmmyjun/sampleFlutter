import 'package:flutter/material.dart';

/// 歌词
class LrcModel {
  String lrc;
  String time;

  LrcModel({required this.lrc, this.time = ''});

  factory LrcModel.fromMap(Map<String, dynamic> map) {
    return LrcModel(
      lrc: map['lrc'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lrc': lrc,
      'time': time,
    };
  }
}

typedef OnMusicChanged = void Function(String songId, bool isPlaying);

/// 歌曲列表
class SongListModel {
  final String songId;
  final String songName;
  final String songUrl;
  String artist = '';
  String? cover = '';
  List<LrcModel>? lrcArr = [];
  bool isPlaying = false;
  OnMusicChanged onChanged = (String songId, bool isPlaying) {};

  SongListModel(
      {required this.songId,
      required this.songName,
      required this.songUrl,
      required this.artist,
      required this.cover,
      required this.lrcArr,
      required this.isPlaying,
      required this.onChanged});

  factory SongListModel.fromMap(Map<String, dynamic> map) {
    List<LrcModel> lArr = [];
    if (map['lrcArr'] != null) {
      for (final lrcItem in map['lrcArr']) {
        lArr.add(LrcModel.fromMap(lrcItem));
      }
    }
    return SongListModel(
        songId: map['songId'],
        songName: map['songName'],
        songUrl: map['songUrl'],
        artist: map['artist'],
        cover: map['cover'],
        lrcArr: lArr,
        isPlaying: map['isPlaying'],
        onChanged: map['onChanged']);
  }

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'songName': songName,
      'artist': artist,
      'cover': cover,
      'lrcArr': lrcArr,
    };
  }
}

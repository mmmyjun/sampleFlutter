import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:html/parser.dart';

import './song_list.dart';

import '../../request/song_api.dart';
import './music_models.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool hasSearch = false;

  @override
  void initState() {
    super.initState();
  }

  final inputController = TextEditingController(text: '');
  List<SongListModel> songList = [];

  void _onMusicChanged(String songId, bool isPlaying) {
    setState(() {
      for (var i = 0; i < songList.length; i++) {
        if (songList[i].songId == songId) {
          songList[i].isPlaying = isPlaying;
        } else {
          songList[i].isPlaying = false;
        }
      }
    });
  }

  Future<void> toSearch() async {
    EasyLoading.show(status: 'loading...');

    songList = [];

    SongApi().getAllSongInfo(inputController.text).then((value) {
      print(value);
      EasyLoading.dismiss();
      hasSearch = true;

      var code = value['code'];
      List data = value['data'];
      for (int i = 0; i < data.length; i++) {
        var song = data[i];
        var songId = song['id'];
        var songName = song['name'];
        var songUrl = 'https://code-app.netlify.app/${song['url']}';
        var artist = song['artist'];
        var cover = song['poster'];
        List<LrcModel> lrcArr = [];
        var isPlaying = false;
        var onChanged = _onMusicChanged;
        songList.add(SongListModel(
          songId: songId,
          songName: songName,
          songUrl: songUrl,
          artist: artist,
          cover: cover,
          lrcArr: lrcArr,
          isPlaying: isPlaying,
          onChanged: onChanged,
        ));
      }
      setState(() {});

    //   String test = value['data'];
    //   var document = parse(test);
    //   var domRow = document.querySelectorAll('.card-text .row');
    //   List<SongListModel> tempList = [];
    //   for (var parentDom in domRow) {
    //     final aItem = parentDom.querySelector('a');
    //     String aHref = '', aText = '', songId = '';
    //     if (aItem != null) {
    //       aHref = aItem.attributes['href']!;
    //       aText = aItem.text;
    //       if (aHref != '') {
    //         songId = aHref.split('/').last;
    //       }
    //       String? artistText =
    //           parentDom.querySelector('.text-success.col-4.col-content')?.text;
    //       String songUrl = '';
    //       await SongApi().getSongUrlById(songId).then((value) {
    //         if (value['data'] != null) {
    //           songUrl = value['data']['url'];
    //         }
    //       }).catchError((e) {
    //         songUrl = '暂无声源';
    //         print('songUrl error $songId: $e');
    //       });
    //       print(
    //           'songId: $songId, songName: ${aText.trim()}, artist: ${artistText?.trim()},, songUrl: $songUrl');
    //       tempList.add(SongListModel.fromMap({
    //         'songId': songId,
    //         'songName': aText.trim(),
    //         'songUrl': songUrl,
    //         'artist': artistText?.trim() ?? '未知艺术家',
    //         'cover': '',
    //         'lrcArr': [],
    //         'isPlaying': false,
    //         'onChanged': _onMusicChanged,
    //       }));
    //     }
    //   }
    //   setState(() {
    //     songList = tempList;
    //     print('songList: ${songList.length}');
    //     EasyLoading.dismiss();
    //   });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('音乐宝藏'),
          ),
          body: Column(
            children: [
              Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: inputController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '请输入歌曲/歌手名称',
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          toSearch();
                        },
                      ),
                    )),
                    SizedBox(
                      width: 70,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: inputController.text.isEmpty ? MaterialStateProperty.all(Colors.grey): MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: () {
                          if (inputController.text.isEmpty) return;
                          toSearch();
                        },
                        child: const Text('搜索'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
                child: Text(hasSearch == false ? '' : (songList.isEmpty ? '暂无数据' : '共${songList.length}首歌')),
              ),
              songList.isNotEmpty ? const Divider(height: 1) : const SizedBox.shrink(),
              Expanded(child: SongList(songList: songList))
            ],
          )),
    );
  }
}

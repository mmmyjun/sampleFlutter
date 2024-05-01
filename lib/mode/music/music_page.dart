import 'package:flutter/material.dart';
import 'dart:convert';

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

  // @override
  // void dispose() {
  //   EasyLoading.dismiss();
  // }

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
      print('request list success:::$value');
      EasyLoading.dismiss();
      hasSearch = true;

      var code = value['code'];
      List data = value['data'];
      for (int i = 0; i < data.length; i++) {
        var song = data[i];
        var songId = song['id'];
        var songName = song['name'];
        var songUrl = 'https://media-online.netlify.app${song['url']}';
        var artist = song['artist'];
        var cover = 'https://media-online.netlify.app${song['poster']}';
        // print('cover::$cover');
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
    }).catchError((e){
      EasyLoading.dismiss();
      print('request list error:::$e');
    });
  }

  get inputContentIsEmpty =>
      inputController.text.isEmpty || inputController.text.trim() == '';

  void clearSearch() {
    inputController.clear();
    setState(() {});
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
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: inputController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: '请输入歌曲/歌手名称',
                                suffixIcon: IconButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(
                                          inputContentIsEmpty
                                              ? Colors.grey
                                              : Colors.purple),
                                    ),
                                    onPressed:
                                        inputContentIsEmpty ? () {} : clearSearch,
                                    icon: Icon(inputContentIsEmpty
                                        ? Icons.search
                                        : Icons.clear))),
                            onChanged: (value) {
                              setState(() {});
                            },
                            onSubmitted: (value) {
                              if (inputContentIsEmpty) return;
                              toSearch();
                            },
                          ),
                        )
                    ),
                    SizedBox(
                      width: 70,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: inputContentIsEmpty
                              ? MaterialStateProperty.all(Colors.grey)
                              : MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: () {
                          if (inputContentIsEmpty) return;
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
                child: Text(hasSearch == false
                    ? ''
                    : (songList.isEmpty ? '暂无数据' : '共${songList.length}首歌')),
              ),
              songList.isNotEmpty
                  ? const Divider(height: 1)
                  : const SizedBox.shrink(),
              Expanded(child: SongList(lists: songList))
            ],
          )),
    );
  }
}

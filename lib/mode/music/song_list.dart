import 'package:flutter/material.dart';

import './music_models.dart';

import './player_widget.dart';
import '../../request/song_api.dart';
import 'package:html/parser.dart';

import 'package:audioplayers/audioplayers.dart';

class SongList extends StatefulWidget {
  List<SongListModel> lists = [];
  SongList({Key? key, required this.lists}) : super(key: key);

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  int activeIndex = -1;

  get parentList => widget.lists;

  AudioPlayer player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: parentList.length,
        itemBuilder: (_, int index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(parentList[index].cover,
                    width: 50, height: 50, fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const Text('暂无图片', style: TextStyle(fontSize: 16));
                  },
                ),
                // 捕获上面这句图片报错的异常，怎么重写?
                Text(parentList[index].songName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: parentList[index].songUrl == '暂无声源'
                            ? Colors.grey
                            : Colors.black)),
                const SizedBox(width: 12),
                Text(parentList[index].artist ?? '',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue)),
              ],
            ), // 这行放songName和artist
            subtitle:
                activeIndex == index && parentList[index].songUrl != '暂无声源'
                    ? PlayerWidget(player: player)
                    : const SizedBox.shrink(),
            onTap: () {
              if (activeIndex != index) {
                player.stop();
                activeIndex = index;
              }
              if (parentList[index].songUrl != '暂无声源') {
                if (!parentList[index].isPlaying) {
                  player.play(UrlSource(parentList[index].songUrl));
                } else {
                  player.pause();
                }
              }
              parentList[index].onChanged(parentList[index].songId,
                  !parentList[index].isPlaying);
            },
            trailing: parentList[index].isPlaying
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          );
        });
  }
}

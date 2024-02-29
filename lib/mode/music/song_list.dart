import 'package:flutter/material.dart';

import './music_models.dart';

import './player_widget.dart';
import '../../request/song_api.dart';
import 'package:html/parser.dart';

import 'package:audioplayers/audioplayers.dart';

class SongList extends StatefulWidget {
  List<SongListModel> songList = [];
  SongList({Key? key, required this.songList}) : super(key: key);

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  int activeIndex = -1;

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
        itemCount: widget.songList.length,
        itemBuilder: (_, int index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.songList[index].songName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24,
                        color: widget.songList[index].songUrl == '暂无声源'
                            ? Colors.grey
                            : Colors.black)),
                const SizedBox(width: 12),
                Text(widget.songList[index].artist ?? '',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue)),
              ],
            ), // 这行放songName和artist
            subtitle:
                activeIndex == index && widget.songList[index].songUrl != '暂无声源'
                    ? PlayerWidget(player: player)
                    : const SizedBox.shrink(),
            onTap: () {
              if (activeIndex != index) {
                player.stop();
                activeIndex = index;
              }
              if (widget.songList[index].songUrl != '暂无声源') {
                if (!widget.songList[index].isPlaying) {
                  player.play(UrlSource(widget.songList[index].songUrl));
                } else {
                  player.pause();
                }
              }
              widget.songList[index].onChanged(widget.songList[index].songId,
                  !widget.songList[index].isPlaying);
            },
            trailing: widget.songList[index].isPlaying
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          );
        });
  }
}

// Make sure to add following packages to pubspec.yaml:
// * media_kit
// * media_kit_video
// * media_kit_libs_video
import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';          // Provides [VideoController] & [Video] etc.


class MyScreen extends StatefulWidget {
  String currentUrl;
  MyScreen({Key? key, required this.currentUrl}) : super(key: key);

  @override
  State<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  get parentUrl => widget.currentUrl;

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(parentUrl));
    // player.open(Media('https://spacedeta-1-f1000878.deta.app/api/video/hls/pure/aHR0cHM6Ly95enp5MS5wbGF5LWNkbjE2LmNvbS8yMDIzMTAyNi8yNTM2NF80OTgwMjJjZi9pbmRleC5tM3U4.m3u8'));
    // https://spacedeta-1-f1000878.deta.app/api/video/hls/pure/aHR0cHM6Ly95enp5MS5wbGF5LWNkbjE2LmNvbS8yMDIzMTAyNi8yNTM2NF80OTgwMjJjZi9pbmRleC5tM3U4.m3u8


    // player.stream.position.listen(
    //       (Duration position) {
    //     print('stream position: $position');
    //     // flutter: stream position: 0:00:00.086222
    //     setState(() {
    //       // Update UI.
    //     });
    //   },
    // );
    // player.stream.duration.listen((event) {
    //   print('dr:event: $event'); // 总时长
    //   // flutter: dr:event: 0:58:39.000000
    // });
    // player.stream.buffer.listen((event) {
    //   print('buffer:event: $event');
    //   // 0:02:31.406222
    // });
  }



  void setPosition() {
    // 0:00:00.246222
    player.seek(
      const Duration(
        hours: 0,
        minutes: 6,
        seconds: 9,
        // milliseconds:
        // microseconds:
      ),
    );
  }


  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('oldWidget url: $oldWidget');
    print('${oldWidget.currentUrl}');
    print(widget.currentUrl);
    if (widget.currentUrl != oldWidget.currentUrl) {
      player.open(Media(widget.currentUrl));
    }
    // if (oldWidget.url != widget.url) {
    //   _disposePlayer().then((value) => _initPlayer(autoplay: true));
    // }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          // Use [Video] widget to display video output.
          child: Video(controller: controller),
        ),
        // Positioned(
        //   top: 100,
        //   left: 30,
        //   child: IconButton(
        //     iconSize: 36,
        //     onPressed: () {
        //       print("后退10s~~ ");
        //     },
        //     icon: Icon(Icons.fast_rewind),
        //     // It's not necessary to use [StreamBuilder] or to use [Player] & [VideoController] from [state].
        //     // [StreamSubscription]s can be made inside [initState] of this widget.
        //   ),
        // ),
        // Positioned(
        //   top: 100,
        //   right: 30,
        //   child: IconButton(
        //     iconSize: 36,
        //     onPressed: () {
        //       print("前进10s~~ ");
        //     },
        //     icon: Icon(Icons.fast_forward),
        //     // It's not necessary to use [StreamBuilder] or to use [Player] & [VideoController] from [state].
        //     // [StreamSubscription]s can be made inside [initState] of this widget.
        //   ),
        // ),
      ],
    );
  }
}
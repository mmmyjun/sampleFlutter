// Make sure to add following packages to pubspec.yaml:
// * media_kit
// * media_kit_video
// * media_kit_libs_video
import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';          // Provides [VideoController] & [Video] etc.

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Necessary initialization for package:media_kit.
//   MediaKit.ensureInitialized();
//   runApp(
//     const MaterialApp(
//       home: MyScreen(),
//     ),
//   );
// }

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

  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    // TODO: implement didUpdateWidget
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
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // Use [Video] widget to display video output.
        child: Video(controller: controller),
      ),
    );
  }
}
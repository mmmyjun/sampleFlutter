import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.

import './home.dart';

import './request/http_utils/base_api.dart';

import './mode/tv/tv_video_player.dart';

import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  HttpUtils().init(); // 初始化网络请求
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  void setThemeMode(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
        primaryColor: Colors.purple,
      ),
      themeMode: themeMode,
      home: MyHomePage(title: 'Home Page', themeMode: themeMode, setThemeMode: setThemeMode),
      // home: Platform.isAndroid || Platform.isIOS  ? TvVideoPlayer() : MyHomePage(title: 'Home Page', themeMode: themeMode, setThemeMode: setThemeMode),
    );
  }
}


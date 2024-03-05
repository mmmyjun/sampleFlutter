
import 'package:flutter/material.dart';

import './home.dart';

import './request/http_utils/base_api.dart';

void main() {
  HttpUtils(); // 初始化网络请求

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
    );
  }
}


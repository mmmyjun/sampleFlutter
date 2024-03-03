import 'package:flutter/material.dart';

import './common_model.dart';

import 'package:sample_flutter/mode/music/music_page.dart';
import './mode/notes/notes_page.dart';
import './mode/memo/memo_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.themeMode,
      required this.setThemeMode});

  final String title;
  final ThemeMode themeMode;
  final void Function(ThemeMode mode) setThemeMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  List<WidgetModel> widgetArr = [
    WidgetModel('音乐', const Icon(Icons.music_video, color: Colors.green),
        const MusicPage()),
    WidgetModel(
        '备忘录',
        const Icon(Icons.query_stats_outlined, color: Colors.green),
        const MemoPage()),
    WidgetModel('笔记', const Icon(Icons.edit_note, color: Colors.green),
        const NotesPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Tooltip(
            message: 'system theme',
            child: IconButton(
              icon: const Icon(Icons.auto_awesome),
              onPressed: () {
                widget.setThemeMode(ThemeMode.system);
              },
            ),
          ),
          Tooltip(
            message: 'light',
            child: IconButton(
              icon: const Icon(Icons.light_mode),
              onPressed: () {
                widget.setThemeMode(ThemeMode.light);
              },
            ),
          ),
          Tooltip(
            message: 'dark',
            child: IconButton(
              icon: const Icon(Icons.dark_mode),
              onPressed: () {
                widget.setThemeMode(ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 200,
            child: GridContainer(widgetArr: widgetArr),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.purple,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class GridContainer extends StatefulWidget {
  List<WidgetModel> widgetArr = [];
  GridContainer({super.key, required this.widgetArr});

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.widgetArr.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 1000
                ? 6
                : (MediaQuery.of(context).size.width > 600 ? 4 : 3)),
        itemBuilder: (_, int index) {
          return InkWell(
            child: GridTile(
                child: Column(
              children: [
                Expanded(
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    iconSize: MediaQuery.of(context).size.width > 1000
                        ? 80
                        : (MediaQuery.of(context).size.width > 600 ? 60 : 30),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => widget.widgetArr[index].child));
                    },
                    icon: widget.widgetArr[index].icon,
                    color: Colors.blue,
                  ),
                ),
                Text(widget.widgetArr[index].name),
              ],
            )),
          );
        });
  }
}

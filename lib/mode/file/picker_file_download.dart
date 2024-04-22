import 'dart:convert';
import 'package:download/download.dart';
import 'package:flutter/material.dart';

class PickerFileDownlod extends StatefulWidget {
  const PickerFileDownlod({Key? key}) : super(key: key);

  @override
  State<PickerFileDownlod> createState() => _PickerFileDownlodState();
}

class _PickerFileDownlodState extends State<PickerFileDownlod> {
  void _download() {
    final stream = Stream.fromIterable(utf8.encode('Hello World啊呀!' ));
    print('stream: $stream');
    download(stream, './lib/mode/file/hi.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Download'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Click the FAB to download.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _download,
        tooltip: 'Download',
        child: const Icon(Icons.download),
      ),
    );
  }
}
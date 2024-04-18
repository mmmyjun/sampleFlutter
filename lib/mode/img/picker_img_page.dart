import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickerImgPage extends StatefulWidget {
  const PickerImgPage({Key? key}) : super(key: key);

  @override
  State<PickerImgPage> createState() => _PickerImgPageState();
}

class _PickerImgPageState extends State<PickerImgPage> {
  // Future<void> getLostData() async {
  //   final ImagePicker picker = ImagePicker();
  //   final LostDataResponse response = await picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   final List<XFile>? files = response.files;
  //   if (files != null) {
  //     // _handleLostFiles(files);
  //   } else {
  //     // _handleError(response.exception);
  //   }
  //   print(files);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final LostDataResponse response = await picker.retrieveLostData();
              if (response.isEmpty) {
                return;
              }
              final List<XFile>? files = response.files;
              if (files != null) {
                // _handleLostFiles(files);
              } else {
                // _handleError(response.exception);
              }
              print(files);
            },
            child: const Text('选择图片'),
          ),
        ],
      ),
    );
  }
}

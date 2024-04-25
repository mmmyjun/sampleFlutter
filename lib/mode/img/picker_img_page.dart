import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';

import './preview/picker_preview_photo_single.dart';
import './preview/picker_preview_photo_multiple.dart';

class PickerImgPage extends StatefulWidget {
  const PickerImgPage({Key? key}) : super(key: key);

  @override
  State<PickerImgPage> createState() => _PickerImgPageState();
}

class _PickerImgPageState extends State<PickerImgPage> {
  int selectedOne = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件'),
      ),
      body: Column(
        children: [
          DropdownButton(
              value: selectedOne,
              items: [
                DropdownMenuItem(child: Text('单个图片'), value: 1),
                DropdownMenuItem(child: Text('多个图片'), value: 2),
              ],
              onChanged: (value) {
                print('选择图片=====$value');
                setState(() {
                  selectedOne = value as int;
                });
              }
          ),
          Expanded(
            child: selectedOne == 1 ? PickerPreviewPhotoSingle() : PickerPreviewPhotoMultiple(),
          )
        ],
      ),
    );
  }
}

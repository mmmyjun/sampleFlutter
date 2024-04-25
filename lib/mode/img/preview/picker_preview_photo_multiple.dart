import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import './picker_preview_photo_multiple_gallery.dart';

class PickerPreviewPhotoMultiple extends StatefulWidget {
  const PickerPreviewPhotoMultiple({Key? key}) : super(key: key);

  @override
  State<PickerPreviewPhotoMultiple> createState() => _PickerPreviewPhotoMultipleState();
}

class _PickerPreviewPhotoMultipleState extends State<PickerPreviewPhotoMultiple> {
  Uint8List? bytes;
  void setBytes(value) {
    setState(() {
      bytes = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       TextButton(
         onPressed: () {
           print('多图片选择');
         },
         child: Text('多图片'),
       ),
        Expanded(
          child: PickerPreviewPhotoMultipleGallery(galleryItems: [
            GelleryImgModel(id: '1', image: 'assets/yellowFlower.jpeg'),
            GelleryImgModel(id: '2', image: 'assets/dog.jpg'),
            GelleryImgModel(id: '3', image: 'assets/ha.jpg'),
          ]),
        )
      ],
    );
  }
}

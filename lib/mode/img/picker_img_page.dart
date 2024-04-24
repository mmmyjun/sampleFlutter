import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';

class PickerImgPage extends StatefulWidget {
  const PickerImgPage({Key? key}) : super(key: key);

  @override
  State<PickerImgPage> createState() => _PickerImgPageState();
}

class _PickerImgPageState extends State<PickerImgPage> {
  Uint8List? bytes;
  void setBytes(value) {
    setState(() {
      bytes = value;
    });
  }

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
              // print(picker);

              // Pick an image.
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              print('path:::${image!.path}');
              setBytes(await image!.readAsBytes());


              // Capture a photo.
              // final XFile? photo =
              //     await picker.pickImage(source: ImageSource.camera);
              // print(photo);

              // Pick a video.
              // final XFile? galleryVideo =
              //     await picker.pickVideo(source: ImageSource.gallery);
              // print(galleryVideo);

              // Capture a video.
              // final XFile? cameraVideo =
              //     await picker.pickVideo(source: ImageSource.camera);

              // Pick multiple images.
              // final List<XFile> images = await picker.pickMultiImage();
              // print(images);

              // Pick singe image or video.
              // final XFile? media = await picker.pickMedia();

              // Pick multiple images and videos.
              // final List<XFile> medias = await picker.pickMultipleMedia();


              // final LostDataResponse response = await picker.retrieveLostData();
              // if (response.isEmpty) {
              //   return;
              // }
              // final List<XFile>? files = response.files;
              // if (files != null) {
              //   // _handleLostFiles(files);
              // } else {
              //   // _handleError(response.exception);
              // }
              // print(files);
            },
            child: const Text('选择图片'),
          ),
          bytes != null ? Image.memory(bytes!, width: 100, height: 100,) : SizedBox.shrink(),
          TextButton(
              onPressed: (){
                print('预览图片=====');
              },
              child: Text('预览图片')
          ),
          Expanded(
            child: bytes != null ? PhotoView(
              imageProvider: MemoryImage(bytes!),
            ) : SizedBox.shrink(),
          )

        ],
      ),
    );
  }
}

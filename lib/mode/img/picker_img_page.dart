import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
          bytes != null ? Image.memory(bytes!) : SizedBox.shrink(),
          ElevatedButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              // print(picker);

              // Pick an image.
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
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
        ],
      ),
    );
  }
}

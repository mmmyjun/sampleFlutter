import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PickerFileMultiple extends StatefulWidget {
  const PickerFileMultiple({Key? key}) : super(key: key);

  @override
  State<PickerFileMultiple> createState() => _PickerFileMultipleState();
}

class _PickerFileMultipleState extends State<PickerFileMultiple> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              print(result);
              List<File> files = result.paths.map((path) => File(path!)).toList();
              print(files);
            } else {
              // User canceled the picker
            }
          },
          child: const Text('选择多个文件'),
        ),
      ],
    );
  }
}

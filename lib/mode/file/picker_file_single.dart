import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickerFileSingle extends StatefulWidget {
  const PickerFileSingle({Key? key}) : super(key: key);

  @override
  State<PickerFileSingle> createState() => _PickerFileSingleState();
}

class _PickerFileSingleState extends State<PickerFileSingle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              print(result.files.single.path);

              PlatformFile file = result.files.first;
              print(file.name);
              print(file.bytes);
              print(file.size);
              print(file.extension);
              print(file.path);
            } else {
              // User canceled the picker
            }
          },
          child: const Text('选择单个文件'),
        ),
      ],
    );
  }
}

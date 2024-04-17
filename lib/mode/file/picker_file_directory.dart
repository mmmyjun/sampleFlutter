import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickerFileDirectory extends StatefulWidget {
  const PickerFileDirectory({Key? key}) : super(key: key);

  @override
  State<PickerFileDirectory> createState() => _PickerFileDirectoryState();
}

class _PickerFileDirectoryState extends State<PickerFileDirectory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

            if (selectedDirectory == null) {
              // User canceled the picker
            }
          },
          child: const Text('选择文件夹'),
        ),
      ],
    );
  }
}

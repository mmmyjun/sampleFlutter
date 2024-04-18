import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickerFileMultipleWithExtension extends StatefulWidget {
  const PickerFileMultipleWithExtension({Key? key}) : super(key: key);

  @override
  State<PickerFileMultipleWithExtension> createState() => _PickerFileMultipleWithExtensionState();
}

class _PickerFileMultipleWithExtensionState extends State<PickerFileMultipleWithExtension> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'pdf', 'doc'],
            );
            print(result);
          },
          child: const Text('选择多个文件附带后缀'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickerFilePage extends StatefulWidget {
  const PickerFilePage({Key? key}) : super(key: key);

  @override
  State<PickerFilePage> createState() => _PickerFilePageState();
}

class _PickerFilePageState extends State<PickerFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件'),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
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
                  child: const Text('选择文件'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

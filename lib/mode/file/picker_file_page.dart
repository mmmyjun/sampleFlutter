import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import './picker_file_single.dart';
import './picker_file_multiple.dart';
import './picker_file_multiple_extension.dart';
import './picker_file_directory.dart';

import './pdf/picker_file_pdf.dart';

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
      // body: PickerFileSingle(),
      // body: PickerFileMultiple(),
      // body: PickerFileMultipleWithExtension(),
      // body: PickerFileDirectory(),

      body: PickerFilePdf(),

      // body: Column(
      //   children: [
      //     Center(
      //       child: Column(
      //         children: [
      //           // SizedBox(
      //           //   height: 20,
      //           //   child: PickerFileSingle(),
      //           // ),
      //           // PickerFileMultiple(),
      //           // PickerFileMultipleWithExtension(),
      //           // PickerFileDirectory(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

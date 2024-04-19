import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import './picker_file_pdf.dart';

class PickerFilePDFPage extends StatefulWidget {
  const PickerFilePDFPage({Key? key}) : super(key: key);

  @override
  State<PickerFilePDFPage> createState() => _PickerFilePDFPageState();
}

class _PickerFilePDFPageState extends State<PickerFilePDFPage> {
  int pdfPageNum = 1;
  final PdfViewerController _controller = PdfViewerController();

  void _incrementCounter(newValue) {
    setState(() {
      print('newValue: $newValue');
      pdfPageNum = newValue;
      _controller.jumpToPage(pdfPageNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: TextButton(
            onPressed: () {
              _incrementCounter(30);
            },
            child: Text('点击跳转到固定页30'),
          ),
        ),
        Expanded(
          child: PickerFilePdf(controller: _controller),
        )
      ],
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('pdf预览'),
    //   ),
    //   body: PickerFilePdf(),
    //
    // );
  }
}

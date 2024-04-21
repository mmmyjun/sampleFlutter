import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import './picker_file_pdf_network_detail.dart';

class PickerFilePDFNetworkPage extends StatefulWidget {
  const PickerFilePDFNetworkPage({Key? key}) : super(key: key);

  @override
  State<PickerFilePDFNetworkPage> createState() => _PickerFilePDFNetworkPageState();
}

class _PickerFilePDFNetworkPageState extends State<PickerFilePDFNetworkPage> {
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
          child: Text('默认跳转到固定页20'),
        ),
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
          child: PickerFilePDFNetworkDetail(controller: _controller),
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

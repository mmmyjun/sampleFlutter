import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import './picker_file_pdf_network_page.dart';
import './picker_file_pdf_local_page.dart';

class PickerFilePDFPage extends StatefulWidget {
  const PickerFilePDFPage({Key? key}) : super(key: key);

  @override
  State<PickerFilePDFPage> createState() => _PickerFilePDFPageState();
}

class _PickerFilePDFPageState extends State<PickerFilePDFPage> {
  @override
  Widget build(BuildContext context) {
    return PickerFilePDFNetworkPage();
    // return PickerFileLocalPdfPage();
  }
}

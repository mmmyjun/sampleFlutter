import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents PickerFileLocalPdfPage for Navigation
class PickerFileLocalPdfPage extends StatefulWidget {
  PickerFileLocalPdfPage({
    Key? key,
  }) : super(key: key);

  @override
  _PickerFileLocalPdfPage createState() => _PickerFileLocalPdfPage();
}

class _PickerFileLocalPdfPage extends State<PickerFileLocalPdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.asset(
            'assets/flutter-succinctly.pdf'));
  }
}

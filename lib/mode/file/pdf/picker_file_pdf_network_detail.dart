import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents PickerFilePDFNetworkDetail for Navigation
class PickerFilePDFNetworkDetail extends StatefulWidget {
  PdfViewerController controller;
  PickerFilePDFNetworkDetail({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PickerFilePDFNetworkDetail createState() => _PickerFilePDFNetworkDetail();
}

class _PickerFilePDFNetworkDetail extends State<PickerFilePDFNetworkDetail> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        key: _pdfViewerKey,
        pageLayoutMode: PdfPageLayoutMode.single,
        currentSearchTextHighlightColor: Colors.red,
        canShowPaginationDialog: true,
        canShowPageLoadingIndicator: true,
        controller: widget.controller,
        canShowScrollHead: true,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          widget.controller.jumpToPage(20);
        },
      ),
    );
  }
}

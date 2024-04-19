import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents PickerFilePdf for Navigation
class PickerFilePdf extends StatefulWidget {
  PdfViewerController controller;
  PickerFilePdf({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PickerFilePdf createState() => _PickerFilePdf();
}

class _PickerFilePdf extends State<PickerFilePdf> {
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
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          widget.controller.jumpToPage(20);
        },
      ),
    );
  }
}

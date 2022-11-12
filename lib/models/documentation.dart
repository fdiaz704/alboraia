import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

void main() => runApp(Page1());

class Page1 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Page1> {
  static const int _initialPage = 2;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController _pdfController = PdfController(
    document: PdfDocument.openAsset('assets/documentation.pdf'),
    initialPage: _initialPage,
  );

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/documentation.pdf'),
      initialPage: _initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Tutorial IPark'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              _pdfController.previousPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '$_actualPageNumber/$_allPagesCount',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              _pdfController.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (isSampleDoc) {
                _pdfController.loadDocument(
                    PdfDocument.openAsset('assets/documentation.pdf'));
              } else {
                _pdfController.loadDocument(
                    PdfDocument.openAsset('assets/documentation.pdf'));
              }
              isSampleDoc = !isSampleDoc;
            },
          )
        ],
      ),
      body: PdfView(
        documentLoader: const Center(child: CircularProgressIndicator()),
        pageLoader: const Center(child: CircularProgressIndicator()),
        controller: _pdfController,
        onDocumentLoaded: (document) {
          setState(() {
            _allPagesCount = document.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            _actualPageNumber = page;
          });
        },
      ),
    ),
  );
}
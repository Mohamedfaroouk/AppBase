import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'myLoading.dart';

class PdfPreviewWidget extends StatelessWidget {
  const PdfPreviewWidget({
    Key? key,
    required this.invoice,
    this.initialPageFormat,
  }) : super(key: key);
  final Future<Uint8List> invoice;
  final PdfPageFormat? initialPageFormat;
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
        dpi: initialPageFormat == PdfPageFormat.a4 ? 150 : 200,
        scrollViewDecoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        pdfPreviewPageDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        initialPageFormat: initialPageFormat,
        previewPageMargin: const EdgeInsets.all(30),
        canDebug: false,
        loadingWidget: MyLoading.loadingWidget(),
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting: false,
        allowSharing: false,
        shouldRepaint: false,
        build: (format) async {
          return invoice;
        });
  }
}

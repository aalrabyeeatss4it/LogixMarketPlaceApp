import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../controllers/pdf_viewer_controller.dart' as ctx;

class PdfViewerScreen extends StatefulWidget {
  final String url;
  const PdfViewerScreen({super.key, required this.url});

  @override
  State<PdfViewerScreen> createState() => PdfViewerScreenState();
}

class PdfViewerScreenState extends State<PdfViewerScreen> {
  ctx.PdfViewerController controller = Get.put(ctx.PdfViewerController());
  @override
  void initState() {
    super.initState();
    controller.loadPdf(widget.url);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          Obx(() => (controller.fileBytes.value == null || controller.fileBytes.value!.isEmpty)? const SizedBox() : IconButton(
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (_) async => controller.fileBytes.value!,
              );
            },
            icon: Image.asset("icons/printer.png"),
          )),
          Obx(() => (controller.fileBytes.value == null || controller.fileBytes.value!.isEmpty)? const SizedBox() : IconButton(
            onPressed: () {
              Printing.sharePdf(
                bytes: controller.fileBytes.value!,
                filename: 'pdf_report.pdf',
              );
            },
            icon: Image.asset("icons/share.png"),
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.fileBytes.value != null) {
          return SfPdfViewer.memory(controller.fileBytes.value!);
        }

        return const Center(child: Text("File not found."));
      }),
    );
  }
}
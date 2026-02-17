import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/my_account_statement/pdf_viewer_screen.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/storage/local_storage.dart';
import '../../common/theme/colors.dart';
import '../../controllers/pdf_viewer_controller.dart';
import '../../controllers/token_controller.dart';

class TransactionCard extends StatefulWidget{
  final TransModel trans;
  final String ssoToken;

  const TransactionCard({super.key, required this.trans, required this.ssoToken});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  TokenController tokenController = Get.put(TokenController());
  PdfViewerController pdfController = Get.put(PdfViewerController());

  Future<void> launchInBrowser(Uri url) async {
    print("Full URL: ${url.toString()}");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.withOpacity(0.9),width: 0.2),borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0,top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("icons/trans.png", width: 45,),
                      const SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.trans.description??"",style: const TextStyle( fontSize: 16,fontWeight: FontWeight.w900),),
                          Text(widget.trans.getTransNo(),style: const TextStyle(color: Colors.grey, fontSize: 14),)
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.trans.amount??"",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                          const SizedBox(width: 8),
                          Image.asset('icons/riyal.png' ,width: 18,color: Colors.black,),
                        ]
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("icons/date.png", width: 20,),
                  const SizedBox(width: 5,),
                  Text(widget.trans.transDate??"",style: const TextStyle(fontSize: 14, color: Colors.grey),),
                ],
              ),
            ),
            (widget.trans.docTypeId!="")?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child:
                      // Obx(() =>
                          ElevatedButton(
                          onPressed: () async {
                            String? reportUrl = widget.trans.getPrintUrl(box.read(userIdIndex), widget.ssoToken);
                            if(reportUrl!=null){
                              await pdfController.loadPdf(reportUrl);
                              if(pdfController.fileBytes.value != null && pdfController.fileBytes.value!.isNotEmpty) {
                                await Printing.layoutPdf(onLayout: (_) async => pdfController.fileBytes.value!);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor:  grayBorderColor3,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: const BorderSide(color: Colors.grey, width: 1))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("icons/printer.png", width: 25,),
                              const SizedBox(width: 10,),
                              Text('print'.tr, style: const TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                      // ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          String? reportUrl = widget.trans.getPrintUrl(box.read(userIdIndex), widget.ssoToken);
                          if(reportUrl!=null){
                            await pdfController.loadPdf(reportUrl);
                            if(pdfController.fileBytes.value != null && pdfController.fileBytes.value!.isNotEmpty) {
                              await Printing.sharePdf(bytes: pdfController.fileBytes.value!,filename: 'pdf_report.pdf');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor:  remainingColor,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: const BorderSide(color: remainingColor, width: 1))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("icons/share.png", width: 25,color: remainingColor,),
                            const SizedBox(width: 10,),
                            Text('share'.tr, style: const TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):const SizedBox()
          ],
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/storage/local_storage.dart';
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

  Future<void> launchInBrowser(Uri url) async {
    print("url.path:"+url.path);
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
    return InkWell(
      onTap: (){
        // launchInBrowser(Uri.parse('${GetStorage().read(erpUrl)}/Apps/Sales/Crystalreports/Report_Viewer?Rep_ID=2&Type=1&T_ID=${detailTransactionController.saleOderModel.transactionsDetails!.details!.id}&token=${generateController.generateTokenModel.token}&User_Id=${generateController.generateTokenModel.userId}'));
        // launchInBrowser(Uri.parse('https://test.logix-erp.com/Apps/Sales/Crystalreports/Report_Viewer?Rep_ID=2&Type=1&T_ID=11192&token=Uz3jVoLUnRQM19jlcA79UTZaqDKliU0iw&USER_ID=18339&Send_TO=1'));
        // launchInBrowser(Uri.parse('http://localhost:8082/Apps/Sales/Invoices/PdfReport?Rep_ID=1&USER_ID=1&token=qqZXTAQGm9cmTAuu05IqV7tJ2EK1It9Hq&T_ID=74561'));
        // launchInBrowser(Uri.parse('http://localhost:8082/Apps/Sales/Invoices/PdfReport?Rep_ID=2&USER_ID=1&token=qqZXTAQGm9cmTAuu05IqV7tJ2EK1It9Hq&T_ID=107704'));
        String? reportUrl = widget.trans.getPrintUrl(box.read(userIdIndex), widget.ssoToken);
        print("reportUrl:"+reportUrl!);
        if(reportUrl!=null){
          launchInBrowser(Uri.parse(reportUrl));
        }
      },
      child: Card(
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
                        Text('amount'.tr,style: const TextStyle(fontSize: 16),),
                        const SizedBox(width: 5,),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.trans.amount??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                              const SizedBox(width: 3),
                              Image.asset('icons/riyal.png' ,width: 14,color: Colors.black,),
                            ]
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text('date'.tr,style: const TextStyle(fontSize: 18,color: Colors.grey),),
                          ),
                          const SizedBox(width: 5,),
                          Text(widget.trans.transDate??"",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('note'.tr,style: const TextStyle(fontSize: 16),),
                          const SizedBox(width: 5,),
                          Text(widget.trans.description??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)
                        ]
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
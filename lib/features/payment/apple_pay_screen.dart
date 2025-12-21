import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';
import 'package:pay/pay.dart';

import 'payment_configurations.dart' as payment_configurations;

class ApplePayScreen extends StatefulWidget {
  const ApplePayScreen({super.key});

  @override
  State<ApplePayScreen> createState() => _ApplePayScreenState();
}

class _ApplePayScreenState extends State<ApplePayScreen> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  int? environmentValue = 0;
  int? commandValue = 0;
  List<ParamModel>? paramList = List.empty(growable: true);
  bool? isShowFraudExtraParam;


  Future<void> _showMyDialog(String title, String body) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> applePay() async {
    var result;
    var requestParam = {};
    var transactionDetails = Map<String, dynamic>.from(requestParam);

    transactionDetails =  {
      "command": "PURCHASE",
      "merchant_reference": "ORDER-123456",
      "sdk_token": "Dwp78q9",
      "amount": 10,
      "payment_option": "VISA",
      "eci": "ECOMMERCE",
      "currency": "SA",
      "language": "en",
      "customer_email": "customer@example.com",
      "order_description": "Test Order",
      "customer_name": "John Doe",
      "customer_ip": "192.168.1.1"
    };
    // Remove 'country_code' from the transaction details, since its required only for Apple pay setup.
    transactionDetails.remove('country_code');

    var params = {
      "displayAmount": "10", // Ensure it's a string
      "merchantIdentifier": "merchant.com.",
      'countryCode': "KSA",
      'currencyCode': "SA",
      'supportedNetworks': ['amex', 'visa', 'mastercard'],
      'transactionDetails': transactionDetails
    };

    try {
      result = await FlutterAmazonpaymentservices.applePay(
          params,
          environmentValue == 0
              ? EnvironmentType.sandbox
              : EnvironmentType.production);
    } on PlatformException catch (e) {
      if (e.code == "APPLE_PAY_CANCELLED") {
        _showMyDialog("Apple Pay Cancelled: ", e.details.toString());
      } else if (e.code == "PAYMENT_FAILED") {
        _showMyDialog("Apple Pay Failed: ", e.message.toString());
      } else {
        _showMyDialog("Apple Pay-Failed: ", e.message.toString());
      }
      Clipboard.setData(ClipboardData(text: e.details.toString()));
      return;
    }
    if (!mounted) return;
    _showMyDialog("success", result.toString());
  }

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }
  void onGooglePayResult(Map<String, dynamic> paymentResult) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Result'),
        content: Text(paymentResult.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void onApplePayResult(Map<String, dynamic> paymentResult) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apple Pay Result'),
        content: Text(paymentResult.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-shirt Shop'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Image(
              image: AssetImage('assets_mock/ts_10_11019a.jpg'),
              height: 350,
            ),
          ),
          const Text(
            'Amanda\'s Polo Shirt',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '\$50.20',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'A versatile full-zip that you can wear all day long and even...',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          FutureBuilder<PaymentConfiguration>(
              future: _googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData? GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : const SizedBox.shrink()),
          // Example pay button configured using a string
          ApplePayButton(
            paymentConfiguration: payment_configurations.defaultApplePayConfig,
            paymentItems: _paymentItems,
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onApplePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}


class ParamModel {
  TextEditingController? controller;
  String? key;

  ParamModel({this.key}) {
    controller = TextEditingController();
  }
}



extension HashSha on String {
  // String get toSha256 {
  //   var bytes = utf8.encode(this);
  //   return sha256.convert(bytes).toString();
  // }
}
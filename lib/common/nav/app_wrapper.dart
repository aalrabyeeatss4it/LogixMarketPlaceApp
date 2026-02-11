import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppWrapper extends StatefulWidget {
  final Widget child;
  const AppWrapper({super.key, required this.child});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  DateTime? lastPressed;

  void _handleBack(bool _) {
    final now = DateTime.now();
    final canPop = Get.key.currentState?.canPop() ?? false;

    if (canPop) {
      Get.back();
      return;
    }

    if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      Fluttertoast.showToast(msg: 'Press back'.tr);
      return;
    }
    SystemNavigator.pop(); // exit app
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _handleBack,
      child: widget.child,
    );
  }
}

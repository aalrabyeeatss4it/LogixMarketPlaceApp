import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // exit the app
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _handleBack, // ✅ new PopScope API
      child: widget.child,
    );
  }
}

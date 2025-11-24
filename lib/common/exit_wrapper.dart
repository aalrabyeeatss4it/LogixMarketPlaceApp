import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExitWrapper extends StatefulWidget {
  final Widget child;
  const ExitWrapper({super.key, required this.child});

  @override
  State<ExitWrapper> createState() => _ExitWrapperState();
}

class _ExitWrapperState extends State<ExitWrapper> {
  DateTime? _lastPressed;

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      Fluttertoast.showToast(msg: "Press back again to exit");
      return false;
    }
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}

import 'dart:io';

import 'package:ledger/modules/main/main_controller.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:flutter/material.dart';

/// 双击返回退出
class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    super.key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 2500),
  });

  final Widget child;

  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  final MainController controller;

  @override
  DoubleTapBackExitAppState createState() => DoubleTapBackExitAppState();
}

class DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再按一次返回键退出应用');
      return Future.value(false);
    }
    exit(0);
  }
}

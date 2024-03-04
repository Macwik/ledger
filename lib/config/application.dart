import 'package:ledger/res/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Application {
  Application._();

  static final _instance = Application._();

  factory Application.getInstance() => _instance;

  void init() async {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..contentPadding = const EdgeInsets.all(15)
      ..toastPosition = EasyLoadingToastPosition.center
      ..lineWidth = 2
      ..indicatorSize = 30
      ..userInteractions = false;
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  }
}

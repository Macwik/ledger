import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MyWillPop extends StatelessWidget {
  final Widget child;
  final bool isForbidBack;
  final WillPopCallback? onWillPop;

  const MyWillPop({
    super.key,
    required this.child,
    this.isForbidBack = false,
    this.onWillPop
  });

  @override
  Widget build(BuildContext context) {
    if (isForbidBack) {
      return WillPopScope(
          child: child,
          onWillPop: () async {
            return Future.value(false);
          });
    } else if (GetPlatform.isAndroid || GetPlatform.isFuchsia) {
      return WillPopScope(
          child: child,
          onWillPop: onWillPop ?? () async {
            if (EasyLoading.instance.w != null) {
              return Future.value(false);
            }
            return Future.value(true);
          });
    } else {
      return child;
    }
  }
}

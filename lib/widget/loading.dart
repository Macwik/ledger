import 'dart:async';

import 'package:ledger/res/export.dart';

class Loading {
  static void show() {
    if (!EasyLoading.isShow) {
      EasyLoading.show();
    }
  }

  static void showDuration({status = 'Loading...'}) {
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: status);
      Timer(Duration(seconds: 10), () {
        EasyLoading.dismiss(); // 手动关闭 EasyLoading
      });
    }
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}

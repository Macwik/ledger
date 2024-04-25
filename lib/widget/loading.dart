import 'dart:async';

import 'package:ledger/res/export.dart';

class Loading {
  static void show() {
    if (!EasyLoading.isShow) {
      EasyLoading.show();
    }
  }

  static void showDuration({status = '请稍等~~', second = 3}) {
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: status);
      Timer(Duration(seconds: second), () {
        EasyLoading.dismiss(); // 手动关闭 EasyLoading
      });
    }
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}

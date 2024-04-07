import 'dart:async';

import 'package:ledger/res/export.dart';

class Loading {
  static void show() {
    if (!EasyLoading.isShow) {
      EasyLoading.show();
    }
  }

  static void showDuration({status = '请稍等~~'}) {
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: status);
      Timer(Duration(seconds: 3), () {
        EasyLoading.dismiss(); // 手动关闭 EasyLoading
      });
    }
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}

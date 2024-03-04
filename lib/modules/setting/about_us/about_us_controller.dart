import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/privacy_agreement.dart';
import 'package:ledger/widget/dialog_widget/user_agreement.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'about_us_state.dart';

class AboutUsController extends GetxController {
  final AboutUsState state = AboutUsState();

  void privacyAgreement(BuildContext context){
    Get.generalDialog(
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Container(
            color: Colors.white,
            child: PrivacyAgreement(),
          );
        });
  }

  void userAgreement(BuildContext context) {
    Get.generalDialog(
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Container(
            color: Colors.white,
            child: UserAgreement(),
          );
        });
  }

  Future<void> toVersionInfo(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Get.defaultDialog(title: '关于', middleText: '当前版本：${packageInfo.version}', textConfirm: '确定', onConfirm: ()=>Get.back());
  }
}

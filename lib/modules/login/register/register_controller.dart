import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/dialog_widget/privacy_agreement.dart';
import 'package:ledger/widget/dialog_widget/user_agreement.dart';

import 'register_state.dart';

class RegisterController extends GetxController {
  final RegisterState state = RegisterState();

  /// 判断是否可以获取验证码
  bool checkGetVerify() {
    return (state.phoneController.text.isNotEmpty) &&
        state.countdown.value <= 0;
  }

  bool get verifying => state.countdown.value > 0;

  startCountdown() {
    state.countdown.value = 60; // 设置初始倒计时时间
    state.timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (state.countdown.value > 0) {
        state.countdown.value--;
      } else {
        stopCountdown();
      }
      update(['verifyBtn']);
    });
  }

  stopCountdown() {
    // 停止计时器
    state.timer?.cancel();
  }

  @override
  void dispose() {
    stopCountdown(); // 在控制器被销毁时停止计时器
    super.dispose();
  }

  Future<void> register() async {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    if (!state.privacyAgreement) {
      Toast.show('请先阅读并同意隐私协议');
      return;
    }
    Loading.showDuration();
    final result =
        await Http().network<void>(Method.post, UserApi.register, data: {
      'phone': state.phoneController.text,
      'verifyCode': state.verifyController.text,
      'password': state.password,
      'username': state.nameController.text,
      'gender': 2 //未知
    });
    Loading.dismiss();
    if (result.success) {
      Toast.show('注册成功');
      Get.offAllNamed(RouteConfig.loginVerify);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> getVerifyCode() async {
    final result = await Http().network<void>(Method.post, UserApi.verify_code,
        queryParameters: {'phone': state.phoneController.text});
    if (!result.success) {
      Toast.show(result.m.toString());
    } else {
      startCountdown();
      update(['verifyBtn']);
    }
  }

  void toAgreePrivacyAgreement(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('隐私政策'), // 设置标题为null，
        content: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                '''    本应用尊重并保护所有用户的隐私权。为了给您提供更准确，会更有个性化的服务，本应用会按照隐私政策规定使用和披露您的个人信息可阅读：''',
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      privacyAgreement(context);
                    },
                    child: Text(
                      '《隐私政策》',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Colours.primary),
                    ),
                  )),
                  Text('和'),
                  Expanded(
                      child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      userAgreement(context);
                    },
                    child: Text(
                      '《用户协议》',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Colours.primary),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 16.w,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primary,
                      foregroundColor: Colors.white),
                  child: Text('不同意并退出'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ),
              SizedBox(
                height: 16.w,
              ),
              Container(
                  width: double.infinity,
                  child: TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colours.primary,
                          foregroundColor: Colors.white),
                      child: Text('同意'),
                      onPressed: () {
                        state.privacyAgreement = true;
                        update(['register_privacy_agreement']);
                        Get.back();
                      })),
            ]
                //padding: EdgeInsets.all(10)
                )),
      ),
      barrierDismissible: false,
    );
  }

  void privacyAgreement(BuildContext context) {
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
}

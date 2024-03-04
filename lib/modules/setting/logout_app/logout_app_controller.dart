import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'logout_app_state.dart';

class LogoutAppController extends GetxController {
  final LogoutAppState state = LogoutAppState();
  var countdown = 0.obs;
  Timer? _timer;

  void logoutForever(BuildContext context) {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    Get.dialog(
      AlertDialog(
        title: Text(
          '注销账号',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        content: SingleChildScrollView(
            child: Column(
          children: [
            Text('确认注销当前账号，【记账鲜生】将在7个工作日内处理并删除账号信息'),
            Text('手机号将在7天后释放，再次登录会创建再次注册新账号'),
            SizedBox(
              height: 48.w,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedBtn(
                  size: Size(double.infinity, 110.w),
                  radius: 15.w,
                  backgroundColor: Colors.white,
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )),
                Expanded(
                    child: ElevatedBtn(
                        size: Size(double.infinity, 110.w),
                        radius: 15.w,
                        backgroundColor: Colours.primary,
                        child: Text(
                          '确定',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          String? phone = state
                              .formKey.currentState!.fields['phone']?.value;
                          String? verifyCode = state.formKey.currentState
                              ?.fields['logoutCode']?.value;
                          Loading.showDuration();
                          Http().network(Method.delete, UserApi.logout_forever,
                              queryParameters: {
                                'phone': phone,
                                'verifyCode': verifyCode,
                              }).then((result) async {
                                Loading.dismiss();
                            if (result.success) {
                              Toast.show('注销成功');
                              await logout().then((value) {
                                exit(0);
                              });
                            } else {
                              Toast.show(result.m.toString());
                            }
                          });
                        }))
              ],
            )
          ],
        )),
      ),
      barrierDismissible: false,
    );
  }

  /// 判断是否可以获取验证码
  bool checkGetVerify() {
    return (state.formKey.currentState?.fields['phone']?.validate() ?? false) &&
        countdown.value <= 0;
  }

  bool get verifying => countdown.value > 0;

  stopCountdown() {
    // 停止计时器
    _timer?.cancel();
  }

  Future<void> getLogoutCode() async {
    String? phone = state.formKey.currentState!.fields['phone']?.value;
    final result = await Http().network<void>(Method.post, UserApi.verify_code,
        queryParameters: {'phone': phone});
    if (!result.success) {
      Toast.show(result.m.toString());
    } else {
      startCountdown();
      update(['logoutBtn']);
    }
  }

  startCountdown() {
    countdown.value = 60; // 设置初始倒计时时间
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        stopCountdown();
      }
      update(['logoutBtn']);
    });
  }

  //退出登录
  Future<void> logout() async {
    final result = await Http().network<void>(Method.post, UserApi.logout);
    if (result.success) {
      StoreController.to.signOut();
    }
  }
}

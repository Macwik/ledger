import 'dart:async';

import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/enum/change_password_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'forget_password_state.dart';

class ForgetPasswordController extends GetxController {
  final ForgetPasswordState state = ForgetPasswordState();
  var countdown = 0.obs;
  Timer? _timer;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['type'] != null) {
      state.type = arguments['type'];
    }
    if (state.type == ChangePasswordType.UPDATE.value) {
      var user = StoreController.to.getUser();
      state.phoneController.text = user?.phone ?? '';
      update(['forget_password_phone']);
    }
  }

  /// 判断是否可以获取验证码
  bool checkGetVerify() {
    return (TextUtil.isPhone(state.phoneController.text)) &&
        countdown.value <= 0;
  }

  Future<void> getVerifyCode() async {
    String? phone = state.phoneController.text;
    if (!TextUtil.isPhone(phone)) {
      return;
    }
    final result = await Http().network<void>(Method.post, UserApi.verify_code,
        queryParameters: {'phone': phone});
    if (!result.success) {
      Toast.show(result.m.toString());
    } else {
      startCountdown();
      update(['verifyBtn']);
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
      update(['verifyBtn']);
    });
  }

  stopCountdown() {
    // 停止计时器
    _timer?.cancel();
  }

  bool get verifying => countdown.value > 0;

  void updatePassword() {
    String? phone = state.phoneController.text;
    String? verifyCode = state.verifyCodeController.text;
    String password = state.passwordController.text;
    String? passwordVerify = state.passwordVerifyController.text;
    if (password != passwordVerify) {
      Toast.show('两次密码不一致');
      return;
    }
    Loading.showDuration();
    Http().network<void>(Method.put, UserApi.edit_password, data: {
      'phone': phone,
      'verifyCode': verifyCode,
      'password': password,
      'userType':0
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back();
        Toast.show('修改成功');
      } else {
        Toast.show(result.m.toString());
      }
    });
  }
}

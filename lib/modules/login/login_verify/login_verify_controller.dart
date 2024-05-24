import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/widget/custom_textfield.dart';
import 'package:ledger/widget/dialog_widget/privacy_agreement.dart';
import 'package:ledger/widget/dialog_widget/user_agreement.dart';
import 'dart:async';
import 'login_verify_state.dart';

class LoginVerifyController extends GetxController {
  final LoginVerifyState state = LoginVerifyState();
  static const String GET_VAR_ID_PAGE_TITLE = 'GET_VAR_ID_PAGE_TITLE';
  static const String GET_VAR_ID_LOGIN_TYPE = 'GET_VAR_ID_LOGIN_TYPE';
  static const String GET_VAR_ID_LOGIN_VERIFY_BUTTON =
      'GET_VAR_ID_LOGIN_VERIFY_BUTTON';
  static const String GET_VAR_ID_LOGIN_PRIVATE_AGREEMENT =
      'GET_VAR_ID_LOGIN_PRIVATE_AGREEMENT';

  /// 统一 key
  static const String f_result_key = 'result';

  /// 错误码
  static const String f_code_key = 'code';

  /// 回调的提示信息，统一返回 flutter 为 message
  static const String f_msg_key = 'message';

  /// 运营商信息
  static const String f_opr_key = 'operator';

  var countdown = 0.obs;
  Timer? _timer;

  /// 判断是否可以获取验证码
  bool checkGetVerify() {
    return (state.formKey.currentState?.fields['phone']?.validate() ?? false) &&
        countdown.value <= 0;
  }

  bool get verifying => countdown.value > 0;

  startCountdown() {
    countdown.value = 60; // 设置初始倒计时时间
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        stopCountdown();
      }
      update([GET_VAR_ID_LOGIN_VERIFY_BUTTON]);
    });
  }

  stopCountdown() {
    // 停止计时器
    _timer?.cancel();
  }

  Future<void> getVerifyCode() async {
    String? phone = state.formKey.currentState?.fields['phone']?.value;
    final result = await Http().network<void>(Method.post, UserApi.verify_code,
        queryParameters: {'phone': phone});
    if (!result.success) {
      Toast.show(result.m.toString());
    } else {
      startCountdown();
      update([GET_VAR_ID_LOGIN_VERIFY_BUTTON]);
    }
  }

  void toRegister() {
    Get.toNamed(RouteConfig.register);
  }

  void login() async {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    if (!state.privacyAgreement) {
      Toast.show('请先阅读并同意隐私协议');
      return;
    }
    String? phone = state.formKey.currentState?.fields['phone']?.value;

    String? verifyCode =
        state.formKey.currentState?.fields['verifyCode']?.value;

    String? password = state.formKey.currentState?.fields['password']?.value;

    final result =
        await Http().network<UserDTOEntity>(Method.post, UserApi.login, data: {
      'phone': phone,
      'loginType': state.loginVerifyType.value,
      'verifyCode': verifyCode,
      'password': password,
      'userType': 0
    });
    if (result.success) {
      await StoreController.to.signIn(result.d!);

      var activeLedger = result.d!.activeLedger;
      if (null == activeLedger) {
        Get.toNamed(RouteConfig.addAccount, arguments: {'firstIndex': true});
      } else {
        await StoreController.to
            .updatePermissionCode()
            .then((value) => Get.offAllNamed(RouteConfig.main));
      }
    } else {
      Toast.show(result.m.toString());
    }
  }

  void changeLoginType() {
    if (LoginVerifyType.PASSWORD == state.loginVerifyType) {
      state.loginVerifyType = LoginVerifyType.VERIFY_CODE;
    } else {
      state.loginVerifyType = LoginVerifyType.PASSWORD;
    }
    update([GET_VAR_ID_PAGE_TITLE, GET_VAR_ID_LOGIN_TYPE]);
  }

  Widget buildPasswordVerifyWidget() {
    if (LoginVerifyType.VERIFY_CODE == state.loginVerifyType) {
      return Stack(
        alignment: const Alignment(0.1, -1),
        children: [
          Positioned(
            child: CustomTextField(
              name: 'verifyCode',
              hintText: '请输入验证码',
              border: UnderlineInputBorder(),
              keyboardType: TextInputType.number,
              validator:
                  FormBuilderValidators.required(errorText: '验证码不能为空'.tr),
            ),
          ),
          Positioned(
            right: 20,
            child: GetBuilder<LoginVerifyController>(
              id: GET_VAR_ID_LOGIN_VERIFY_BUTTON,
              builder: (controller) {
                return ElevatedBtn(
                  backgroundColor: (controller.verifying)
                      ? Colours.text_ccc
                      : Colours.primary,
                  radius: 20.w,
                  size: Size(80, 40),
                  onPressed: () => controller.checkGetVerify()
                      ? controller.getVerifyCode()
                      : null,
                  child: Text(
                    controller.verifying
                        ? '${controller.countdown.value}秒后重发'
                        : '验证码',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          )
        ],
      );
    } else {
      return CustomTextField(
        name: 'password',
        hintText: '请输入密码',
        border: UnderlineInputBorder(),
        obscureText: true,
        prefixIcon: Icon(Icons.lock_open_outlined),
        keyboardType: TextInputType.visiblePassword,
        validator: FormBuilderValidators.required(errorText: '密码不能为空'.tr),
      );
    }
  }

  void toAgreePrivacyAgreement(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('隐私政策'),
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
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
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
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
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
                  )),
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
                        update([GET_VAR_ID_LOGIN_PRIVATE_AGREEMENT]);
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

// Future<void> verifyPhone() async {
//   Jverify jVerify = Jverify();
//   var map = await jVerify.checkVerifyEnable();
//   bool result = map[f_result_key];
//   if (result) {
//     await jVerify.loginAuth(true).then((map) {
//       int code = map[f_code_key];
//       String? message = map[f_msg_key];
//       //获取手机号成功
//       if (6000 == code && (message?.isNotEmpty ?? false)) {
//         queryUserStatus(message!);
//       }
//     });
//   }
// }
//
// Future<void> queryUserStatus(String message) async {
//   final result = await Http().network<UserStatusDTO>(
//       Method.get, UserApi.user_status,
//       queryParameters: {'token': message});
//   if (!result.strictSuccess) {
//     Toast.show(result.m.toString());
//   } else {
//     var userStatusDTO = result.d;
//     if (UserStatus.ACTIVE.value == userStatusDTO?.statusCode) {
//       await StoreController.to.signIn(userStatusDTO!.userDTO!);
//       await StoreController.to
//           .updatePermissionCode()
//           .then((value) => Get.offAllNamed(RouteConfig.main));
//     } else if (UserStatus.NO_REGISTER.value == userStatusDTO?.statusCode) {
//       Get.offAndToNamed(RouteConfig.firstIndex,
//           arguments: {'phone': userStatusDTO?.phone});
//     } else if (UserStatus.NO_ACTIVE.value == userStatusDTO?.statusCode) {
//       Get.offAllNamed(RouteConfig.addAccount,
//           arguments: {'firstIndex': true});
//     } else {
//       LoggerUtil.e('未知异常$userStatusDTO');
//     }
//   }
// }
}

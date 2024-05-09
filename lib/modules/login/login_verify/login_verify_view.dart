import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/login/login_verify/login_verify_state.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/custom_textfield.dart';

import 'login_verify_controller.dart';

class LoginVerifyView extends StatelessWidget {
  final controller = Get.find<LoginVerifyController>();
  final state = Get.find<LoginVerifyController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: TitleBar(
        actionWidget:
          GetBuilder<LoginVerifyController>(
              id: LoginVerifyController.GET_VAR_ID_PAGE_TITLE,
              builder: (_) {
                return TextButton(
                  onPressed: () => controller.changeLoginType(),
                  child: Text(
                    state.loginVerifyType == LoginVerifyType.PASSWORD
                        ? '验证码登录'
                        : '密码登录',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              })
      ),
      body: FormBuilder(
        key: state.formKey,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              children: [
                Flexible(
                    child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().statusBarHeight + 120.w,
                    left: 80.w,
                    right: 80.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: LoadAssetImage(
                          'login_login_verify',
                          format: ImageFormat.jpg,
                          width: 380.w,
                          height: 280.w,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                            name: 'phone',
                            hintText: '请输入手机号',
                            border: UnderlineInputBorder(),
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: '手机号码不能为空'),
                              FormBuilderValidators.minLength(11,
                                  errorText: '手机号码长度不正确')
                            ]),
                          ),
                          SizedBox(height: 50.w),
                          GetBuilder<LoginVerifyController>(
                              id: LoginVerifyController.GET_VAR_ID_LOGIN_TYPE,
                              builder: (_) {
                                return controller.buildPasswordVerifyWidget();
                              }),
                        ],
                      ),
                      SizedBox(height: 50.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(RouteConfig.register),
                            child: Text(
                              '新用户注册',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Get.toNamed(RouteConfig.forgetPassword),
                            child: Text(
                              '忘记密码',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedBtn(
                        margin: EdgeInsets.only(top: 80.w),
                        size: Size(double.infinity, 90.w),
                        radius: 15.w,
                        backgroundColor: Colours.primary,
                        onPressed: controller.login,
                        text: '登 录',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 50.w),
                    ],
                  ),
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetBuilder<LoginVerifyController>(
                            id: LoginVerifyController.GET_VAR_ID_LOGIN_PRIVATE_AGREEMENT,
                            builder: (_) {
                              return Checkbox(
                                value: state.privacyAgreement,
                                onChanged: (value) {
                                  state.privacyAgreement =
                                      !state.privacyAgreement;
                                  controller.update([
                                    LoginVerifyController
                                        .GET_VAR_ID_LOGIN_PRIVATE_AGREEMENT
                                  ]);
                                },
                                tristate: false,
                                activeColor: Colours.primary,
                              );
                            }),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          '我已同意',
                          style: TextStyle(color: Colours.text_666),
                        ),
                        TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () =>
                                controller.toAgreePrivacyAgreement(context),
                            child: Text(
                              '《隐私协议》和《用户协议》',
                              style: TextStyle(color: Colours.primary),
                            ))
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}

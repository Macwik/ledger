import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/change_password_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/modules/login/forget_password/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final controller = Get.find<ForgetPasswordController>();
  final state = Get.find<ForgetPasswordController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title:   state.type == 1 ? '修改密码' : '忘记密码'),
        body: Stack(
          children: [
            FormBuilder(
              key: state.formKey,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().statusBarHeight + 120.w,
                    left: 80.w,
                    right: 80.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<ForgetPasswordController>(
                          id: 'forget_password_phone',
                          builder: (_) {
                            return TextFormField(
                              controller: state.phoneController,
                              textAlign: TextAlign.left,
                              maxLength: 24,
                              readOnly: ChangePasswordType.UPDATE.value == state.type,
                              style: TextStyle(fontSize: 30.sp),
                              decoration: InputDecoration(
                                counterText: '',
                                  hintText: '请输入手机号', ),
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              validator: (value) {
                                var text = state.phoneController.text;
                                if (text.isEmpty) {
                                  return '手机号码不能为空';
                                }
                                return null;
                              },
                            );
                          }),
                      SizedBox(height: 30.w),
                      Stack(
                        alignment: const Alignment(0.1, -1),
                        children: [
                          Positioned(
                            child: TextFormField(
                              controller: state.verifyCodeController,
                              textAlign: TextAlign.left,
                              maxLength: 24,
                              style: TextStyle(fontSize: 30.sp),
                              decoration: InputDecoration(
                                counterText: '',
                                  hintText: '请输入验证码', ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: FormBuilderValidators.required(
                                  errorText: '验证码不能为空'.tr),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            child: GetBuilder<ForgetPasswordController>(
                              id: 'verifyBtn',
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
                      ),
                      TextFormField(
                        controller: state.passwordController,
                        textAlign: TextAlign.left,
                        maxLength: 24,
                        obscureText: true,
                        style: TextStyle(fontSize: 30.sp),
                        decoration: InputDecoration(
                          counterText: '',
                            hintText: '请输入新密码', ),
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        validator: FormBuilderValidators.required(
                            errorText: '新密码不能为空'.tr),
                      ),
                      SizedBox(height: 30.w),
                      TextFormField(
                        controller: state.passwordVerifyController,
                        textAlign: TextAlign.left,
                        maxLength: 24,
                        obscureText: true,
                        style: TextStyle(fontSize: 30.sp),
                        decoration: InputDecoration(
                          counterText: '',
                            hintText: '请再次输入密码', ),
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        validator: (value) {
                          if (state.passwordController.text == value) {
                            return null;
                          }
                          return '两次输入密码不一致，请重试';
                        },
                      ),
                      SizedBox(height: 30.w),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetBuilder<ForgetPasswordController>(
                  id: 'forget_password_btn',
                  builder: (_) {
                    return ElevatedBtn(
                      margin: EdgeInsets.only(top: 80.w),
                      size: Size(double.infinity, 90.w),
                      radius: 15.w,
                      onPressed: () {
                        (state.formKey.currentState?.saveAndValidate() ?? false)
                            ? controller.updatePassword()
                            : null;
                      },
                      backgroundColor: Colours.primary,
                      text: '确认',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}

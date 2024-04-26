import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'register_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title:
            '注册'.tr,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                FormBuilder(
                  key: controller.state.formKey,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().statusBarHeight + 120.w,
                        left: 80.w,
                        right: 80.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.state.nameController,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '请填写昵称',
                            ),
                            style: TextStyle(
                                fontSize: 32.sp
                            ),
                            keyboardType: TextInputType.name,
                            validator: FormBuilderValidators.required(
                                errorText: '昵称不能为空'.tr),
                          ),
                          SizedBox(height: 30.w),
                          TextFormField(
                            controller: controller.state.phoneController,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '请填写手机号',
                            ),
                            style: TextStyle(
                                fontSize: 32.sp
                            ),
                            keyboardType: TextInputType.phone,
                            validator: FormBuilderValidators.required(
                                errorText: '手机号码不能为空'.tr),
                          ),
                          SizedBox(height: 30.w),
                          Stack(
                            alignment: const Alignment(0.1, -1),
                            children: [
                              Positioned(
                                child: TextFormField(
                                  controller: controller.state.verifyController,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: '请填写验证码',
                                  ),
                                  style: TextStyle(
                                      fontSize: 32.sp
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.required(
                                      errorText: '验证码不能为空'.tr),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                child: GetBuilder<RegisterController>(
                                  id: 'verifyBtn',
                                  init: controller,
                                  global: false,
                                  builder: (controller) {
                                    return ElevatedBtn(
                                      backgroundColor: (controller.verifying)
                                          ? Colours.text_ccc
                                          : Colours.primary,
                                      radius: 20.w,
                                      size: Size(80, 40),
                                      onPressed: () =>
                                          controller.checkGetVerify()
                                              ? controller.getVerifyCode()
                                              : null,
                                      child: Text(
                                        controller.verifying
                                            ? '${controller.state.countdown.value}秒后重发'
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
                            controller: controller.state.passwordController,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '请设置密码',
                            ),
                            style: TextStyle(
                                fontSize: 32.sp
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              controller.state.password = value;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            validator: FormBuilderValidators.required(
                                errorText: '密码不能为空'.tr),
                          ),
                          SizedBox(height: 30.w),
                          TextFormField(
                            controller: controller.state.passwordVerifyController,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '请再次输入密码',
                            ),
                            style: TextStyle(
                                fontSize: 32.sp
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (controller.state.password == value) {
                                return null;
                              }
                              return '两次输入密码不一致';
                            },
                          ),
                          SizedBox(height: 30.w),
                          GetBuilder<RegisterController>(
                              id: 'register_privacy_agreement',
                              init: controller,
                              global: false,
                              builder: (_) {
                                return FormBuilderField<bool>(
                                  name: 'register_form_builder_field',
                                  builder: (FormFieldState field) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorText: field.errorText,
                                      ),
                                      child: CheckboxListTile(
                                        title: Text.rich(
                                            TextSpan(text: '我已同意',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                ),
                                                children: [
                                          WidgetSpan(
                                            child: InkWell(
                                              onTap: () {
                                                controller
                                                    .toAgreePrivacyAgreement(
                                                        context);
                                              },
                                              child: Text(
                                                '《隐私政策》和《用户协议》',
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                  color: Colours.primary,
                                                    decoration: TextDecoration.underline,
                                                    fontStyle: FontStyle.italic,
                                                    decorationStyle: TextDecorationStyle.solid,
                                                    decorationColor: Colours.primary),
                                              ),
                                            ),
                                          ),
                                        ])),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value:
                                            controller.state.privacyAgreement,
                                        onChanged: (value) {
                                          controller.state.privacyAgreement = !controller
                                                      .state.privacyAgreement;
                                          controller.update(
                                              ['register_privacy_agreement']);
                                        },
                                      ),
                                    );
                                  },
                                  validator: (value) {
                                    if (!controller.state.privacyAgreement) {
                                      return '请先阅读并同意《隐私协议》';
                                    }
                                    return null;
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder<RegisterController>(
                  id: 'registerBtn',
                  init: controller,
                  global: false,
                  builder: (_) {
                    return ElevatedBtn(
                      margin: EdgeInsets.only(top: 80.w),
                      size: Size(double.infinity, 100.w),
                      radius: 15.w,
                      backgroundColor: Colours.primary,
                      text: '注  册',
                      onPressed: () {
                        controller.register();
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}

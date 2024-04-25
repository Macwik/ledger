import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/custom_textfield.dart';

import 'logout_app_controller.dart';

class LogoutAppView extends StatelessWidget {
  LogoutAppView({super.key});

  final controller = Get.find<LogoutAppController>();
  final state = Get.find<LogoutAppController>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
          appBar: TitleBar(
            title: '确认注销重要提示',
          ),
          body:FormBuilder(
              key: state.formKey,
              child:Column(
            children: [
              SizedBox(height: 64.w,),
          Container(
              padding: EdgeInsets.all(24.w),
              child: Text('''注销账号前，请您确认以下的风险：''',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 56.sp
                ),
              )),
              SizedBox(height: 24.w,),
              Container(
                padding: EdgeInsets.all(24.w),
                child: Text('''1.所有账本数据将会被清除，并且无法恢复或查询，如果有重要数据请您在注销前导出''',
                  style: TextStyle(
                      color: Colours.text_333,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
          Container(
              padding: EdgeInsets.all(24.w),
              child: Text(
                '''2.账号信息将被清除，如果您属于其他账号的账本员工，注销后将会自动退出其账本''',
                style: TextStyle(
                    color: Colours.text_333,
                    fontWeight: FontWeight.w500
                ),
              )),
          Container(
              padding: EdgeInsets.all(32.w),
              child: CustomTextField(
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
              )),
              Container(
                  padding: EdgeInsets.all(32.w),
                  child:
              Stack(
                alignment: const Alignment(0.1, -1),
                children: [
                  Positioned(
                    child: CustomTextField(
                      name: 'logoutCode',
                      hintText: '请输入验证码',
                      border: UnderlineInputBorder(),
                      keyboardType: TextInputType.number,
                      validator:
                      FormBuilderValidators.required(errorText: '验证码不能为空'.tr),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: GetBuilder<LogoutAppController>(
                      id: 'logoutBtn',
                      builder: (controller) {
                        return ElevatedBtn(
                          backgroundColor: (controller.verifying)
                              ? Colours.text_ccc
                              : Colours.primary,
                          radius: 20.w,
                          size: Size(80, 40),
                          onPressed: () => controller.checkGetVerify()
                              ? controller.getLogoutCode()
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
              )),
              const Spacer(),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: ElevatedBtn(
                      size: Size(double.infinity, 110.w),
                      onPressed: ()=> Get.back(),
                      radius: 15.w,
                      backgroundColor: Colors.white,
                      text: '放弃注销',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedBtn(
                      size: Size(double.infinity, 110.w),
                      onPressed: () => controller.logoutForever(context),
                      radius: 15.w,
                      backgroundColor: Colours.primary,
                      text: '确定注销',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.w,)
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/will_pop.dart';
import 'login_index_controller.dart';

class LoginIndexView extends StatelessWidget {

  final controller = Get.find<LoginIndexController>();
  final state = Get.find<LoginIndexController>().state;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MyWillPop(
          isForbidBack: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: FormBuilder(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().statusBarHeight + 150.w,
                    left: 80.w,
                    right: 80.w,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          //borderRadius: BorderRadius.circular(40.w),
                          child: LoadAssetImage(
                            'logo_login_index',
                            format: ImageFormat.jpg,
                            width: 380.w,
                            height: 280.w,
                          ),
                        ),
                        SizedBox(height: 150.w),
                        ElevatedBtn(
                          size: Size(double.infinity, 90.w),
                          radius: 15.w,
                          backgroundColor: (Colors.orange[200]),
                          text: '手机号登录',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 40.w),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: controller.toLoginVerify,
                              child: Text(
                                '密码登录',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 100.h),
                            InkWell(
                              onTap: controller.toLoginVerify,
                              child: Text(
                                '验证码登录',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}

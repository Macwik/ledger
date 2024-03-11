import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';

import 'account_setting_controller.dart';

class AccountSettingView extends StatelessWidget {
  AccountSettingView({super.key});

  final controller = Get.find<AccountSettingController>();
  final state = Get.find<AccountSettingController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '记账设置',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              //color: Colours.divider,
              height: 20.w,
              width: double.infinity,
            ),
            InkWell(
              onTap: () => Get.toNamed(RouteConfig.paymentManage,
                  arguments: {'isSelect': IsSelectType.FALSE}),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    LoadSvg(
                      'svg/ic_mine_privacy',
                      width: 40.w,
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Text(
                      '支付方式设置',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25.w,
                      color: Colours.text_ccc,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

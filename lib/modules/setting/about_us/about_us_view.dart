import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/image.dart';

import 'about_us_controller.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});

  final controller = Get.find<AboutUsController>();
  final state = Get.find<AboutUsController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们',style: TextStyle(color: Colors.white),),
        leading: BackButton(color: Colors.white,),),
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
              onTap: (){
                controller.privacyAgreement(context);
              },
              child: Container(
                color: Colors.white,
                height: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    LoadSvg(
                      'svg/ic_mine_privacy',
                      width: 40.w,
                    ),
                    SizedBox(width: 24.w,),
                    Text(
                      '隐私协议',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 30.sp,
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
            ),
            Container(
              color: Colours.divider,
              height: 1.w,
              width: double.infinity,
            ),
            InkWell(
              onTap: (){
                controller.userAgreement(context);
              },
              child: Container(
                color: Colors.white,
                height: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    LoadSvg(
                      'svg/ic_mine_userAgreement',
                      width: 40.w,
                    ),
                    SizedBox(width: 24.w,),
                    Text(
                      '用户协议',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 30.sp,
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
            ),
            InkWell(
              onTap: (){
                controller.toVersionInfo(context);
              },
              child: Container(
                color: Colors.white,
                height: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    LoadSvg(
                      'svg/ic_mine_checkUpDate',
                      width: 40.w,
                    ),
                    SizedBox(width: 24.w,),
                    Text(
                      '当前版本',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 30.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}


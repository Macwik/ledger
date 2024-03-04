import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';

import 'account_controller.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});

  final controller = Get.find<AccountController>();
  final state = Get.find<AccountController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('账目',style: TextStyle(color: Colors.white),),
        leading: BackButton(color: Colors.white,),),
      body: Column(
          children: [

            Visibility(
                maintainSize: false,
                visible: false,
                child: InkWell(
                  onTap: ()=> Get.toNamed(RouteConfig.businessCondition),
                  child:   Container(
                    height: 180.w,
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 10.0,left: 20,right: 20),
                    margin: EdgeInsets.only(bottom: 1),
                    child: ListView(
                      children: [
                        ListTile(
                          leading: LoadSvg(
                            'svg/ic_account_business_condition',
                            width: 100.w,
                          ),
                          title: Text('经营状况',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            ),),
                          subtitle: Text('记录近期经营概况',
                            style: TextStyle(
                              color: Colours.text_ccc,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    ),
                  ),
                ) ),
          InkWell(
            onTap: ()=> Get.toNamed(RouteConfig.dailyAccount,arguments: {'initialIndex':0}),
            child:  Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0,left: 20,right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_account_day_to_day',
                      width: 100.w,
                    ),
                    title: Text('每日流水',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    subtitle: Text('记录每天资金流水情况，便于结账查看核对资金',
                      style: TextStyle(
                         color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            ),
          )

          ]

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'funds_controller.dart';

class FundsView extends StatelessWidget {
  FundsView({super.key});

  final controller = Get.find<FundsController>();
  final state = Get.find<FundsController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '资金',
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.white12,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(80.w, 10.0.w, 0.0, 10.0.w),
            child: Text(
              '收入和费用',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.costBill, arguments: {'costOrderType': CostOrderType.COST}),
            child:  PermissionWidget(
                permissionCode: PermissionCode.funds_cost_order_permission,
                child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
              margin: EdgeInsets.only(bottom: 2.w),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_funds_cost',
                      width: 100.w,
                    ),
                    title: Text(
                      '费用开单',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '除采购及采购费用外的其他开支',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            )),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.costBill,
                arguments: {'costOrderType': CostOrderType.INCOME}),
            child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
              margin: EdgeInsets.only(bottom: 2.w),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_funds_income',
                      width: 100.w,
                    ),
                    title: Text(
                      '收入开单',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '销售货物以外的其他收入',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.costRecord),
            child: PermissionWidget(
              permissionCode: PermissionCode.funds_cost_record_permission,
              child: Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
              margin: EdgeInsets.only(bottom: 2.w),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_funds_record',
                      width: 100.w,
                    ),
                    title: Text(
                      '费用收入记录',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '除采购及采购费用外其他开支的记录',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            )),
          ),
          Container(
            color: Colors.white12,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(80.w,10.w, 0.0, 10.w),
            child: Text(
              '欠款和还款',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
              onTap: () => Get.toNamed(RouteConfig.addDebt),
              child: PermissionWidget(
                  permissionCode: PermissionCode.funds_add_debt_permission,
                  child: Container(
                height: 180.w,
                color: Colors.white,
                padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
                margin: EdgeInsets.only(bottom: 2.w),
                child: ListView(
                  children: [
                    ListTile(
                      leading: LoadSvg(
                        'svg/ic_funds_debt',
                        width: 100.w,
                      ),
                      title: Text(
                        '录入欠款',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '记录销售以外的其他欠款',
                        style: TextStyle(
                          color: Colours.text_ccc,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colours.text_ccc,),
                    ),
                  ],
                ),
              ))),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.repaymentBill,arguments: {'customType':CustomType.CUSTOM.value}),
            child:  PermissionWidget(
              permissionCode: PermissionCode.supplier_detail_repayment_order_permission,
              child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
              margin: EdgeInsets.only(bottom: 2.w),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_funds_repayment',
                      width: 100.w,
                    ),
                    title: Text(
                      '录入还款',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '记录还款情况',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            )),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.repaymentRecord,
                arguments: {'index': 0}),
            child:  PermissionWidget(
              permissionCode: PermissionCode.funds_repayment_record_permission,
              child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0.w, left: 40.w, right: 40.w),
              margin: EdgeInsets.only(bottom: 2.w),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_sale_repayment',
                      width: 100.w,
                    ),
                    title: Text(
                      '还款记录',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '客户还款情况记录',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colours.text_ccc,),
                  ),
                ],
              ),
            )),
          )
        ]),
      ),
    );
  }
}

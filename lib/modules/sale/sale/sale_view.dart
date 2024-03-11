import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'sale_controller.dart';

class SaleView extends StatelessWidget {
  SaleView({super.key});

  final controller = Get.find<SaleController>();
  final state = Get.find<SaleController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '销售',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
            color: Colors.white,)
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.white12,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(40, 5.0, 0.0, 5.0),
            child: Text(
              '销售',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
            onTap: () {
              controller.toSaleBill();
            },
            child: PermissionWidget(
              permissionCode: PermissionCode.sales_sale_order_permission,
              child: Container(
                height: 180.w,
                color: Colors.white,
                padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                margin: EdgeInsets.only(bottom: 1),
                child: ListView(
                  children: [
                    ListTile(
                      leading: LoadSvg(
                        'svg/ic_sale_bill',
                        width: 100.w,
                      ),
                      title: Text(
                        '销售开单',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '销售货物时，记录销售物品及金额变化',
                        style: TextStyle(
                          color: Colours.text_ccc,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.toSaleReturnBill(),
            child: PermissionWidget(
                permissionCode: PermissionCode.sales_sale_return_permission,
                child: Container(
                  height: 180.w,
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  margin: EdgeInsets.only(bottom: 1),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: LoadSvg(
                          'svg/ic_sale_back',
                          width: 100.w,
                        ),
                        title: Text(
                          '退货开单',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '客户退货时，记录销售物品及金额变化',
                          style: TextStyle(
                            color: Colours.text_ccc,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                )),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.saleRecord,
                arguments: {'orderType': OrderType.SALE}),
            child: PermissionWidget(
                permissionCode: PermissionCode.sales_sale_record_permission,
                child: Container(
                  height: 180.w,
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  margin: EdgeInsets.only(bottom: 1),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: LoadSvg(
                          'svg/ic_sale_record',
                          width: 100.w,
                        ),
                        title: Text(
                          '销售记录',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '查看过往销售记录',
                          style: TextStyle(
                            color: Colours.text_ccc,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            color: Colors.white12,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(40, 5.0, 0.0, 5.0),
            child: Text(
              '客户',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.customRecord,
                arguments: {'initialIndex': 0, 'isSelectCustom': false}),
            child: Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_sale_customer',
                      width: 100.w,
                    ),
                    title: Text(
                      '客户列表',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '客户信息及销售记录、欠款记录',
                      style: TextStyle(
                        color: Colours.text_ccc,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

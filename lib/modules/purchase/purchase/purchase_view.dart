import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'purchase_controller.dart';

class PurchaseView extends StatelessWidget {
  PurchaseView({super.key});

  final controller = Get.find<PurchaseController>();
  final state = Get.find<PurchaseController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('采购',style: TextStyle(color: Colors.white),),
        leading: BackButton(color: Colors.white,
          ),),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.white12,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(40, 5.0, 0.0, 5.0),
            child: Text(
              '采购',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
            onTap: () {
              controller.toPurchaseBill();
            },
            child: PermissionWidget(
                permissionCode: PermissionCode.purchase_purchase_order_permission,
                child:Container(
               height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_purchase_bill1',
                      width: 100.w,
                    ),
                    title: Text('采购开单',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    subtitle: Text('采购货物时，记录采购货物的数量及资金',
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
            )),
          ),
          InkWell(
            onTap: () => controller.toSaleReturnBill(),
            child:  PermissionWidget(
              permissionCode: PermissionCode.purchase_purchase_return_permission,
              child:Container(
               height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_purchase_bill',
                      width: 100.w,
                    ),
                    title: Text('采购退单',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    subtitle: Text('采购退货时，记录采购退货的数量及资金',
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
            )),
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.saleRecord,arguments: {'orderType': OrderType.PURCHASE}),
            child: PermissionWidget(
              permissionCode: PermissionCode.purchase_purchase_record_permission,
              child:Container(
               height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_purchase_record',
                      width: 100.w,
                    ),
                    title: Text('采购记录',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    subtitle: Text('查看往期采购记录',
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
            )),
          ),
          Container(
            color: Colors.white12,
           
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(40, 10, 0.0, 5.0),
            child: Text(
              '汇款',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
              onTap: () => Get.toNamed(RouteConfig.remittance),
              child: PermissionWidget(
                  permissionCode: PermissionCode.purchase_remittance_order_permission,
                  child:Container(
                 height: 180.w,
                color: Colors.white,
                padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                margin: EdgeInsets.only(bottom: 1),
                child: ListView(
                  children: [
                    ListTile(
                      leading: LoadSvg(
                        'svg/ic_purchase_remittance',
                        width: 100.w,
                      ),
                      title: Text('汇款开单',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                        ),),
                      subtitle: Text('汇款时，记录汇款资金及账户',
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
              ))),
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.remittanceRecord),
            child: PermissionWidget(
                permissionCode: PermissionCode.remittance_remittance_record_permission,
                child:Container(
               height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_purchase_remittance_record',
                      width: 100.w,
                    ),
                    title: Text('汇款记录',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                    subtitle: Text('查看往期汇款记录',
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
            )),
          ),
          Container(
            color: Colors.white12,
           
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(40, 10, 0.0, 5.0),
            child: Text(
              '供应商',
              style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
            ),
          ),
          InkWell(
              onTap: () => Get.toNamed(RouteConfig.customRecord,
                  arguments: {'initialIndex': 1,'isSelectCustom': false}),
              child: Container(
                 height: 180.w,
                color: Colors.white,
                padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                margin: EdgeInsets.only(bottom: 1),
                child: ListView(
                  children: [
                    ListTile(
                      leading: LoadSvg(
                        'svg/ic_purchase_supplier',
                        width: 100.w,
                      ),
                      title: Text('供应商',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                        ),),
                      subtitle: Text('供货商信息查看、修改和新增',
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
              ))
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'stock_controller.dart';

class StockView extends StatelessWidget {
  StockView({super.key});

  final controller = Get.find<StockController>();
  final state = Get.find<StockController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '库存',
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          InkWell(
            onTap: () => Get.toNamed(RouteConfig.stockList,
                arguments: {'select': StockListType.DETAIL}),
            child: Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_stock_list',
                      width: 100.w,
                    ),
                    title: Text(
                      '库存列表',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '对库存货物数量变化的记录',
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
            onTap: () => Get.toNamed(RouteConfig.saleBill,
                arguments: {'orderType':OrderType.ADD_STOCK,}),
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
                          'svg/stock_add_stocks',
                          width: 100.w,
                        ),
                        title: Text(
                          '直接入库',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '非采购情况下，货物直接添加库存',
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
            onTap: () => Get.toNamed(RouteConfig.stockChangeBill),
            child: PermissionWidget(
                permissionCode: PermissionCode.stock_stock_change_permission,
                child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_stock_change',
                      width: 100.w,
                    ),
                    title: Text(
                      '库存调整',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '货物损耗发生时，记录库存变化',
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
            onTap: () => Get.toNamed(RouteConfig.stockChangeRecord),
            child: PermissionWidget(
    permissionCode: PermissionCode.stock_stock_change_record_permission,
    child:Container(
              height: 180.w,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 1),
              child: ListView(
                children: [
                  ListTile(
                    leading: LoadSvg(
                      'svg/ic_stock_change_record',
                      width: 100.w,
                    ),
                    title: Text(
                      '库存调整记录',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '货物损耗发生时，记录库存变化的记录',
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
          ))
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_state.dart';
import 'package:ledger/res/colors.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '库存',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
            color: Colors.white,
           ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';

import 'more_controller.dart';

class MoreView extends StatelessWidget {
  MoreView({super.key});

  final controller = Get.find<MoreController>();
  final state = Get.find<MoreController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '更多',
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
              height:520.w,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('销售',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(5, (index) {
                          return  InkWell(
                            onTap: ()=> controller.toSale(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemSalePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemSaleNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ],),
              )),
          Container(
              height:340.w,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('采购',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(4, (index) {
                          return  InkWell(
                            onTap: ()=> controller.toPurchase(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemPurchasePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemPurchaseNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ],),
              )),
          Container(
              height:520.w,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('销售',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(5, (index) {
                          return  InkWell(
                            onTap: ()=> controller.toSale(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemSalePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemSaleNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ],),
              )),
          Container(
              height:520.w,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('销售',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(5, (index) {
                          return  InkWell(
                            onTap: ()=> controller.toSale(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemSalePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemSaleNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ],),
              )),
          Container(
              height:520.w,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('销售',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(5, (index) {
                          return  InkWell(
                            onTap: ()=> controller.toSale(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemSalePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemSaleNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ],),
              ))
        ],
      ),),
    );
  }
}

const List<String> gridItemSaleNames = ['销售开单', '销售退货', '仅退款', '销售记录', '客户'];

const List<String> gridItemSalePaths = [
  'svg/ic_sale_bill',
  'svg/ic_sale_back',
  'svg/ic_sale_refund',
  'svg/ic_sale_record',
  'svg/ic_sale_customer'
];

const List<String> gridItemSalePermission = [
  PermissionCode.sales_sale_order_permission,
  PermissionCode.sales_sale_return_permission,
  PermissionCode.sales_sale_return_permission,
  PermissionCode.sales_sale_record_permission,
];

const List<String> gridItemPurchaseNames = ['采购开单', '采购退货', '采购记录', '供应商'];

const List<String> gridItemPurchasePaths = [
  'svg/ic_purchase_bill1',
  'svg/ic_purchase_bill',
  'svg/ic_purchase_record',
  'svg/ic_purchase_supplier',
];

const List<String> gridItemPurchasePermission = [
  PermissionCode.purchase_purchase_order_permission,
  PermissionCode.purchase_purchase_return_permission,
  PermissionCode.purchase_purchase_record_permission,
];

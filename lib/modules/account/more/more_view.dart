import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

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
              height:570.w,
              child: Card(
                elevation: 6,
                shadowColor: Colors.black45,
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
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                        physics: NeverScrollableScrollPhysics(),
                       // maxCrossAxisExtent: 80,
                       // mainAxisSpacing: 24.w,
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(5, (index) {
                          return PermissionWidget(
                              permissionCode: gridItemSalePermission[index],
                              child:  InkWell(
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
                          ));
                        }),
                      )),
                ],),
              )),
          Container(
              height:340.w,
              child: Card(
                elevation: 6,
                shadowColor: Colors.black45,
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
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(4, (index) {
                          return PermissionWidget(
                              permissionCode: gridItemPurchasePermission[index],
                              child:  InkWell(
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
                          ));
                        }),
                      )),
                ],),
              )),
          Container(
              height:340.w,
              child: Card(
                elevation: 6,
                shadowColor: Colors.black45,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('库存',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(4, (index) {
                          return  PermissionWidget(
                              permissionCode: gridItemStorePermission[index],
                              child: InkWell(
                            onTap: ()=> controller.toStore(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemStorePaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemStoreNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                        }),
                      )),
                ],),
              )),
          Container(
              height:570.w,
              child: Card(
                elevation: 6,
                shadowColor: Colors.black45,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('资金',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(7, (index) {
                          return PermissionWidget(
                              permissionCode: gridItemFundPermission[index],
                              child: InkWell(
                            onTap: ()=> controller.toFund(index),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemFundPaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemFundNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ) ,
                                ),
                              ],
                            ),
                          ));
                        }),
                      )),
                ],),
              )),
          Container(
              height:340.w,
              child: Card(
                elevation: 6,
                shadowColor: Colors.black45,
                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.w,left: 40.w,bottom: 16.w),
                    alignment: Alignment.centerLeft,
                    child: Text('账目',
                      style: TextStyle(
                          color: Colours.text_333,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp
                      ),),
                  ),
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        children: List.generate(1, (index) {
                          return  PermissionWidget(
                              permissionCode: gridItemAccountPermission[index],
                              child:InkWell(
                            onTap: ()=> Get.toNamed(RouteConfig.dailyAccount),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: LoadSvg(
                                      gridItemAccountPaths[index],
                                      width: 88.w,
                                      height: 88.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    gridItemAccountNames[index],
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colours.text_999,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
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
  PermissionCode.sales_sale_refund_permission,
  PermissionCode.sales_sale_record_permission,
  PermissionCode.common_permission,  //客户目前默认所有岗位都可见
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
  PermissionCode.purchase_purchase_return_order_permission,
  PermissionCode.purchase_purchase_record_permission,
  PermissionCode.purchase_purchase_order_permission,// 供应商没有单独控制,同步采购开单
];

const List<String> gridItemStoreNames = ['库存列表', '直接入库', '库存调整', '调整记录'];

const List<String> gridItemStorePaths = [
  'svg/ic_stock_list',
  'svg/stock_add_stocks',
  'svg/ic_stock_change',
  'svg/ic_stock_change_record',
];

const List<String> gridItemStorePermission = [
  PermissionCode.stock_page_permission,
  PermissionCode.purchase_add_stock_order_permission,
  PermissionCode.stock_stock_change_permission,
  PermissionCode.stock_stock_change_record_permission,
];

const List<String> gridItemFundNames = ['费用开单', '收入开单', '费/收记录', '录入欠款','还款记录','汇款开单','汇款记录'];

const List<String> gridItemFundPaths = [
  'svg/ic_funds_cost',
  'svg/ic_funds_income',
  'svg/ic_funds_record',
  'svg/ic_funds_debt',
  'svg/ic_funds_repayment',
  'svg/ic_purchase_remittance',
  'svg/ic_purchase_remittance_record'
];

const List<String> gridItemFundPermission = [
  PermissionCode.funds_cost_order_permission,
  PermissionCode.funds_cost_order_permission,
  PermissionCode.funds_cost_record_permission,
  PermissionCode.funds_add_debt_permission,
  PermissionCode.repayment_page_permission,
  PermissionCode.purchase_remittance_order_permission,
  PermissionCode.remittance_remittance_record_permission
];

const List<String> gridItemAccountNames = ['每日流水', ];

const List<String> gridItemAccountPaths = [
  'svg/ic_account_day_to_day',
];

const List<String> gridItemAccountPermission = [
  PermissionCode.account_page_permission,
];

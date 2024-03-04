import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';

import 'daily_account_controller.dart';

class DailyAccountView extends StatelessWidget {
  DailyAccountView({super.key});

  final controller = Get.put(DailyAccountController());

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return DefaultTabController(
      length: 3,
      initialIndex: controller.state.initialIndex,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              '每日流水',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colours.primary,
            leading: BackButton(
              color: Colors.white,
            ),
            //title: Text('Tab栏切换示例'),
            bottom: TabBar(
              onTap: (index) => controller.switchDailyAccountIndex(index),
              indicatorColor: Colors.orange,
              tabs: [
                Tab(
                    child: Text(
                  '交易资金',
                  style: TextStyle(color: Colors.white, fontSize: 28.w),
                )),
                // Tab(
                //     child: Text(
                //   '采购资金',
                //   style: TextStyle(color: Colors.white, fontSize: 28.w),
                // )),
                Tab(
                    child: Text(
                  '销售货物',
                  style: TextStyle(color: Colors.white, fontSize: 28.w),
                )),
                Tab(
                    child: Text(
                  '赊账情况',
                  style: TextStyle(color: Colors.white, fontSize: 28.w),
                )),
              ],
            )),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
            children: [
              ///交易资金
              Column(
                children: [
                  Container(
                      color: Colors.white,
                      height: 80.w,
                      padding: EdgeInsets.only(left: 30.w, right: 20.w),
                      margin: EdgeInsets.only(bottom: 10.w),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => controller.pickerSaleMoneyDate(context),
                        child: GetBuilder<DailyAccountController>(
                            id: 'daily_sales_money_date',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '选择日期：',
                                    style: TextStyle(
                                      color: Colours.text_ccc,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateUtil.formatDefaultDate(
                                        controller.state.dateSaleMoney),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colours.text_999,
                                  )
                                ],
                              );
                            }),
                      )),
                  GetBuilder<DailyAccountController>(
                      id: 'daily_sales_money_statistics',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Expanded(
                          child: controller.state.salesMoneyStatisticDTO?.paymentList
                                      ?.isEmpty ??
                                  true
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    var moneyPayment = controller.state
                                        .salesMoneyStatisticDTO
                                        ?.paymentList![index];
                                    return Container(
                                      padding: EdgeInsets.all(24.w),
                                      width: double.maxFinite,
                                      alignment: Alignment.centerLeft,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.w),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 8.w),
                                                  child: LoadAssetImage(
                                                    moneyPayment
                                                            ?.paymentMethodIcon ??
                                                        'payment_common',
                                                    format: ImageFormat.png,
                                                    height: 50.w,
                                                    width: 50.w,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.w,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  moneyPayment
                                                          ?.paymentMethodName ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 32.sp,
                                                      color: Colours.text_333),
                                                )),
                                                Expanded(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '合计： ',
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color:Colours.text_ccc),
                                                    ),
                                                    Expanded(child:
                                                    Text(
                                                      controller.calculate(
                                                          moneyPayment),
                                                      style: TextStyle(
                                                          fontSize: 34.sp,
                                                          color: Colors.orange),
                                                    ))
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20.w,
                                                right: 20.w,
                                                top: 10.w),
                                            alignment: Alignment.centerLeft,
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Visibility(
                                                    visible: moneyPayment
                                                            ?.salesAmount !=
                                                        Decimal.zero,
                                                    child: Expanded(
                                                        child: Row(
                                                      children: [
                                                        Text(
                                                          '销售：',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_999),
                                                        ),
                                                        Expanded(child:
                                                        Text(
                                                          DecimalUtil.formatAmount(
                                                              moneyPayment
                                                                  ?.salesAmount),
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colours
                                                                  .text_666),
                                                        ))
                                                      ],
                                                    ))),
                                                Visibility(
                                                    visible: moneyPayment
                                                            ?.incomeAmount !=
                                                        Decimal.zero,
                                                    child: Expanded(
                                                        child: Row(
                                                      children: [
                                                        Text(
                                                          '收入：',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_999),
                                                        ),
                                                        Expanded(child:
                                                        Text(
                                                          DecimalUtil.formatAmount(
                                                              moneyPayment
                                                                  ?.incomeAmount),
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colours
                                                                  .text_666),
                                                        ))
                                                      ],
                                                    )))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.w),
                                            alignment: Alignment.centerLeft,
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Visibility(
                                                    visible: moneyPayment
                                                            ?.costAmount !=
                                                        Decimal.zero,
                                                    child: Expanded(
                                                        child: Row(
                                                      children: [
                                                        Text(
                                                          '销售地费用：',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_999),
                                                        ),
                                                        Expanded(child:
                                                        Text(
                                                          DecimalUtil.formatAmount(
                                                              moneyPayment
                                                                  ?.costAmount),
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colours
                                                                  .text_666),
                                                        ))
                                                      ],
                                                    ))),
                                                Visibility(
                                                    visible: moneyPayment
                                                            ?.repaymentAmount !=
                                                        Decimal.zero,
                                                    child: Expanded(
                                                        child: Row(
                                                      children: [
                                                        Text(
                                                          '还款：',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_999),
                                                        ),
                                                        Expanded(child:
                                                        Text(
                                                          DecimalUtil.formatAmount(
                                                              moneyPayment
                                                                  ?.repaymentAmount),
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colours
                                                                  .text_666),
                                                        ))
                                                      ],
                                                    )))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  //separatorBuilder是分隔符组件，可以直接拿来用
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    height: 2.w,
                                    color: Colours.divider,
                                    width: double.infinity,
                                  ),
                                  itemCount: controller.state.salesMoneyStatisticDTO
                                          ?.paymentList?.length ??
                                      0,
                                ),
                        );
                      }),
                ],
              ),

              ///采购流水
              // Column(
              //   children: [
              //     GetBuilder<DailyAccountController>(
              //         id: 'purchase_money_data_range',
              //         builder: (_) {
              //           return Container(
              //               color: Colors.white,
              //               padding: EdgeInsets.only(left: 30.w, right: 20.w),
              //               margin: EdgeInsets.only(bottom: 10.w),
              //               alignment: Alignment.center,
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 children: [
              //                   TextButton(
              //                     style: ButtonStyle(
              //                       padding: MaterialStateProperty.all(
              //                           EdgeInsets.zero),
              //                       backgroundColor:
              //                           MaterialStateProperty.all(Colors.white),
              //                     ),
              //                     onPressed: () {
              //                       PickerDateUtils.pickerDate(context,
              //                           (result) {
              //                         if (null != result) {
              //                           if (result.compareTo(
              //                                   state.endDatePurchaseMoney) >
              //                               0) {
              //                             Toast.show('起始时间需要小于结束时间');
              //                             return;
              //                           }
              //                           state.startDatePurchaseMoney = result;
              //                           controller.update(
              //                               ['purchase_money_data_range']);
              //                         }
              //                       });
              //                     },
              //                     child: Text(
              //                       ' ${DateUtil.formatDefaultDate(state.startDatePurchaseMoney)}',
              //                       style: TextStyle(
              //                         color: Colours.button_text,
              //                         fontSize: 30.sp,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                   ),
              //                   Container(
              //                     padding:
              //                         EdgeInsets.symmetric(horizontal: 16.w),
              //                     child: Text(
              //                       '至',
              //                       style: TextStyle(
              //                         color: Colours.text_ccc,
              //                         fontSize: 28.sp,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                   ),
              //                   TextButton(
              //                       style: ButtonStyle(
              //                         padding: MaterialStateProperty.all(
              //                             EdgeInsets.zero),
              //                         backgroundColor:
              //                             MaterialStateProperty.all(
              //                                 Colors.white), // 背景色
              //                       ),
              //                       onPressed: () {
              //                         PickerDateUtils.pickerDate(context,
              //                             (result) {
              //                           if (null != result) {
              //                             if (result.compareTo(state
              //                                     .startDatePurchaseMoney) <
              //                                 0) {
              //                               Toast.show('结束时间需要大于起始时间');
              //                               return;
              //                             }
              //                             state.endDatePurchaseMoney = result;
              //                             controller.update(
              //                                 ['purchase_money_data_range']);
              //                           }
              //                         });
              //                       },
              //                       child: Text(
              //                         ' ${DateUtil.formatDefaultDate(state.endDatePurchaseMoney)}',
              //                         style: TextStyle(
              //                           color: Colours.button_text,
              //                           fontSize: 30.sp,
              //                           fontWeight: FontWeight.w500,
              //                         ),
              //                       )),
              //                   TextButton(
              //                       style: ButtonStyle(
              //                         padding: MaterialStateProperty.all(
              //                             EdgeInsets.symmetric(horizontal: 12)),
              //                         backgroundColor:
              //                             MaterialStateProperty.all(
              //                                 Colors.white),
              //                         // 背景色
              //                         shape: MaterialStateProperty.all(
              //                           RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(35.0), // 圆角
              //                             side: BorderSide(
              //                               width: 1.0, // 边框宽度
              //                               color: Colours.primary, // 边框颜色
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       onPressed: () =>
              //                           controller.changeDatePurchaseMoney(),
              //                       child: Text(
              //                         '查询',
              //                         style: TextStyle(color: Colours.primary),
              //                       ))
              //                 ],
              //               ));
              //         }),
              //     GetBuilder<DailyAccountController>(
              //         id: 'daily_purchase_money',
              //         builder: (_) {
              //           return Expanded(
              //             child: CustomEasyRefresh(
              //               controller: state.refreshController,
              //               onLoad: controller.onLoad,
              //               onRefresh: controller.onRefresh,
              //               emptyWidget: state.purchaseMoneyStatistics == null
              //                   ? LottieIndicator()
              //                   : state.purchaseMoneyStatistics?.isEmpty ?? true
              //                       ? EmptyLayout(hintText: '什么都没有'.tr)
              //                       : null,
              //               child: ListView.builder(
              //                 itemBuilder: (context, index) {
              //                   var purchaseMoneyStatistics =
              //                       state.purchaseMoneyStatistics![index];
              //                   return InkWell(
              //                       onTap: () => controller.toPurchaseDetail(purchaseMoneyStatistics),
              //                       child: Container(
              //                         width: double.maxFinite,
              //                         alignment: Alignment.centerLeft,
              //                         color: Colors.white,
              //                         margin: EdgeInsets.only(bottom: 8.w),
              //                         child: Column(
              //                           children: [
              //                             SizedBox(
              //                               height: 32.w,
              //                             ),
              //                             Container(
              //                                 padding: EdgeInsets.symmetric(
              //                                     horizontal: 32.w),
              //                                 alignment: Alignment.centerLeft,
              //                                 child: Row(
              //                                   children: [
              //                                     Text(
              //                                       DateUtil.formatDefaultDate2(
              //                                           purchaseMoneyStatistics
              //                                               .orderDTO
              //                                               ?.gmtCreate),
              //                                       style: TextStyle(
              //                                           fontSize: 26.sp,
              //                                           color:
              //                                               Colours.text_ccc),
              //                                     ),
              //                                     Expanded(child:
              //                                     Text(
              //                                       purchaseMoneyStatistics
              //                                               .orderDTO
              //                                               ?.batchNo ??
              //                                           '',
              //                                       textAlign: TextAlign.right,
              //                                       style: TextStyle(
              //                                           fontSize: 28.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500,
              //                                           color: Colours.primary),
              //                                     ))
              //                                   ],
              //                                 )),
              //                             Container(
              //                                 alignment: Alignment.centerLeft,
              //                                 padding: EdgeInsets.only(
              //                                     left: 32.w,
              //                                     right: 32.w,
              //                                     top: 16.w),
              //                                 child: Row(
              //                                   children: [
              //                                     Text(
              //                                       TextUtil.listToStr(
              //                                           purchaseMoneyStatistics
              //                                               .orderDTO
              //                                               ?.productNameList),
              //                                       style: TextStyle(
              //                                           fontSize: 30.sp,
              //                                           color: Colours.text_333,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Visibility(
              //                                         visible: (purchaseMoneyStatistics
              //                                                     .orderDTO
              //                                                     ?.orderType ==
              //                                                 OrderType
              //                                                     .SALE_RETURN
              //                                                     .value) ||
              //                                             (purchaseMoneyStatistics
              //                                                     .orderDTO
              //                                                     ?.orderType ==
              //                                                 OrderType
              //                                                     .PURCHASE_RETURN
              //                                                     .value),
              //                                         child: Container(
              //                                           margin: EdgeInsets
              //                                               .symmetric(
              //                                                   horizontal:
              //                                                       16.w),
              //                                           padding: EdgeInsets
              //                                               .symmetric(
              //                                                   horizontal: 8.w,
              //                                                   vertical: 4.w),
              //                                           decoration: (BoxDecoration(
              //                                               borderRadius:
              //                                                   BorderRadius
              //                                                       .circular(
              //                                                           (36)),
              //                                               border: Border.all(
              //                                                   color: Colors
              //                                                       .orange,
              //                                                   width: 3.w),
              //                                               color:
              //                                                   Colors.white)),
              //                                           child: Text(
              //                                             '退',
              //                                             style: TextStyle(
              //                                               fontSize: 28.sp,
              //                                               color:
              //                                                   Colors.orange,
              //                                             ),
              //                                           ),
              //                                         )),
              //                                   ],
              //                                 )),
              //                             Container(
              //                               padding: EdgeInsets.only(
              //                                   left: 32.w,
              //                                   right: 32.w,
              //                                   top: 24.w),
              //                               alignment: Alignment.centerLeft,
              //                               child: Row(
              //                                 children: [
              //                                   Text(
              //                                     '采购成本：',
              //                                     style: TextStyle(
              //                                         fontSize: 28.sp,
              //                                         color: Colours.text_ccc),
              //                                   ),
              //                                   Text(
              //                                     DecimalUtil.formatAmount(
              //                                        ( purchaseMoneyStatistics.orderDTO?.totalAmount??Decimal.zero)-
              //                                        ( purchaseMoneyStatistics.orderDTO?.discountAmount??Decimal.zero)),
              //                                     style: TextStyle(
              //                                         fontSize: 30.sp,
              //                                         fontWeight:
              //                                             FontWeight.w500,
              //                                         color: Colours.text_666),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             InkWell(
              //                               onTap: () =>
              //                                   controller.toCostDetail(
              //                                       purchaseMoneyStatistics),
              //                               child: Container(
              //                                 padding: EdgeInsets.symmetric(
              //                                     horizontal: 32.w,
              //                                     vertical: 16.w),
              //                                 alignment: Alignment.centerLeft,
              //                                 child: Row(
              //                                   children: [
              //                                     Text(
              //                                       '采购费用：',
              //                                       style: TextStyle(
              //                                           fontSize: 28.sp,
              //                                           color:
              //                                               Colours.text_ccc),
              //                                     ),
              //                                     Expanded(
              //                                         child: Text(
              //                                       controller.getCostTotalAmount(
              //                                           purchaseMoneyStatistics
              //                                               .externalOrderBaseDTOList),
              //                                       style: TextStyle(
              //                                           fontSize: 30.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500,
              //                                           color:
              //                                               Colours.text_666),
              //                                     )),
              //                                     Text(
              //                                       '费用详情',
              //                                       style: TextStyle(
              //                                           fontSize: 28.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500,
              //                                           color:
              //                                               Colours.text_999),
              //                                     ),
              //                                     Padding(
              //                                       padding:
              //                                           EdgeInsets.symmetric(
              //                                               horizontal: 10),
              //                                       child: LoadAssetImage(
              //                                         'common/arrow_right',
              //                                         width: 25.w,
              //                                         color: Colours.text_999,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ));
              //                 },
              //                 itemCount:
              //                     state.purchaseMoneyStatistics?.length ?? 0,
              //               ),
              //               //separatorBuilder是分隔符组件，可以直接拿来用
              //             ),
              //           );
              //         }),
              //   ],
              // ),

              ///销售概况
              Column(
                children: [
                  GetBuilder<DailyAccountController>(
                      id: 'sales_product_data_range',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 30.w, right: 20.w),
                            margin: EdgeInsets.only(bottom: 10.w),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    PickerDateUtils.pickerDate(context,
                                        (result) {
                                      if (null != result) {
                                        if (result.compareTo(
                                                controller.state.endDateSalesProduct) >
                                            0) {
                                          Toast.show('起始时间需要小于结束时间');
                                          return;
                                        }
                                        controller.state.startDateSalesProduct = result;
                                        controller.update(
                                            ['sales_product_data_range']);
                                      }
                                    });
                                  },
                                  child: Text(
                                    ' ${DateUtil.formatDefaultDate(controller.state.startDateSalesProduct)}',
                                    style: TextStyle(
                                      color: Colours.button_text,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    '至',
                                    style: TextStyle(
                                      color: Colours.text_ccc,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white), // 背景色
                                    ),
                                    onPressed: () {
                                      PickerDateUtils.pickerDate(context,
                                          (result) {
                                        if (null != result) {
                                          if (result.compareTo(
                                                  controller.state.startDateSalesProduct) <
                                              0) {
                                            Toast.show('结束时间需要大于起始时间');
                                            return;
                                          }
                                          controller.state.endDateSalesProduct = result;
                                          controller.update(
                                              ['sales_product_data_range']);
                                        }
                                      });
                                    },
                                    child: Text(
                                      ' ${DateUtil.formatDefaultDate(controller.state.endDateSalesProduct)}',
                                      style: TextStyle(
                                        color: Colours.button_text,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 12)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      // 背景色
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35.0), // 圆角
                                          side: BorderSide(
                                            width: 1.0, // 边框宽度
                                            color: Colours.primary, // 边框颜色
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () =>
                                        controller.changeDateSaleProduct(),
                                    child: Text(
                                      '查询',
                                      style: TextStyle(color: Colours.primary),
                                    ))
                              ],
                            ));
                      }),
                  GetBuilder<DailyAccountController>(
                      id: 'daily_sales_product_statistics',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Flexible(
                          child: controller.state.salesProductStatisticsDTO?.isEmpty ??
                                  true
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    var salesProductStatisticsDTO =
                                        controller.state.salesProductStatisticsDTO![index];
                                    return Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w, vertical: 24.w),
                                      child:
                                          Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 10.w,
                                                  left: 20.w,
                                                  right: 20.w),
                                              width: double.infinity,
                                              child: Text(
                                                salesProductStatisticsDTO
                                                        .productName ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 32.sp,
                                                  color: Colours.text_333,
                                                ),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 10.w,
                                                  left: 20.w,
                                                  right: 20.w),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Text(
                                                        '销售实收：',
                                                        style: TextStyle(
                                                            fontSize: 28.sp,
                                                            color: Colours
                                                                .text_ccc),
                                                      ),
                                                      Expanded(child:
                                                      Text(DecimalUtil.formatAmount(((salesProductStatisticsDTO.totalAmount??Decimal.zero)
                                                         -( salesProductStatisticsDTO.discountAmount??Decimal.zero)-
                                                             (salesProductStatisticsDTO.creditAmount??Decimal.zero))),
                                                        style: TextStyle(
                                                            fontSize: 30.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colours
                                                                .text_666),
                                                      ))
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Text(
                                                        '数量：',
                                                        style: TextStyle(
                                                            fontSize: 28.sp,
                                                            color: Colours
                                                                .text_ccc),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        controller.judgeUnit(
                                                            salesProductStatisticsDTO),
                                                        style: TextStyle(
                                                            fontSize: 30.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colours
                                                                .text_666),
                                                      ))
                                                    ],
                                                  )),
                                                ],
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 10.w, left: 20.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '销售赊账：',
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        color:
                                                            Colours.text_ccc),
                                                  ),
                                                  Text(
                                                    DecimalUtil.formatAmount(
                                                        salesProductStatisticsDTO
                                                            .creditAmount),
                                                    style: TextStyle(
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colours.text_666),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                  //separatorBuilder是分隔符组件，可以直接拿来用
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    height: 2.w,
                                    color: Colours.divider,
                                    width: double.infinity,
                                  ),
                                  itemCount:
                                      controller.state.salesProductStatisticsDTO?.length ??
                                          0,
                                ),
                        );
                      }),
                ],
              ),

              ///赊账流水
              Column(
                children: [
                  Container(
                      color: Colors.white,
                      height: 80.w,
                      padding: EdgeInsets.only(left: 30.w, right: 20.w),
                      margin: EdgeInsets.only(bottom: 10.w),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => controller.pickerCreditMoneyDate(context),
                        child: GetBuilder<DailyAccountController>(
                            id: 'daily_credit_money_date',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '选择日期：',
                                    style: TextStyle(
                                      color: Colours.text_ccc,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateUtil.formatDefaultDate(
                                        controller.state.dateSaleMoney),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colours.text_999,
                                  )
                                ],
                              );
                            }),
                      )),
                  GetBuilder<DailyAccountController>(
                      id: 'daily_custom_credit_amount',
                      init: controller,
                      global: false,
                      builder: (_) => Container(
                          padding: EdgeInsets.only(
                              right: 32.w, top: 8.w, bottom: 8.w),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '赊账合计：',
                                style: TextStyle(
                                    fontSize: 28.sp, color: Colours.text_ccc),
                              ),
                              Text(
                                DecimalUtil.formatAmount(
                                    controller.state.totalCreditAmount),
                                style: TextStyle(
                                    fontSize: 32.sp, color: Colors.orange),
                              )
                            ],
                          ))),
                  GetBuilder<DailyAccountController>(
                      id: 'daily_custom_credit',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Flexible(
                          child: controller.state.customCreditDTO?.isEmpty ?? true
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    var customCreditDTO =
                                        controller.state.customCreditDTO![index];
                                    return InkWell(
                                      onTap: () => controller
                                          .toSalesDetail(customCreditDTO),
                                      child: Container(
                                        width: double.maxFinite,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.w),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30.w,
                                                  vertical: 24.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    customCreditDTO
                                                            .customName ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colours.text_333),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.w),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 4.w),
                                                    decoration: (BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular((36)),
                                                        border: Border.all(
                                                            color: customCreditDTO
                                                                        .customType ==
                                                                    CustomType
                                                                        .CUSTOM
                                                                        .value
                                                                ? Colours
                                                                    .primary
                                                                : Colors.orange,
                                                            width: 3.w),
                                                        color: Colors.white)),
                                                    child: Text(
                                                      customCreditDTO
                                                                  .customType ==
                                                              CustomType
                                                                  .CUSTOM.value
                                                          ? '客'
                                                          : '供',
                                                      style: TextStyle(
                                                        fontSize: 28.sp,
                                                        color: customCreditDTO
                                                                    .customType ==
                                                                CustomType
                                                                    .CUSTOM
                                                                    .value
                                                            ? Colours.primary
                                                            : Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Visibility(
                                                            visible: (customCreditDTO.creditType ==
                                                                OrderType.SALE_RETURN.value) ||
                                                                (customCreditDTO.creditType ==
                                                                    OrderType.PURCHASE_RETURN.value),
                                                            child: Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: 8.w),
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 8.w,
                                                                  vertical: 4.w),
                                                              decoration: (BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      (36)),
                                                                  border: Border.all(
                                                                      color: Colors.orange,
                                                                      width: 3.w),
                                                                  color: Colors.white)),
                                                              child: Text(
                                                                '退',
                                                                style: TextStyle(
                                                                  fontSize: 28.sp,
                                                                  color: Colors.orange,
                                                                ),
                                                              ),
                                                            )),
                                                        Text(
                                                          DecimalUtil.formatAmount(
                                                              customCreditDTO
                                                                  .creditAmount),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              color: Colours.text_666,
                                                              fontWeight: FontWeight.w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 30.w,
                                                  left: 30.w,
                                                  bottom: 16.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    customCreditDTO
                                                            .creatorName ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        color:
                                                            Colours.text_999),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    textAlign: TextAlign.end,
                                                    DateUtil.formatDefaultDate2(
                                                        customCreditDTO
                                                            .gmtCreate),
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        color:
                                                            Colours.text_999),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  //separatorBuilder是分隔符组件，可以直接拿来用
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    height: 2.w,
                                    color: Colours.divider,
                                    width: double.infinity,
                                  ),
                                  itemCount: controller.state.customCreditDTO?.length ?? 0,
                                ),
                        );
                      }),
                ],
              ),
            ],
          ),

      ),
    );
  }
}

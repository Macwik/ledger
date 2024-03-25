import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';

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
        appBar: TitleBar(title: '每日流水',),
        body: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child:Column(
              children: [
                Container(
                    color: Colors.white,
                    height: 90.w, // 调整TabBar高度
                    child: TabBar(
                     // controller: controller.tabController,
                      tabs: [
                        Tab(text:'交易资金'),
                        Tab(text: '销售货物',
                        ),
                          Tab(text: '赊账情况'),
                      ],
                      indicatorWeight: 3.w,
                      indicatorPadding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.all(0),
                      isScrollable: false,
                      indicatorColor: Colours.primary,
                      unselectedLabelColor: Colours.text_999,
                      unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w500),
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      labelColor: Colours.primary,
                    )),
                Expanded(child: TabBarView(
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
                                              child: Row(children: [
                                                Text(
                                                  salesProductStatisticsDTO
                                                      .productName ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 32.sp,
                                                    color: Colours.text_333,
                                                  ),
                                                ),
                                              ],)
                                          ),
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
                                              controller.state.dateCreditMoney),
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
                ))
              ],
            )
           ),

      ),
    );
  }
}

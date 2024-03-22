import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/modules/home/home_controller.dart';
import 'package:ledger/res/export.dart';
import 'package:flutter/material.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final state = Get.find<HomeController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    controller.checkUpdate(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            liverAppBar(),
            SliverPersistentHeader(
              pinned: false,
              delegate: _MySliverPersistentHeaderDelegate(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 32.w,
              ),
            ),
            GetBuilder<HomeController>(
                id: 'home_head_function',
                builder: (_) {
                  return SliverPadding(
                    padding: EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 36.w,
                        mainAxisSpacing: 24.w,
                        childAspectRatio: 0.639,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return gridItem(index);
                      }, childCount: 7),
                    ),
                  );
                }),
            // SliverPadding(
            //   padding: EdgeInsets.all(8),
            //   sliver: SliverGrid(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 5,
            //       crossAxisSpacing: 36.w,
            //       mainAxisSpacing: 0,
            //       childAspectRatio: 0.639,
            //     ),
            //     delegate: SliverChildBuilderDelegate((context, index) {
            //       return
            //           InkWell(
            //             onTap: () => Get.toNamed(RouteConfig.more),
            //             child: Flex(
            //               direction: Axis.vertical,
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Expanded(
            //                     child: AspectRatio(
            //                       aspectRatio: 1,
            //                       child: ClipOval(
            //                         child: Container(
            //                           width: double.infinity,
            //                           color: Color(0x4C04BFB3),
            //                           child: Center(
            //                             child: LoadAssetImage(
            //                               'more',
            //                               width: 66.w,
            //                               height: 66.w,
            //                               fit: BoxFit.fill,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     )),
            //                 Padding(
            //                   padding: const EdgeInsets.only(top: 13),
            //                   child: Text(
            //                     '更多',
            //                     style: TextStyle(
            //                       fontSize: 28.sp,
            //                       fontWeight: FontWeight.w700,
            //                       color: Colours.text_999,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //     }, childCount: 1),
            //   ),
            // ),
            //picture
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 52.w, top: 52.w),
                child: Text(
                  '常用功能',
                  style: TextStyle(
                      fontSize: 32.sp,
                      color: Colours.text_333,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GetBuilder<HomeController>(
                id: 'home_common_function',
                builder: (_) {
                  return //常用功能
                      SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext ctx, int index) {
                        return functionCard(index);
                      },
                      childCount: 3,
                      addAutomaticKeepAlives: false,
                      addSemanticIndexes: false,
                    ),
                  );
                }),

            //card
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext ctx, int index) {
                  return showList(ctx, index);
                },
                childCount: 1,
                addAutomaticKeepAlives: false,
                addSemanticIndexes: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget liverAppBar() {
    return SliverAppBar(
      // toolbarHeight: 88.w,
      pinned: true,
      leadingWidth: (ScreenUtil().screenWidth - 108.w),
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () => Get.toNamed(RouteConfig.myAccount,
            arguments: {'isSelect': IsSelectType.FALSE.value}),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32.w),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (ScreenUtil().screenWidth - 182.w),
              ),
              child: GetBuilder<HomeController>(
                  id: 'home_active_ledger_name',
                  builder: (_) {
                    return Text(
                      controller.getActiveLedger() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: LoadAssetImage(
                'common/arrow_right',
                width: 32.w,
                color: Colours.text_999,
              ),
            ),
          ],
        ),
      ),
      actions: [
        PermissionOwnerWidget(
          child: InkWell(
            onTap: () => Get.toNamed(RouteConfig.employeeManage),
            child: Container(
              padding: EdgeInsets.only(right: 32.w),
              child: Row(
                children: [
                  Text(
                    '成员',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.contact_page_sharp,
                    color: Colours.text_ccc,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget showList(BuildContext context, int index) {
    return PermissionWidget(
        permissionCode: PermissionCode.account_page_permission,
        child: Column(
          children: [
            Card(
              elevation: 6,
              margin: EdgeInsets.only(left: 34.w, top: 56.w, right: 34.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child: GetBuilder<HomeController>(
                  id: 'home_product_statistics',
                  builder: (_) {
                    return InkWell(
                        onTap: () => Get.toNamed(RouteConfig.dailyAccount,
                                arguments: {
                                  'initialIndex': 1,
                                  'startDateSalesProduct': DateTime.now()
                                }),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 38.w,
                                  right: 38.w,
                                  top: 18.w,
                                  bottom: 14.w),
                              child: Row(
                                children: [
                                  Text(
                                    '今日销售情况：',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 26.sp,
                                      color: Colours.text_ccc,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text.rich(
                                      textAlign: TextAlign.right,
                                      TextSpan(
                                        text: '总收入：',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.sp,
                                          color: Colours.text_ccc,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: DecimalUtil.formatDecimal(
                                                  state.todaySalesAmount),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 28.sp,
                                                color: Colours.text_ccc,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            MediaQuery.removeViewPadding(
                              context: context,
                              removeTop: true,
                              child: state.salesProductStatisticsDTO?.isEmpty ??
                                      true
                                  ? EmptyLayout(hintText: '什么都没有')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state
                                          .salesProductStatisticsDTO?.length,
                                      itemBuilder: (ctx, index) {
                                        SalesProductStatisticsDTO
                                            salesProductStatistics =
                                            state.salesProductStatisticsDTO![
                                                index];
                                        return Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  top: 8.w, bottom: 8.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 48.w),
                                                  Expanded(
                                                    child: Container(
                                                      width: 91.w,
                                                      child: Text(
                                                        salesProductStatistics
                                                                .productName ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 30.sp,
                                                          color:
                                                              Colours.text_333,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: (Flex(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      direction: Axis.vertical,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '销售金额：',
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: Colours
                                                                    .text_ccc,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                              DecimalUtil.formatDecimal(((salesProductStatistics
                                                                          .totalAmount ??
                                                                      Decimal
                                                                          .zero) -
                                                                  (salesProductStatistics
                                                                          .discountAmount ??
                                                                      Decimal
                                                                          .zero))),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      28.sp,
                                                                  color: Colors
                                                                      .red[600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                          ],
                                                        ),
                                                        SizedBox(height: 4.w),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '销售数量：',
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: Colours
                                                                    .text_ccc,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                              controller
                                                                  .judgeSlaveUnit(
                                                                      salesProductStatistics),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      28.sp,
                                                                  color: Colors
                                                                      .teal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                          ],
                                                        ),
                                                        Visibility(
                                                            visible:
                                                                salesProductStatistics
                                                                        .unitType !=
                                                                    UnitType
                                                                        .SINGLE
                                                                        .value,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        4.w),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '销售数量：',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.sp,
                                                                        color: Colours
                                                                            .text_ccc,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      controller
                                                                          .judgeMasterUnit(
                                                                              salesProductStatistics),
                                                                      style: TextStyle(
                                                                          fontSize: 28
                                                                              .sp,
                                                                          color: Colours
                                                                              .text_999,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ))
                                                      ],
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colours.divider,
                                              margin: EdgeInsets.only(
                                                  left: 20.0, right: 20),
                                              height: 1.w,
                                              width: double.infinity,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                            Container(
                              height: 20.w,
                              color: Colors.white,
                            ),
                          ],
                        ));
                  }),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(left: 34.w, top: 56.w, right: 34.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child: GetBuilder<HomeController>(
                  id: 'home_payment_statistics',
                  builder: (_) {
                    return InkWell(
                      onTap: () => Get.toNamed(RouteConfig.dailyAccount,
                          arguments: {'initialIndex': 0}),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 38.w,
                                right: 38.w,
                                top: 18.w,
                                bottom: 14.w),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '今日交易资金情况：',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.sp,
                                    color: Colours.text_ccc,
                                  ),
                                )),
                                Text.rich(
                                  textAlign: TextAlign.right,
                                  TextSpan(
                                    text: '合计： ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.sp,
                                      color: Colours.text_ccc,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: DecimalUtil.formatDecimal(
                                              state.todayPaymentAmount,
                                              scale: 2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28.sp,
                                            color: Colours.text_666,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removeViewPadding(
                            context: context,
                            removeTop: true,
                            child: state.salesPaymentStatisticsDTO?.isEmpty ??
                                    true
                                ? EmptyLayout(hintText: '什么都没有')
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        state.salesPaymentStatisticsDTO?.length,
                                    itemBuilder: (ctx, index) {
                                      SalesPaymentStatisticsDTO
                                          salesPaymentStatistics =
                                          state.salesPaymentStatisticsDTO![
                                              index];
                                      return Column(
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.only(
                                                top: 24.w, bottom: 24.w),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 48.w),
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    LoadAssetImage(
                                                      salesPaymentStatistics
                                                              .paymentMethodIcon ??
                                                          'payment_common',
                                                      format: ImageFormat.png,
                                                      height: 50.w,
                                                      width: 50.w,
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      salesPaymentStatistics
                                                              .paymentMethodName ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 32.sp,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                  ],
                                                )),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '销售金额：',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: Colours
                                                                .text_ccc,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          '￥${salesPaymentStatistics.paymentAmount ?? ''}',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_666,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colours.divider,
                                            margin: EdgeInsets.only(
                                                left: 20.0, right: 20),
                                            height: 1.w,
                                            width: double.infinity,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                          Container(
                            height: 20.w,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(left: 34.w, top: 56.w, right: 34.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child: GetBuilder<HomeController>(
                  id: 'home_repayment_statistics',
                  builder: (_) {
                    return InkWell(
                        onTap: () => Get.toNamed(RouteConfig.repaymentRecord,
                                arguments: {
                                  'customType': CustomType.CUSTOM.value,
                                }),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 38.w,
                                  right: 38.w,
                                  top: 18.w,
                                  bottom: 14.w),
                              child: Row(
                                children: [
                                  Text(
                                    '今日还款情况：',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 26.sp,
                                      color: Colours.text_ccc,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text.rich(
                                      textAlign: TextAlign.right,
                                      TextSpan(
                                        text: '合计：： ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.sp,
                                          color: Colours.text_ccc,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: DecimalUtil.formatDecimal(
                                                  state.todayRepaymentAmount,
                                                  scale: 2),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 28.sp,
                                                color: Colours.text_666,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            MediaQuery.removeViewPadding(
                              context: context,
                              removeTop: true,
                              child: state.salesRepaymentStatisticsDTO
                                          ?.isEmpty ??
                                      true
                                  ? EmptyLayout(hintText: '什么都没有')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state
                                          .salesRepaymentStatisticsDTO?.length,
                                      itemBuilder: (ctx, index) {
                                        SalesRepaymentStatisticsDTO
                                            salesRepaymentStatistics =
                                            state.salesRepaymentStatisticsDTO![
                                                index];
                                        return Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  top: 24.w, bottom: 24.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 48.w),
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        salesRepaymentStatistics
                                                                .customName ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 30.sp,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                    ],
                                                  )),
                                                  Expanded(
                                                    child: (Flex(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      direction: Axis.vertical,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '还款金额：',
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: Colours
                                                                    .text_ccc,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                              DecimalUtil.subtract(
                                                                  salesRepaymentStatistics
                                                                      .totalAmount,
                                                                  salesRepaymentStatistics
                                                                      .discountAmount),
                                                              style: TextStyle(
                                                                fontSize: 28.sp,
                                                                color: Colours
                                                                    .text_666,
                                                              ),
                                                            )),
                                                          ],
                                                        ),
                                                        SizedBox(height: 4.w),
                                                        Visibility(
                                                          visible:
                                                              salesRepaymentStatistics
                                                                      .discountAmount !=
                                                                  Decimal.zero,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '优惠金额：',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      20.sp,
                                                                  color: Colours
                                                                      .text_ccc,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Text(
                                                                '￥${salesRepaymentStatistics.discountAmount ?? ''}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        24.sp,
                                                                    color: Colours
                                                                        .text_999,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colours.divider,
                                              margin: EdgeInsets.only(
                                                  left: 20.0, right: 20),
                                              height: 1.w,
                                              width: double.infinity,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                            Container(
                              height: 20.w,
                              color: Colors.white,
                            ),
                          ],
                        ));
                  }),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(left: 34.w, right: 38.w, top: 56.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child: GetBuilder<HomeController>(
                  id: 'home_credit_statistics',
                  builder: (_) {
                    return InkWell(
                        onTap: () => Get.toNamed(RouteConfig.dailyAccount,
                            arguments: {'initialIndex': 2}),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 38.w,
                                  right: 38.w,
                                  top: 18.w,
                                  bottom: 14.w),
                              child: Row(
                                children: [
                                  Text(
                                    '今日赊账情况：',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 26.sp,
                                      color: Colours.text_ccc,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text.rich(
                                      textAlign: TextAlign.right,
                                      TextSpan(
                                        text: '合计： ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.sp,
                                          color: Colours.text_ccc,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: DecimalUtil.formatDecimal(
                                                  state.todayCreditAmount,
                                                  scale: 2),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 28.sp,
                                                color: Colours.text_666,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            MediaQuery.removeViewPadding(
                              context: context,
                              removeTop: true,
                              child: state.salesCreditStatisticsDTO?.isEmpty ??
                                      true
                                  ? EmptyLayout(hintText: '什么都没有')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state
                                          .salesCreditStatisticsDTO?.length,
                                      itemBuilder: (ctx, index) {
                                        SalesCreditStatisticsDTO
                                            salesCreditStatisticsDTO =
                                            state.salesCreditStatisticsDTO![
                                                index];
                                        return Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  top: 24.w, bottom: 24.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 48.w),
                                                  Expanded(
                                                      child: Text(
                                                    salesCreditStatisticsDTO
                                                            .customName ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 30.sp,
                                                      color: Colors.black,
                                                    ),
                                                  )),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '赊账金额：',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: Colours
                                                                .text_ccc,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          '￥${salesCreditStatisticsDTO.creditAmount ?? '0.00'}',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: Colours
                                                                  .text_666,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colours.divider,
                                              margin: EdgeInsets.only(
                                                  left: 20.0, right: 20),
                                              height: 1.w,
                                              width: double.infinity,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                            Container(
                              height: 20.w,
                              color: Colors.white,
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ));
  }
}

const List<String> gridItemNames = ['销售', '采购', '库存', '收支', '还款','账目', '更多'];
const List<int> gridItemColors = [
  0x7C9BA9FA,
  0xFFFCEAF4,
  0x60FF8D1A,
  0x529BD4FA,
  0x4C04BFB3,
  0xFFFAD984,
  0x4C04BFB3
];
const List<String> gridItemPaths = [
  'xiaoshou',
  'caigou',
  'kucun',
  'home_cost',
  'home_repayment',
  'zhangmu',
  'more'
];

final List<Function()> gridItemRoutes = [
  () => Get.toNamed(RouteConfig.saleRecord, arguments: {'index': 0}),
  () => Get.toNamed(RouteConfig.purchaseRecord, arguments: {'index': 0}),
  () => Get.toNamed(RouteConfig.stockList, arguments: {'select': StockListType.DETAIL}),
  () => Get.toNamed(RouteConfig.costRecord, arguments: {'index': 0}),
  () => Get.toNamed(RouteConfig.repaymentRecord, arguments: {'customType': CustomType.CUSTOM.value}),
  () => Get.toNamed(RouteConfig.dailyAccount),
  () => Get.toNamed(RouteConfig.more),
];

const List<String> gridItemPermission = [
  PermissionCode.sales_page_permission,
  PermissionCode.purchase_page_permission,
  PermissionCode.stock_page_permission,
  PermissionCode.stock_page_permission,
  PermissionCode.funds_page_permission,//ToDO 此处不需要限制
  PermissionCode.account_page_permission,
  PermissionCode.account_page_permission,//ToDO 此处不需要限制
];

Widget gridItem(int index) {
  return PermissionWidget(
    permissionCode: gridItemPermission[index],
    child: InkWell(
      onTap: gridItemRoutes[index],
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: Container(
                width: double.infinity,
                color: Color(gridItemColors[index]),
                child: Center(
                  child: LoadAssetImage(
                    gridItemPaths[index],
                    width: 66.w,
                    height: 66.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Text(
              gridItemNames[index],
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colours.text_999,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent =
      (ScreenUtil().screenWidth - 53.0) * 2.w * 0.47 + 134.w;
  final double _maxExtent =
      (ScreenUtil().screenWidth - 53.0) * 2.w * 0.47 + 134.w;

  final controller = Get.find<HomeController>();
  final state = Get.find<HomeController>().state;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<HomeController>(
        id: 'home_sum',
        builder: (_) {
          return Container(
            width: (ScreenUtil().screenWidth - 52.0) * 2.w,
            height: (ScreenUtil().screenWidth - 52.0) * 2.w * 0.7,
            margin: EdgeInsets.only(left: 16.w, right: 16.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homebg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              '销售实收：',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w400,
                                              )))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          state.privacyText
                                              ?'***'
                                              :'￥${state.homeStatisticsDTO?.totalSalesAmount ?? '0'}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 38.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '销售地费用：',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          state.privacyText
                                              ?'***'
                                              :'￥${state.homeStatisticsDTO?.totalCostAmount ?? '0'}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 38.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Visibility(
                                visible: state
                                        .homeStatisticsDTO?.totalIncomeAmount !=
                                    Decimal.zero,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '销售地收入：',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ))),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            state.privacyText
                                                ?'***'
                                                :'￥${state.homeStatisticsDTO?.totalIncomeAmount ?? '0'}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 38.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              )),
                        ],
                      )),
                ),
                Container(
                  height: 1.w,
                  color: Colors.white,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                '客户还款: ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(state.privacyText
                                                ?'***'
                                                :'￥${state.homeStatisticsDTO?.totalRepaymentAmount ?? '0'}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 38.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )))
                                    ],
                                  ))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '客户欠款: ',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(state.privacyText
                                                      ?'***'
                                                      : '￥${state.homeStatisticsDTO?.totalCreditAmount ?? '0'}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 38.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )))
                                    ],
                                  ))),
                          Expanded(child:InkWell(
                            onTap: (){ state.privacyText = !state.privacyText;
                              controller.update(['home_sum']);
                            },
                            child: LoadSvg(
                              state.privacyText
                              ?'svg/ic_home_eye_close'
                            :'svg/ic_home_eye_open',
                            width: 50.w,
                              color: Colors.white,
                          ),))
                        ],
                      ),
                    )),
              ],
            ),
          );
        });
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

List<String> titles = ['销售开单', '销售记录', '客户列表'];
List<String> subTitles = ['销售货物，记录销售货物及资金变化', '查看过往销售记录', '客户还款及还款情况记录'];
List<String> functionPaths = ['home_bill', 'home_calendar', 'home_custom'];
List<String> functionRoutes = [
  RouteConfig.retailBill,
  RouteConfig.saleRecord,
  RouteConfig.customRecord
];

const List<String> functionItemPermission = [
  PermissionCode.sales_sale_order_permission,
  PermissionCode.sales_sale_record_permission,
  PermissionCode.sales_sale_order_permission,
];

Widget functionCard(int index) {
  return PermissionWidget(
    permissionCode: functionItemPermission[index],
    child: InkWell(
        onTap: () {
          if (index == 2) {
            Get.toNamed(functionRoutes[index],
                arguments: {'initialIndex': 0, 'isSelectCustom': false});
          } else {
            Get.toNamed(functionRoutes[index],
                arguments: {'orderType': OrderType.SALE});
          }
        },
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.w)),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(left: 34.w, top: 16.w, right: 34.w),
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            height: 170.w,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(242, 148, 201, 0.2),
                child: LoadAssetImage(
                  functionPaths[index],
                  height: 42.w,
                  width: 42.w,
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                titles[index],
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Colours.text_333,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                subTitles[index],
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colours.text_ccc,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )),
  );
}

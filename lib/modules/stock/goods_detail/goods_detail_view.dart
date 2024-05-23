import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'goods_detail_controller.dart';

class GoodsDetailView extends StatelessWidget {
  GoodsDetailView({super.key});

  final controller = Get.find<GoodsDetailController>();
  final state = Get.find<GoodsDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          backPressed:() {Get.back(result: ProcessStatus.OK);} ,
          title: '货物详情'.tr,
        ),
        body: SingleChildScrollView(
          child:  Column(
            children: [
              Card(
                  elevation: 6,
                  shadowColor: Colors.black45,
                  margin: EdgeInsets.all(16.w),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                  ),
                  child:
                  Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40.w, vertical: 32.w),
                  child: InkWell(
                      onTap: () {
                        controller.toProductDetail();
                      },
                      child: Column(
                        children: [
                              Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      state.productDTO?.productName ?? '',
                                      style: TextStyle(
                                        color: state.productDTO?.invalid == IsDeleted.DELETED.value
                                            ? Colours.text_ccc
                                            : Colours.text_333,
                                        fontSize: 34.sp,
                                      ),
                                    )),
                                Visibility(
                                    visible:
                                    state.productDTO?.invalid == IsDeleted.DELETED.value,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 2.w,
                                          bottom: 2.w,
                                          left: 4.w,
                                          right: 4.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      child: Text('已停用',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    )),
                                Expanded(child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('货物资料',
                                        style: TextStyle(
                                          color: Colours.text_999,
                                          fontSize: 26.sp,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: LoadAssetImage(
                                        'common/arrow_right',
                                        width: 25.w,
                                        color: Colours.text_999,
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                            //;}),
                          Visibility(
                              maintainSize: false,
                              visible: state.productDTO?.productPlace ?.isNotEmpty??false ,
                              child:
                              Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: 16.w),
                                  child: Text(
                                    state.productDTO?.productPlace ?? '',
                                    style: TextStyle(
                                      color: state.productDTO?.invalid == IsDeleted.DELETED.value
                                          ? Colours.text_ccc
                                          : Colours.text_999,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28.sp,
                                    ),
                                  ))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 16.w),
                              child: Text(
                                controller.stockNumber(),
                                style: TextStyle(
                                  color: state.productDTO?.invalid == IsDeleted.DELETED.value
                                      ? Colours.text_ccc
                                      : Colours.text_666,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28.sp,
                                ),
                              )),
                        ],
                      )))),
              PermissionWidget(
                permissionCode: PermissionCode.goods_detail_check_detail_permission,
                child:   GetBuilder<GoodsDetailController>(
                  id: 'date_range',
                  builder: (_){
                    return  InkWell(
                        onTap: () => controller
                            .pickerSalesProductDateRange(context),
                        child: Column(
                          children: [
                            Container(
                              height: 2.w,
                              color: Colours.primary,
                            ),
                            Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 16.w),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('选择日期：',
                                        style: TextStyle(
                                          color: Colours.button_text,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Text(
                                        ' ${DateUtil.formatDefaultDate(controller.state.startDate)} ~ ${DateUtil.formatDefaultDate(controller.state.endDate)}',
                                        style: TextStyle(
                                          color: Colours.button_text,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ))
                                  ],
                                )
                            ),
                            Container(
                              height: 2.w,
                              color: Colours.primary,
                            ),
                          ],
                        )

                    );
                    //   Container(
                    // padding: EdgeInsets.symmetric(horizontal: 16.w),
                    // child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton(
                    //           style: ButtonStyle(
                    //             padding: WidgetStateProperty.all(
                    //                 EdgeInsets.zero),
                    //             backgroundColor:
                    //             WidgetStateProperty.all(Colors.white),
                    //             // 背景色
                    //             shape: WidgetStateProperty.all(
                    //               RoundedRectangleBorder(
                    //                 borderRadius:
                    //                 BorderRadius.circular(35.0), // 圆角
                    //                 side: BorderSide(
                    //                   width: 1.0, // 边框宽度
                    //                   color: Colours.primary, // 边框颜色
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           onPressed: () {
                    //             PickerDateUtils.pickerDate(context, (result) {
                    //               if (null != result) {
                    //                 if (result.compareTo(state.endDate) > 0) {
                    //                   Toast.show('起始时间需要小于结束时间');
                    //                   return;
                    //                 }
                    //                 state.startDate = result;
                    //                 controller.update(['date_range']);
                    //               }
                    //             });
                    //           },
                    //           child: Text(
                    //             ' ${DateUtil.formatDefaultDate(state
                    //                 .startDate)}',
                    //             style: TextStyle(
                    //               color: Colours.button_text,
                    //               fontSize: 28.sp,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10.w,
                    //       ),
                    //       Text(
                    //         ' 至',
                    //         style: TextStyle(
                    //           color: Colours.text_333,
                    //           fontSize: 28.sp,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10.w,
                    //       ),
                    //       Expanded(
                    //           child: ElevatedButton(
                    //               style: ButtonStyle(
                    //                 padding: WidgetStateProperty.all(
                    //                     EdgeInsets.zero),
                    //                 backgroundColor:
                    //                 WidgetStateProperty.all(
                    //                     Colors.white), // 背景色
                    //                 shape: WidgetStateProperty.all(
                    //                   RoundedRectangleBorder(
                    //                     borderRadius:
                    //                     BorderRadius.circular(35.0), // 圆角
                    //                     side: BorderSide(
                    //                       width: 1.0, // 边框宽度
                    //                       color: Colours.primary, // 边框颜色
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               onPressed: () {
                    //                 PickerDateUtils.pickerDate(context,
                    //                         (result) {
                    //                       if (null != result) {
                    //                         if (result
                    //                             .compareTo(state.startDate) <
                    //                             0) {
                    //                           Toast.show(
                    //                               '结束时间需要大于起始时间');
                    //                           return;
                    //                         }
                    //                         state.endDate = result;
                    //                         controller.update(['date_range']);
                    //                       }
                    //                     });
                    //               },
                    //               child: Text(
                    //                 ' ${DateUtil.formatDefaultDate(state
                    //                     .endDate)}',
                    //                 style: TextStyle(
                    //                   color: Colours.button_text,
                    //                   fontSize: 28.sp,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ))),
                    //       TextButton(
                    //           style: ButtonStyle(
                    //             padding: WidgetStateProperty.all(
                    //                 EdgeInsets.symmetric(horizontal: 12)),
                    //             backgroundColor:
                    //             WidgetStateProperty.all(
                    //                 Colors.white),
                    //             // 背景色
                    //             shape: WidgetStateProperty.all(
                    //               RoundedRectangleBorder(
                    //                 borderRadius:
                    //                 BorderRadius.circular(35.0), // 圆角
                    //                 side: BorderSide(
                    //                   width: 1.0, // 边框宽度
                    //                   color: Colours.primary, // 边框颜色
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           onPressed: () => controller.changeDateSaleProduct(),
                    //           child: Text(
                    //             '查询',
                    //             style: TextStyle(color: Colours.primary),
                    //           ))
                    //     ]));
                  })),

              GetBuilder<GoodsDetailController>(
                  id: 'goods_detail_product_sales_statistics',
                  builder: (_) =>  PermissionWidget(
                      permissionCode: PermissionCode.goods_detail_check_detail_permission,
                      child:Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 40.w, top: 32.w),
                            child: Text(
                              '销售情况',
                              style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        Card(
                        elevation: 6,
                        shadowColor: Colors.black45,
                        margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(28.w)),
                        ),
                        child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 32.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              '销售数量',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 32.sp,
                                              ),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            controller.judgeUnit(),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colours.divider,
                                      height: 1.w,
                                      margin:
                                      EdgeInsets.only(top: 16.w, bottom: 24.w),
                                      width: double.infinity,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () => controller.explainSalesAmount(),
                                            child:Row(
                                              children: [
                                                Text('实收金额',
                                                    style: TextStyle(
                                                      color: Colours.text_666,
                                                      fontSize: 32.sp,
                                                    )),
                                                SizedBox(width: 16.w,),
                                                LoadAssetImage(
                                                  'ic_home_question',
                                                  color: Colors.black45,
                                                  width: 24.w,
                                                  height: 24.w,
                                                ),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child: Text(
                                              DecimalUtil.formatAmount(((state.productSalesStatisticsDTO?.salesTotalAmount??Decimal.zero)
                                                  -(state.productSalesStatisticsDTO?.salesRepaymentDiscountAmount??Decimal.zero)
                                                  - (state.productSalesStatisticsDTO?.salesDiscountAmount??Decimal.zero)
                                                  - (state.productSalesStatisticsDTO?.salesCreditAmount??Decimal.zero))),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 32.w,),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('销售赊账',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                ))),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              DecimalUtil.formatAmount(
                                                  state.productSalesStatisticsDTO
                                                      ?.salesCreditAmount),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16.w,),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child:InkWell(
                                            onTap: () => Get.toNamed(RouteConfig.productCredit,
                                                arguments:{'id': state.productDTO?.id,
                                                  'creditAmount':state.productSalesStatisticsDTO
                                                      ?.salesCreditAmount,
                                                  'orderType':[OrderType.SALE.value,OrderType.SALE_RETURN.value,OrderType.REFUND.value]} ),
                                            child:  Container(
                                              padding: EdgeInsets.symmetric(vertical:8.w,horizontal: 16.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colours.text_ccc,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child:
                                              Text(
                                                  '赊账明细',
                                                  style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 32.sp,
                                                      fontWeight: FontWeight.w500)),
                                            ))),

                                  ],
                                )),
                        ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 40.w, top: 32.w),
                            child: Text(
                              '采购情况',
                              style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Card(
                              elevation: 6,
                              shadowColor: Colors.black45,
                              margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(28.w)),
                              ),
                              child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 20.w),
                              child: Column(
                                children: [
                                 Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('直接入库',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                ))),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            controller.judgeAddStockUnit(),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ) ,
                                 SizedBox(height: 32.w,),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text('采购数量',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 32.sp,
                                              ))),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          controller.judgePurchaseUnit(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                    EdgeInsets.only(top: 16.w, bottom: 24.w),
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () => controller.explainPurchaseAmount(),
                                          child:Row(
                                            children: [
                                              Text(
                                                '实付金额',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                ),
                                              ),
                                              LoadAssetImage(
                                                'ic_home_question',
                                                color: Colors.black45,
                                                width: 24.w,
                                                height: 24.w,
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        child: Text(
                                          DecimalUtil.formatAmount(((state.productSalesStatisticsDTO?.purchaseTotalAmount??Decimal.zero)
                                              -(state.productSalesStatisticsDTO?.purchaseRepaymentDiscountAmount??Decimal.zero)
                                              - (state.productSalesStatisticsDTO?.purchaseDiscountAmount??Decimal.zero)
                                              - (state.productSalesStatisticsDTO?.purchaseCreditAmount??Decimal.zero))),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32.w,),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text('采购赊账',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 32.sp,
                                              ))),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            DecimalUtil.formatAmount(
                                                state.productSalesStatisticsDTO
                                                    ?.purchaseCreditAmount
                                            ),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight:
                                                FontWeight.w500),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 16.w,),
                                 Container(
                                   alignment: Alignment.centerRight,
                                   child:    InkWell(
                                     onTap: () => Get.toNamed(RouteConfig.productCredit,
                                         arguments:{'id': state.productDTO?.id,
                                           'creditAmount':state.productSalesStatisticsDTO?.purchaseCreditAmount,
                                           'orderType':[OrderType.PURCHASE.value,OrderType.PURCHASE_RETURN.value]} ),
                                     child:  Container(
                                       padding: EdgeInsets.symmetric(vertical:8.w,horizontal: 16.w),
                                       decoration: BoxDecoration(
                                         border: Border.all(
                                           color: Colours.text_ccc,
                                           width: 1.0,
                                         ),
                                         borderRadius: BorderRadius.circular(12.0),
                                       ),
                                       child:
                                       Text(
                                         '赊账明细',
                                         style: TextStyle(
                                             color: Colours.text_999,
                                             fontSize: 32.sp,
                                             fontWeight: FontWeight.w500),
                                       ),
                                     ),
                                   ),
                                 ),

                                ],
                              ))),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 40.w, top: 32.w),
                            child: Text(
                              '费用收入情况',
                              style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28.w)),
                            ),
                            child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 32.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('销售地费用',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                ))),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              DecimalUtil.formatAmount(state.productSalesStatisticsDTO?.costDiscountTotalAmount),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 16.w),
                                      child:Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text('销售地收入',
                                                  style: TextStyle(
                                                    color: Colours.text_666,
                                                    fontSize: 32.sp,
                                                  ))),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                DecimalUtil.formatAmount(state.productSalesStatisticsDTO?.incomeDiscountTotalAmount??Decimal.zero),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )),
                                        ],
                                      ) ,
                                    ),
                                    SizedBox(height: 16.w,),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child:InkWell(
                                            onTap: () => Get.toNamed(RouteConfig.productCostDetail,arguments: {'discount':1,'productId': state.productDTO?.id}),//扣除，销售地支付
                                            child:  Container(
                                              padding: EdgeInsets.symmetric(vertical:8.w,horizontal: 16.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colours.text_ccc,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child:
                                              Text(
                                                  '查看明细',
                                                  style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 32.sp,
                                                      fontWeight: FontWeight.w500)),
                                            ))),
                                    Container(
                                      height: 1.w,
                                      color: Colours.divider,
                                      margin: EdgeInsets.symmetric(vertical: 32.w),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('产地费用',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                ))),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              DecimalUtil.formatAmount(state.productSalesStatisticsDTO?.costTotalAmount??Decimal.zero),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 16.w),
                                      child:Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text('产地收入',
                                                  style: TextStyle(
                                                    color: Colours.text_666,
                                                    fontSize: 32.sp,
                                                  ))),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                DecimalUtil.formatAmount(state.productSalesStatisticsDTO?.incomeTotalAmount??Decimal.zero),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )),
                                        ],
                                      ) ,
                                    ),
                                    SizedBox(height: 16.w,),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child:InkWell(
                                            onTap: () => Get.toNamed(RouteConfig.productCostDetail,arguments: {'discount':0, 'productId': state.productDTO?.id }),//不扣除,产地费用
                                            child:  Container(
                                              padding: EdgeInsets.symmetric(vertical:8.w,horizontal: 16.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colours.text_ccc,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child:
                                              Text(
                                                  '查看明细',
                                                  style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 32.sp,
                                                      fontWeight: FontWeight.w500)),
                                            )))
                                  ],
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 40.w, top: 32.w),
                            child: Text(
                              '利润',
                              style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child:
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                  ),
                                  child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical:32.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.profitAmount(),
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 8.w,),
                                          Text('利润',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                              )),
                                        ],
                                      )))),
                              Text('=' ,
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w500),),
                              Expanded(child:
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                  ),
                                  child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical:32.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            DecimalUtil.formatDecimalDefault(((state.productSalesStatisticsDTO?.salesTotalAmount??Decimal.zero)
                                                -(state.productSalesStatisticsDTO?.salesRepaymentDiscountAmount??Decimal.zero)
                                                - (state.productSalesStatisticsDTO?.salesDiscountAmount??Decimal.zero))),
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 8.w,),
                                          Text('销售',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                              )),
                                        ],
                                      ))) ),
                              Text('-',
                                style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.w500),),
                              Expanded(child:
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                  //margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                  ),
                                  child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical:32.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            DecimalUtil.formatDecimalDefault(((state.productSalesStatisticsDTO?.purchaseTotalAmount??Decimal.zero)
                                                -(state.productSalesStatisticsDTO?.purchaseRepaymentDiscountAmount??Decimal.zero)
                                                - (state.productSalesStatisticsDTO?.purchaseDiscountAmount??Decimal.zero))),
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 8.w,),
                                          Text('采购',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                              )),
                                        ],
                                      ))) ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 32.w),
                                child: Text('-',
                                  style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w500),) ,
                              ),
                              Expanded(child:
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                  ),
                                  child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical:32.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            DecimalUtil.formatDecimalDefault((state.productSalesStatisticsDTO?.costDiscountTotalAmount??Decimal.zero)
                                                +(state.productSalesStatisticsDTO?.costTotalAmount??Decimal.zero)),
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 8.w,),
                                          Text('费用',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                              )),
                                        ],
                                      )))),
                              Text('+',
                                style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.w500),),
                              Expanded(child:
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                  ),
                                  child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical:32.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            DecimalUtil.formatDecimalDefault((state.productSalesStatisticsDTO?.incomeDiscountTotalAmount??Decimal.zero)
                                                +(state.productSalesStatisticsDTO?.incomeTotalAmount??Decimal.zero)),
                                            style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 8.w,),
                                          Text('收入',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                              )),
                                        ],
                                      ))) ),
                            ],
                          ),
                          SizedBox(height: 32.w,)
                        ],
                      ))),
            ],
          ),
        )

        );
  }
}

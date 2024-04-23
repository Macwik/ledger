import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/share_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'sale_detail_controller.dart';

class SaleDetailView extends StatelessWidget {
  SaleDetailView({super.key});

  final GlobalKey salesDetailKey = GlobalKey();

  final controller = Get.find<SaleDetailController>();
  final state = Get.find<SaleDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: controller.title(),
        titleColor:  (state.orderType == OrderType.SALE) ||
          (state.orderType == OrderType.PURCHASE)|| (state.orderType == OrderType.ADD_STOCK)
          ? Colors.black87
          : Colors.red,
        actionWidget:
          GetBuilder<SaleDetailController>(
              id: 'sale_detail_delete',
              builder: (_) {
                return PermissionWidget(
                    permissionCode: (state.orderType == OrderType.SALE)
                        ? PermissionCode.sales_detail_delete_permission
                        : PermissionCode.purchase_detail_delete_permission,
                    child: Visibility(
                        visible: state.orderDetailDTO?.invalid ==
                            IsDeleted.NORMAL.value,
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: Colours.text_666),
                          onSelected: (String value) {
                            // 处理选择的菜单项
                            if (value == 'delete') {
                              // 执行删除操作
                              controller.toDeleteOrder();
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('强制作废'),
                              ),
                            ),
                          ],
                        )));
              })
      ),
      body: SingleChildScrollView(
          child: RepaintBoundary(
              key: salesDetailKey,
              child: Column(children: [

                Container(
                    padding: EdgeInsets.only(
                        right: 40.w, left: 40.w, top: 30.w, bottom: 20.w),
                    child: GetBuilder<SaleDetailController>(
                        id: 'order_payment',
                        builder: (_) {
                          return Column(
                            children: [
                              Container(child: Text('成交金额',
                                  style: TextStyle(
                                    color: Colours.text_999,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  )),),
                               Text(
                                   controller.orderTotalAmount(),
                                   style: TextStyle(
                                     color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colors.teal[400],
                                     fontSize: 48.sp,
                                     fontWeight: FontWeight.w600,
                                   )),
                              Offstage(
                                offstage:state.orderDetailDTO?.discountAmount == Decimal.zero,
                                child: Text(
                                  controller.countChange(),
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          );
                        })),
                  Card(
                  elevation: 6,
                  shadowColor: Colors.black45,
                  margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.w)),
                  ),
                  child: GetBuilder<SaleDetailController>(
                    id: 'order_detail',
                    builder: (_) {
                      return Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 40.w,
                              right: 40.w,
                              top: 30.w,
                              bottom: 20.w),
                          child: Column(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child:Text(
                                        state.orderDetailDTO?.customName ??
                                            '默认${state.orderType == OrderType.SALE ? '客户' : '供应商'}',
                                        style: TextStyle(
                                          color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_333,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  Expanded(
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        DateUtil.formatDefaultDate2(
                                            state.orderDetailDTO?.orderDate),
                                        style: TextStyle(
                                          color: Colours.text_999,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ))
                                ],
                              ),
                             Padding(
                                      padding: EdgeInsets.only(top: 16.w),
                                      child: Row(
                                        children: [
                                          Offstage(
                                              offstage: state.orderDetailDTO?.invalid != IsDeleted.DELETED.value,
                                              child: Text('已作废',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                          ),
                               Offstage(
                                 offstage: (state.orderDetailDTO?.invalid != IsDeleted.DELETED.value),
                                 child:Container(
                                            color: Colours.divider,
                                            height: 36.w,
                                            margin:
                                            EdgeInsets.only(right: 16.w, left: 16.w),
                                            width: 1.w,
                                          )),
                                          Offstage(
                                              offstage: (state.orderDetailDTO?.orderType != OrderType.SALE.value),
                                              child:Text(state.orderDetailDTO?.orderStatus == 1 ? '已结清' :'未结清',
                                     style: TextStyle(
                                       color:state.orderDetailDTO?.orderStatus == 1 ?Colours.text_ccc:Colors.cyan,
                                       fontSize: 32.sp,
                                       fontWeight: FontWeight.w400,
                                     ))),
                                        ],
                                      ),
                                    ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin:
                                EdgeInsets.only(top: 24.w, bottom: 24.w),
                                width: double.infinity,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '业务员',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    state.orderDetailDTO?.creatorName ?? '',
                                    style: TextStyle(
                                      color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 32.w,),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '实付金额',
                                      style: TextStyle(
                                        color: Colours.text_999,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      textAlign: TextAlign.right,
                                      controller.orderPayment(state
                                          .orderDetailDTO?.orderPaymentList),
                                      style: TextStyle(
                                        color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 32.w,),
                              Offstage(
                                  offstage: state.orderDetailDTO?.creditAmount == Decimal.zero,
                                  child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '本单赊账',
                                            style: TextStyle(
                                              color: Colours.text_999,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            (state.orderDetailDTO?.orderType ==OrderType.SALE_RETURN.value) ||
                                                (state.orderDetailDTO?.orderType ==OrderType.PURCHASE_RETURN.value)||
                                                (state.orderDetailDTO?.orderType ==OrderType.REFUND.value)
                                                ? DecimalUtil.formatNegativeAmount(state.orderDetailDTO?.creditAmount):DecimalUtil.formatAmount(state.orderDetailDTO?.creditAmount),
                                            style: TextStyle(
                                              color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colors.red[600],
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ))),
                              Offstage(
                                  offstage: state.orderDetailDTO?.creditAmount == Decimal.zero,
                                  child: SizedBox(height: 32.w,)),
                              Row(
                                children: [
                                  Text(
                                    '收银时间',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(DateUtil.formatDefaultDateTimeMinute(
                                      state.orderDetailDTO?.gmtCreate),
                                    style: TextStyle(
                                      color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),

                            ],
                          ));
                    })),
                Card(
                    elevation: 6,
                    shadowColor: Colors.black45,
                    margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28.w)),
                    ),
                    child: Column(
                      children: [
                        GetBuilder<SaleDetailController>(
                            id: 'product_detail',
                            builder: (_) {
                              return Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 40.w, top: 32.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.primary,
                                          height: 32.w,
                                          width: 8.w,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          margin: EdgeInsets.only(
                                            left: 12.w,
                                          ),
                                          child: Text(
                                            '货物详情',
                                            style: TextStyle(
                                                color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_666,
                                                fontSize: 34.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.orderDetailDTO
                                            ?.orderProductDetailList?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var orderProductDetail = state
                                          .orderDetailDTO
                                          ?.orderProductDetailList![index];
                                      return Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(
                                            left: 40.w, right: 40.w, top: 32.w),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        orderProductDetail
                                                                ?.productName ??
                                                            '',
                                                        style: TextStyle(
                                                          color:
                                                          state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_333,
                                                          fontSize: 32.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))),
                                                Expanded(
                                                  child: Text(
                                                      controller.productAmount(
                                                          orderProductDetail),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_666,
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 10.w),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  controller.judgeUnit(
                                                      orderProductDetail),
                                                  style: TextStyle(
                                                    color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_999,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ),
                                            Offstage(
                                              offstage: (orderProductDetail
                                                          ?.productPlace !=
                                                      null) ||
                                                  (orderProductDetail
                                                          ?.productStandard !=
                                                      null),
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10.w),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          orderProductDetail
                                                                  ?.productPlace ??
                                                              '',
                                                          style: TextStyle(
                                                            color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc:
                                                            Colours.text_999,
                                                            fontSize: 28.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          orderProductDetail
                                                                  ?.productStandard ??
                                                              '',
                                                          style: TextStyle(
                                                            color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_999,
                                                            fontSize: 28.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Offstage(
                                      offstage: state
                                              .orderDetailDTO
                                              ?.orderProductDetailList
                                              ?.length ==
                                          1,
                                      child: Container(
                                        color: Colours.divider,
                                        margin: EdgeInsets.only(top: 16.w),
                                        height: 2.w,
                                        width: double.infinity,
                                      )),
                                  Offstage(
                                      offstage: state.orderDetailDTO
                                              ?.orderProductDetailList?.length == 1,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: 40.w,
                                            left: 40.w,
                                            top: 30.w,
                                            bottom: 20.w),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '合计：',
                                              style: TextStyle(
                                                color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_999,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  (state.orderDetailDTO
                                                                  ?.orderType ==
                                                              OrderType.SALE_RETURN
                                                                  .value) ||
                                                          (state.orderDetailDTO
                                                                  ?.orderType ==
                                                              OrderType
                                                                  .PURCHASE_RETURN
                                                                  .value) ||
                                                          (state.orderDetailDTO
                                                                  ?.orderType ==
                                                              OrderType
                                                                  .REFUND.value)
                                                      ? DecimalUtil
                                                          .formatNegativeAmount(
                                                              state
                                                                  .orderDetailDTO
                                                                  ?.totalAmount)
                                                      : DecimalUtil.formatAmount(
                                                          state.orderDetailDTO
                                                              ?.totalAmount),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_666,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 24.w,
                                  )
                                ],
                              );
                            }),
                      ],
                    )),

                //收款情况
                GetBuilder<SaleDetailController>(
                    id: 'order_cost',
                    builder: (_) {
                      return Card(
                          elevation: 6,
                          shadowColor: Colors.black45,
                          margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(28.w)),
                          ),
                          child:Visibility(
                          visible: controller.state.orderDetailDTO?.externalOrderBaseDTOList?.isNotEmpty ?? false,
                          child: Column(
                                    children: [
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 40.w, top: 32.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.primary,
                                              height: 32.w,
                                              width: 8.w,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              margin: EdgeInsets.only(
                                                left: 12.w,
                                              ),
                                              child: Text(
                                                '费用详情',
                                                style: TextStyle(
                                                    color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc:Colours.text_666,
                                                    fontSize: 34.sp,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical: 32.w),
                                      child: InkWell(
                                          onTap: () => Get.toNamed(
                                                  RouteConfig
                                                      .dailyAccountCostDetail,
                                                  arguments: {
                                                    'externalOrderBase': controller
                                                        .state
                                                        .orderDetailDTO
                                                        ?.externalOrderBaseDTOList
                                                  }),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '费用金额',
                                                    style: TextStyle(
                                                      color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc:Colours.text_666,
                                                      fontSize: 32.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      controller
                                                          .totalCostAmount(),
                                                      textAlign:
                                                      TextAlign.right,
                                                      style: TextStyle(
                                                        color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc:Colours.text_666,
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.w,
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                child: Container(
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
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                              ),
                                            ],
                                          )))
                                    ],
                                  )
                           ));
                    }),
                GetBuilder<SaleDetailController>(
                    id: 'order_detail',
                    builder: (_) {
                      return Visibility(
                        visible: state.orderDetailDTO?.remark?.isNotEmpty??false,
                        child: Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28.w)),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 40.w,horizontal: 32.w),
                              child: LimitedBox(
                                  maxHeight: 200.0, // 设置容器的最大高度
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '备注',
                                          style: TextStyle(
                                            color:state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc: Colours.text_666,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            softWrap: true, // 允许文本自动换行
                                            state.orderDetailDTO
                                                ?.remark ??
                                                '',
                                            style: TextStyle(
                                              color: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value? Colours.text_ccc:Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ],
                                  )),
                            )),
                      );}),
               Container(height: 100.w,)
              ]))),
      //底部按钮
      floatingActionButton: PermissionWidget(
          permissionCode: (state.orderType == OrderType.SALE)
              ? PermissionCode.sales_detail_share_permission
              : PermissionCode.purchase_detail_share_permission,
          child: Builder(builder: (BuildContext buildContext) {
            return ElevatedBtn(
              size: Size(double.infinity, 90.w),
              onPressed: () {
                ShareUtils.onSharePlusShare(buildContext, salesDetailKey);
              },
              radius: 15.w,
              backgroundColor: Colours.primary,
              text: '分享单据',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

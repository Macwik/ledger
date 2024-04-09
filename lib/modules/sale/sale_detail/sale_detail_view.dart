import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
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
                GetBuilder<SaleDetailController>(
                    id: 'sale_detail_title',
                    builder: (_){
                  return Container(
                    padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          color: Colours.primary,
                          height: 38.w,
                          width: 8.w,
                        ),
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 6.w,right:32.w ),
                          child: Text(
                            '货物明细',
                            style: TextStyle(
                                color: Colours.text_666,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Visibility(
                            visible: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value,
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
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text('已作废',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )),
                      ],
                    ),
                  );
                }),
                GetBuilder<SaleDetailController>(
                    id: 'product_detail',
                    builder: (_) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Container(
                          height: 1.w,
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount: state.orderDetailDTO?.orderProductDetailList
                                ?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var orderProductDetail = state
                              .orderDetailDTO?.orderProductDetailList![index];
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            orderProductDetail?.productName ??
                                                '',
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                    Expanded(
                                      child: Text(
                                          controller.productAmount(
                                              orderProductDetail),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.w),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      controller.judgeUnit(orderProductDetail),
                                      style: TextStyle(
                                        color: Colours.text_999,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                Offstage(
                                  offstage:  (orderProductDetail?.productPlace==null)||( orderProductDetail?.productStandard==null),
                                  child:  Container(
                                      padding: EdgeInsets.only(top: 10.w),
                                      child: Row(
                                        children: [
                                          Text(
                                              orderProductDetail?.productPlace ??
                                                  '',
                                              style: TextStyle(
                                                color: Colours.text_999,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              orderProductDetail
                                                  ?.productStandard ??
                                                  '',
                                              style: TextStyle(
                                                color: Colours.text_999,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
                 Column(
                  children: [
                    Container(
                      color: Colors.white12,
                      height: 4.w,
                      width: double.infinity,
                    ),
                    GetBuilder<SaleDetailController>(
                        id: 'order_payment',
                        builder: (_) {
                          return   Offstage(
                              offstage: state.orderDetailDTO?.orderProductDetailList?.length ==1,
                              child:Container(
                            padding: EdgeInsets.only(
                                right: 40.w,
                                left: 40.w,
                                top: 30.w,
                                bottom: 20.w),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '合计：',
                                  style: TextStyle(
                                    color: Colours.text_999,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text( (state.orderDetailDTO?.orderType ==OrderType.SALE_RETURN.value) ||
                                        (state.orderDetailDTO?.orderType ==OrderType.PURCHASE_RETURN.value)||
                                        (state.orderDetailDTO?.orderType ==OrderType.REFUND.value)
                                     ? DecimalUtil.formatNegativeAmount(state.orderDetailDTO?.totalAmount):DecimalUtil.formatAmount(state.orderDetailDTO?.totalAmount),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                        }),
                    Container(
                      color: Colors.white12,
                      height: 24.w,
                      width: double.infinity,
                    )
                  ],
                ),
                //收款情况
                Container(
                    padding: EdgeInsets.only(
                        right: 40.w, left: 40.w, top: 30.w, bottom: 20.w),
                    color: Colors.white,
                    child: GetBuilder<SaleDetailController>(
                        id: 'order_payment',
                        builder: (_) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    color: Colours.primary,
                                    height: 38.w,
                                    width: 8.w,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      '付款信息',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32.w,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '实付金额',
                                      style: TextStyle(
                                        color: Colours.text_666,
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
                                        color: Colours.text_333,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(top: 16, bottom: 16),
                                width: double.infinity,
                              ),
                              Visibility(
                                  visible: state.orderDetailDTO?.creditAmount !=
                                      Decimal.zero,
                                  child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '赊账：',
                                            style: TextStyle(
                                              color: Colors.red[600],
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
                                              color: Colors.red[600],
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ))),
                              Visibility(
                                  visible: state.orderDetailDTO?.creditAmount !=
                                      Decimal.zero,
                                  child: Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  )),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    '抹零金额',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                        controller.countChange(),
                                    textAlign: TextAlign.right,
                                        // (state.orderDetailDTO?.orderType ==OrderType.SALE_RETURN.value) ||
                                        //     (state.orderDetailDTO?.orderType ==OrderType.PURCHASE_RETURN.value)||
                                        //     (state.orderDetailDTO?.orderType ==OrderType.REFUND.value)
                                        //     ?DecimalUtil.formatNegativeAmount(state.orderDetailDTO?.discountAmount):DecimalUtil.formatAmount(state.orderDetailDTO?.discountAmount),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                                ],
                              ),
                            ],
                          );
                        })),
                GetBuilder<SaleDetailController>(
                    id: 'order_cost',
                    builder: (_) {
                      return Visibility(
                          visible: controller.state.orderDetailDTO
                                  ?.externalOrderBaseDTOList?.isNotEmpty ??
                              false,
                          child: Column(
                            children: [
                              Container(
                                height: 32.w,
                                color: Colors.white12,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40.w,
                                    vertical: 30.w,
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            color: Colours.primary,
                                            height: 38.w,
                                            width: 8.w,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            margin: EdgeInsets.only(left: 6),
                                            child: Text(
                                              '费用情况',
                                              style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 36.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 32.w,
                                      ),
                                      InkWell(
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
                                                      color: Colours.text_666,
                                                      fontSize: 32.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  // GetBuilder<
                                                  //         SaleDetailController>(
                                                  //     id: 'sales_detail_purchase_cost',
                                                  //     builder: (_) {
                                                  //       return ;
                                                  //     }),
                                                  Expanded(
                                                    child: Text(
                                                      controller
                                                          .totalCostAmount(),
                                                      textAlign:
                                                      TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colours
                                                            .text_666,
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.w,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '费用明细',
                                                    style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w),
                                                    child: LoadAssetImage(
                                                      'common/arrow_right',
                                                      width: 25.w,
                                                      color: Colours.text_999,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ))
                                    ],
                                  ))
                            ],
                          ));
                    }),
                Column(
                  children: [
                    Container(
                      height: 32.w,
                      color: Colors.white12,
                    ),
                    GetBuilder<SaleDetailController>(
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
                                          child: Text(
                                        '日期',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                      Expanded(
                                          child: Text(
                                        textAlign: TextAlign.right,
                                        DateUtil.formatDefaultDate2(
                                            state.orderDetailDTO?.orderDate),
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ))
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (state.orderType == OrderType.SALE)||(state.orderType == OrderType.SALE_RETURN)||(state.orderType == OrderType.REFUND)
                                            ? '客户'
                                            : '供应商',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.orderDetailDTO?.customName ??
                                            '默认${state.orderType == OrderType.SALE ? '客户' : '供应商'}',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '业务员',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.orderDetailDTO?.creatorName ?? '',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 100.w),
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
                                                  color: Colours.text_666,
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
                                                    color: Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          ],
                                        )),
                                  ),
                                ],
                              ));
                        }),
                  ],
                ),
              ]))),
      //底部按钮
      floatingActionButton: PermissionWidget(
          permissionCode: (state.orderType == OrderType.SALE)
              ? PermissionCode.sales_detail_share_permission
              : PermissionCode.purchase_detail_share_permission,
          child: Builder(builder: (BuildContext buildContext) {
            return ElevatedBtn(
              margin: EdgeInsets.only(top: 80.w),
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

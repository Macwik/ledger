import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'repayment_detail_controller.dart';

class RepaymentDetailView extends StatelessWidget {
  RepaymentDetailView({super.key});

  final controller = Get.find<RepaymentDetailController>();
  final state = Get.find<RepaymentDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '收款单详情',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          GetBuilder<RepaymentDetailController>(
              id: 'repayment_title',
              builder: (_) {
                return  PermissionWidget(
                    permissionCode: PermissionCode.repayment_detail_delete_permission,
                    child:Visibility(
                  visible: state.repaymentDetailDTO?.invalid ==
                      IsDeleted.NORMAL.value,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.white),
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
                  ),
                ));
              })
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //第一部分，客户
          SliverToBoxAdapter(
              child: GetBuilder<RepaymentDetailController>(
                  id: 'custom_detail',
                  builder: (_) {
                    return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 40.w, right: 40.w, top: 30.w, bottom: 30.w),
                        child: Column(
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child:  Row (
                                    children: [
                                      Text(
                                        '* ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                         '客户',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        state.repaymentDetailDTO?.invalid ==
                                            IsDeleted.DELETED.value,
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
                                      child: Text('已作废',
                                          style: TextStyle(
                                            color: Colors.red,
                                          fontSize: 32.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    )),
                                Expanded(
                                    child: Text(
                                  state.repaymentDetailDTO?.customName ?? '',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colours.text_333,
                                 fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                            //剩余欠款
                          ],
                        ));
                  })),
          //第二部分，收款信息
          SliverToBoxAdapter(
              child: Container(
            width: double.infinity,
            color: Colors.white12,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40.w),
            height: 70.w,
            child: Text(
              '收款信息',
              style: TextStyle(color: Colours.text_ccc),
            ),
          )),
          GetBuilder<RepaymentDetailController>(
              init: controller,
              id: 'payment_detail',
              builder: (_) {
                return state.repaymentDetailDTO?.paymentDTOList?.isEmpty ?? true
                    ? SliverToBoxAdapter(
                        child: EmptyLayout(hintText: '什么都没有'.tr))
                    : SliverList.separated(
                        itemBuilder: (context, index) {
                          var repaymentDetailPay =
                              state.repaymentDetailDTO?.paymentDTOList![index];
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 20.w),
                            child: Row(
                              children: [
                                Text(
                                    repaymentDetailPay?.paymentMethodName ?? '',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                   fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const Spacer(),
                                Text(
                                    DecimalUtil.formatAmount(repaymentDetailPay?.paymentAmount),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                   fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 2.w,
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount:
                            state.repaymentDetailDTO?.paymentDTOList?.length ??
                                0,
                      );
              }),
          SliverToBoxAdapter(
              child: GetBuilder<RepaymentDetailController>(
                  init: controller,
                  id: 'repayment_detail',
                  builder: (_) {
                    return Visibility(
                      maintainSize: false,
                      visible: state.repaymentDetailDTO?.discountAmount != Decimal.zero,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 40.w, right: 40.w,bottom: 20.w),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Text('优惠金额',
                                style: TextStyle(
                                  color: Colours.text_666,
                               fontSize: 32.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            const Spacer(),
                            Text(
                                DecimalUtil.formatAmount(state.repaymentDetailDTO?.discountAmount),
                                style: TextStyle(
                                  color: Colours.text_333,
                               fontSize: 32.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    );
                  })),
          GetBuilder<RepaymentDetailController>(
                  init: controller,
                  id: 'order_binding',
                  builder: (_) {
                    return SliverToBoxAdapter(
                        child:Visibility(
                          maintainSize: false,
                        visible:  state.repaymentDetailDTO?.repaymentBindOrderList?.isEmpty == false,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white12,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 40.w),
                          height: 70.w,
                          child: Text(
                            '按单结算情况',
                            style: TextStyle(color: Colours.text_ccc),
                          ),
                        ),));
                  }),
          SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40.w),
                height: 20.w,
              )),
          GetBuilder<RepaymentDetailController>(
              init: controller,
              id: 'order_binding',
              builder: (_) {
                return state.repaymentDetailDTO?.repaymentBindOrderList
                            ?.isEmpty ?? true
                    ? SliverToBoxAdapter(
                        child: Visibility(visible: false, child: Container()))
                    : SliverList.builder(
                        itemBuilder: (context, index) {
                          var repaymentBindOrder = state.repaymentDetailDTO
                              ?.repaymentBindOrderList![index];
                          return Container(
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colours.divider, width: 1),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10.w),
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10.w),
                              child:  Column(
                                  children: [
                                    Container(
                                      alignment:Alignment.centerLeft  ,
                                      child: Text(
                                          repaymentBindOrder?.creditType ==
                                              OrderType.SALE.value
                                              ? TextUtil.listToStr(
                                              repaymentBindOrder
                                                  ?.productNameList)
                                              : repaymentBindOrder
                                              ?.creatorName ??
                                              '',
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  SizedBox(height: 16.w,),
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                child:Text('本单还款：',
                                                style: TextStyle(
                                                  color: Colours.text_ccc,
                                                  fontSize: 26.sp,
                                                  fontWeight: FontWeight.w400,
                                                )) ),
                                            Expanded(
                                              child: Text(
                                              DecimalUtil.formatAmount(repaymentBindOrder?.repaymentAmount),
                                                style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 26.sp,
                                                  fontWeight: FontWeight.w400,
                                                )),)
                                          ],
                                        )),
                                        Expanded(child:  InkWell(
                                          onTap: () => controller.toOrderDetail(repaymentBindOrder!),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      textAlign: TextAlign.right,
                                                      controller.creditType(repaymentBindOrder?.creditType),
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ))),
                                              Visibility(
                                                  visible: repaymentBindOrder
                                                      ?.creditType !=
                                                      OrderType.CREDIT.value,
                                                  child:    Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: LoadAssetImage(
                                                      'common/arrow_right',
                                                      width: 25.w,
                                                      color: Colours.text_999,
                                                    ),
                                                  ),),
                                            ],
                                          ),
                                        ),)
                                      ],
                                    ),
                                  ],
                                ),

                            ),
                          );
                        },
                        itemCount: state.repaymentDetailDTO
                                ?.repaymentBindOrderList?.length ??
                            0,
                      );
              }),
          SliverToBoxAdapter(
              child: Container(
            width: double.infinity,
            color: Colors.white12,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40.w),
            height: 70.w,
            child: Text(
              '单据信息',
              style: TextStyle(color: Colours.text_ccc),
            ),
          )),
          SliverToBoxAdapter(
              child: GetBuilder<RepaymentDetailController>(
                  id: 'repayment_order',
                  builder: (_) {
                    return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 40.w, right: 40.w, top: 30.w, bottom: 20.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '日期',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                 fontSize: 32.sp,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  DateUtil.formatDefaultDate2(
                                      state.repaymentDetailDTO?.repaymentDate),
                                  style: TextStyle(
                                    color: Colours.text_333,
                                 fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ), //日期
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              width: double.infinity,
                            ),
                            Row(
                              children: [
                                Text(
                                  '业务员',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                 fontSize: 32.sp,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  state.repaymentDetailDTO?.creatorName ?? '',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                 fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ), //业务员
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 16, bottom: 8),
                              width: double.infinity,
                            ),
                            Row(
                              children: [
                                Text(
                                  '是否按单还款',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                 fontSize: 32.sp,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                const Spacer(),
                                Checkbox(
                                    value: state.repaymentDetailDTO
                                            ?.settlementType ==
                                        1,
                                    activeColor: Colours.primary,
                                    onChanged: (value) {})
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 8, bottom: 16),
                              width: double.infinity,
                            ),
                            LimitedBox(
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
                                          state.repaymentDetailDTO?.remark ?? '',
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ],
                                )), //备注
                          ],
                        ));
                  })),
        ],
      ),
    );
  }
}

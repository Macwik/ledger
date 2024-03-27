import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/share_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'cost_detail_controller.dart';

class CostDetailView extends StatelessWidget {
  final GlobalKey costDetailKey = GlobalKey();

  CostDetailView({super.key});

  final controller = Get.find<CostDetailController>();
  final state = Get.find<CostDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: state.costIncomeOrderDTO?.orderType == CostOrderType.COST.value
            ? '费用详情'
            : '收入详情',
        actionWidget: GetBuilder<CostDetailController>(
            id: 'cost_detail_title',
            builder: (_) {
              return PermissionWidget(
                  permissionCode: PermissionCode.cost_detail_delete_permission,
                  child: Visibility(
                      visible: state.costIncomeDetailDTO?.invalid ==
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
            },
          ),
      ),
      body:
          //第一部分:此单合计
          GetBuilder<CostDetailController>(
              id: 'cost_detail',
              builder: (_) {
                return RepaintBoundary(
                    key: costDetailKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(40.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: Text(
                                    '合计：',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        state.costIncomeDetailDTO?.invalid ==
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
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    )),
                                Expanded(
                                  child: Text(
                                    DecimalUtil.formatAmount(
                                        state.costIncomeDetailDTO?.totalAmount),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color:
                                          state.costIncomeDetailDTO?.invalid ==
                                                  IsDeleted.DELETED.value
                                              ? Colours.text_ccc
                                              : Colors.orange,
                                      fontSize: 38.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          color: state.costIncomeDetailDTO?.invalid ==
                                  IsDeleted.DELETED.value
                              ? Colours.text_ccc
                              : Colors.orange,
                          height: 2.w,
                          width: double.infinity,
                        ),
                        //第二部分费用
                        Container(
                          padding: EdgeInsets.all(40.w),
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 32.w),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colours.primary,
                                      height: 32.w,
                                      width: 8.w,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(left: 16.w),
                                      child: Text(
                                        state.costIncomeDetailDTO?.orderType ==
                                                CostOrderType.COST.value
                                            ? '费用明细'
                                            : '收入明细',
                                        style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 36.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: 200.w,
                                      child: Text(
                                        state.costIncomeDetailDTO
                                                ?.costIncomeName ??
                                            '',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  Expanded(
                                      child: Text(
                                    textAlign: TextAlign.right,
                                    DecimalUtil.formatAmount(
                                        state.costIncomeDetailDTO?.totalAmount),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 32.w,
                          color: Colors.white12,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(40.w),
                          child: Row(
                            children: [
                              Container(
                                color: Colours.primary,
                                height: 32.w,
                                width: 8.w,
                              ),
                              Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(left: 16.w),
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
                        ),
                        state.costIncomeDetailDTO?.paymentDTOList?.isEmpty ??
                                true
                            ? EmptyLayout(hintText: '什么都没有')
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  var costRepayment = state.costIncomeDetailDTO
                                      ?.paymentDTOList![index];
                                  return Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        right: 40.w,
                                        left: 40.w,
                                        top: 8.w,
                                        bottom: 32.w),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text(
                                          costRepayment?.paymentMethodName ??
                                              '',
                                          style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            DecimalUtil.formatAmount(
                                                costRepayment?.paymentAmount),
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: state.costIncomeDetailDTO
                                        ?.paymentDTOList?.length ??
                                    0,
                                separatorBuilder: (context, index) => Container(
                                  height: 1.w,
                                  color: Colours.divider,
                                  width: double.infinity,
                                ),
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white12,
                          padding: EdgeInsets.only(
                              bottom: 16.w, top: 16.w, left: 40.w),
                          child: Text(
                            '单据详情',
                            style: TextStyle(
                                color: Colours.text_ccc,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, bottom: 40.w),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32.w,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    state.costIncomeDetailDTO?.orderType ==
                                            CostOrderType.COST.value
                                        ? '哪里支付'
                                        : '哪里收取',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                  Expanded(
                                      child: Text(
                                    state.costIncomeDetailDTO?.discount == 1
                                        ? '销售地'
                                        : '产地',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.symmetric(vertical: 32.w),
                                width: double.infinity,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    '绑定采购单',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () => controller.toSaleDetail(),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                state.costIncomeDetailDTO
                                                            ?.salesOrderNo ==
                                                        null
                                                    ? '无'
                                                    : '查看详情',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Visibility(
                                                visible: state
                                                            .costIncomeDetailDTO
                                                            ?.salesOrderNo ==
                                                        null
                                                    ? false
                                                    : true,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: LoadAssetImage(
                                                    'common/arrow_right',
                                                    width: 25.w,
                                                    color: Colours.text_999,
                                                  ),
                                                ),
                                              )
                                            ]),
                                      )),
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.symmetric(vertical: 32.w),
                                width: double.infinity,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    '绑定货物',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.costIncomeDetailDTO?.salesOrderNo ==
                                              null
                                          ? '无'
                                          : TextUtil.listToStr(state
                                              .costIncomeDetailDTO
                                              ?.productNameList),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white12,
                          height: 32.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(40.w),
                            margin: EdgeInsets.only(bottom: 100.w),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '日期',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        DateUtil.formatDefaultDate2(state
                                            .costIncomeDetailDTO?.orderDate),
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 32.w),
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
                                        state.costIncomeDetailDTO
                                                ?.creatorName ??
                                            '',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 32.w),
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
                                                state.costIncomeDetailDTO
                                                        ?.remark ??
                                                    '-',
                                                style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ],
                                      )),
                                ],
                              ),
                            )),
                      ],
                    )));
              }),
      //底部按钮
      floatingActionButton: GetBuilder<CostDetailController>(
          id: 'cost_bill_btn',
          builder: (_) {
            return PermissionWidget(
                permissionCode: PermissionCode.cost_detail_share_permission,
                child: Container(
                  width: double.infinity,
                  height: 100.w,
                  child: ElevatedBtn(
                    size: Size(double.infinity, 100.w),
                    radius: 15.w,
                    backgroundColor: Colours.primary,
                    text: '分享单据',
                    onPressed: () {
                      ShareUtils.onSharePlusShare(context, costDetailKey);
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

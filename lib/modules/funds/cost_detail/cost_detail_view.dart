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
        title: state.orderType == CostOrderType.COST.value
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
                                padding: EdgeInsets.only(
                                    right: 40.w, left: 40.w, top: 30.w, bottom: 20.w),
                                child: Column(
                                  children: [
                                    Container(child: Text(state.orderType == CostOrderType.COST.value
                                        ? '实付金额'
                                        : '实收金额',
                                        style: TextStyle(
                                          color: Colours.text_999,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        )),),
                                    Text(
                                        DecimalUtil.formatAmount(
                                            state.costIncomeDetailDTO?.totalAmount),
                                        style: TextStyle(
                                          color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                          ?Colours.text_ccc
                                          :Colors.teal[400],
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                )),
                        //第二部分费用
                        Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28.w)),
                            ),
                            child:  Container(
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
                                                   state.costIncomeDetailDTO?.costIncomeName ?? '',
                                                    style: TextStyle(
                                                      color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                          ?Colours.text_ccc
                                                          :Colours.text_333,
                                                      fontSize: 36.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )),
                                              Expanded(
                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    DateUtil.formatDefaultDate2(state
                                                        .costIncomeDetailDTO?.orderDate),
                                                    style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 30.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 16.w),
                                            alignment: Alignment.centerLeft,
                                            child: Offstage(
                                                  offstage: state.costIncomeDetailDTO?.invalid != IsDeleted.DELETED.value,
                                                  child: Text('已作废',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 32.sp,
                                                        fontWeight: FontWeight.w400,
                                                      )),
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
                                                state.costIncomeDetailDTO?.creatorName ?? '',
                                                style: TextStyle(
                                                  color: state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                      ?Colours.text_ccc
                                                      : Colours.text_333,
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
                                                  '支付方式',
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
                                                  controller.orderPayment(state.costIncomeDetailDTO?.paymentDTOList),
                                                  style: TextStyle(
                                                    color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                        ?Colours.text_ccc
                                                        :Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 32.w,),
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
                                                  state.costIncomeDetailDTO?.gmtCreate),
                                                style: TextStyle(
                                                  color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                      ?Colours.text_ccc
                                                      :Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),

                                        ],
                                      ))),


                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 40.w, top: 32.w),
                          child: Text(
                            '其他情况',
                            style: TextStyle(
                                color: Colours.text_ccc,
                                fontSize: 30.sp,
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
                            child:
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
                                      color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                          ?Colours.text_ccc
                                          : Colours.text_666,
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
                                      color:   state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                          ?Colours.text_ccc
                                          :Colours.text_333,
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
                                      color:   state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                          ?Colours.text_ccc
                                          :Colours.text_666,
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
                                                state.costIncomeDetailDTO?.salesOrderNo == null
                                                    ? '无'
                                                    : '查看详情',
                                                style: TextStyle(
                                                  color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                      ?Colours.text_ccc
                                                      :Colours.text_666,
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
                                                    color:   state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                        ?Colours.text_ccc
                                                        :Colours.text_999,
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
                                      color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                          ?Colours.text_ccc
                                          : Colours.text_666,
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
                                        color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                            ?Colours.text_ccc
                                            : Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                        Visibility(
                            visible: state.costIncomeDetailDTO?.remark?.isNotEmpty??false,
                            child:  Card(
                                elevation: 6,
                                shadowColor: Colors.black45,
                                margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(28.w)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 32.w),
                                  child:  LimitedBox(
                                      maxHeight: 200.0, // 设置容器的最大高度
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '备注',
                                              style: TextStyle(
                                                color:  state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                    ?Colours.text_ccc
                                                    : Colours.text_666,
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
                                                  color:   state.costIncomeDetailDTO?.invalid == IsDeleted.DELETED.value
                                                      ?Colours.text_ccc
                                                      :Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ],
                                      )),
                                )))
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

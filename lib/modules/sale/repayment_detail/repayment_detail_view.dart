import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/custom_type.dart';
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
      appBar: TitleBar(
        title: '收款单详情',
        actionWidget:
          GetBuilder<RepaymentDetailController>(
              id: 'repayment_title',
              builder: (_) {
                return  PermissionWidget(
                    permissionCode: state.customType == CustomType.CUSTOM.value
                        ? PermissionCode.repayment_detail_delete_permission
                        :PermissionCode.supplier_custom_repayment_detail_delete_permission,
                    child:Visibility(
                  visible: state.repaymentDetailDTO?.invalid ==
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
                  ),
                ));
              })
      ),
      // Container(
      //   color: Colors.white,
      //   padding: EdgeInsets.only(
      //       left: 40.w, right: 40.w, top: 30.w, bottom: 30.w),
      //   child: Column(
      //     children: [
      //       Flex(
      //         direction: Axis.horizontal,
      //         children: [
      //           Expanded(
      //               child:  Row (
      //               children: [
      //                 Text(
      //                   '* ',
      //                   style: TextStyle(color: Colors.red),
      //                 ),
      //                 Text(
      //                    state.customType == CustomType.CUSTOM.value?'客户':'供应商',
      //                   style: TextStyle(
      //                     color: Colours.text_666,
      //                     fontSize: 32.sp,
      //                     fontWeight: FontWeight.w400,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Visibility(
      //               visible:
      //                   state.repaymentDetailDTO?.invalid ==
      //                       IsDeleted.DELETED.value,
      //               child: Container(
      //                 padding: EdgeInsets.only(
      //                     top: 2.w,
      //                     bottom: 2.w,
      //                     left: 4.w,
      //                     right: 4.w),
      //                 decoration: BoxDecoration(
      //                   border: Border.all(
      //                     color: Colors.red,
      //                     width: 1.0,
      //                   ),
      //                   borderRadius:
      //                       BorderRadius.circular(8.0),
      //                 ),
      //                 child: Text('已作废',
      //                     style: TextStyle(
      //                       color: Colors.red,
      //                     fontSize: 32.sp,
      //                       fontWeight: FontWeight.w500,
      //                     )),
      //               )),
      //           Expanded(
      //               child: Text(
      //             state.repaymentDetailDTO?.customName ?? '',
      //             textAlign: TextAlign.right,
      //             style: TextStyle(
      //               color: Colours.text_333,
      //            fontSize: 32.sp,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           )),
      //         ],
      //       ),
      //       //剩余欠款
      //     ],
      //   ));
      body: SingleChildScrollView(
          child:Column(
        children: [
          //第一部分，客户
           GetBuilder<RepaymentDetailController>(
                  id: 'repayment_order',
                  builder: (_) {
                    return Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                right: 40.w, left: 40.w, top: 30.w, bottom: 20.w),
                            child: Column(
                              children: [
                                Container(child: Text('成交金额',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    )),),
                                Text(DecimalUtil.formatAmount((state.repaymentDetailDTO?.totalAmount??Decimal.zero)-(state.repaymentDetailDTO?.discountAmount??Decimal.zero)),
                                    style: TextStyle(
                                      color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colors.teal[400],
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Offstage(
                                  offstage:state.repaymentDetailDTO?.discountAmount == Decimal.zero,
                                  child: Text(
                    '(应付总额${DecimalUtil.formatAmount(state.repaymentDetailDTO?.totalAmount)}-抹零${DecimalUtil.formatAmount(state.repaymentDetailDTO?.discountAmount)})',
                                    style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )),
                        Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(
                                left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(28.w)),
                            ),
                            child: Container(
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
                                              state.repaymentDetailDTO?.customName ??'',
                                              style: TextStyle(
                                                color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
                                                fontSize: 36.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                        Expanded(
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              DateUtil.formatDefaultDate2(
                                                  state.repaymentDetailDTO?.repaymentDate),
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
                                      child: Offstage(
                                            offstage: state.repaymentDetailDTO?.invalid != IsDeleted.DELETED.value,
                                            child: Text('已作废',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w400,
                                                )))),
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
                                          state.repaymentDetailDTO?.creatorName ?? '',
                                          style: TextStyle(
                                            color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
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
                                            controller.orderPayment(),
                                            style: TextStyle(
                                              color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
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
                                          '还款方式',
                                          style: TextStyle(
                                            color: Colours.text_999,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text( state.repaymentDetailDTO?.settlementType == 1?'按单还款':'直接还款',
                                          style: TextStyle(
                                            color:state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc : Colours.text_333,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ))
                        ),
                      Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 40.w, top: 32.w,bottom: 32.w),
                            child: Text(
                                  '还款详情',
                              style: TextStyle(
                                  color:state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc : Colours.text_333,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                                ),
                          ),
                        state.repaymentDetailDTO?.repaymentBindOrderList?.isEmpty ?? true
                            ? Visibility(visible: false, child: Container())
                            :  Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(
                                left: 24.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(28.w)),
                            ),
                            child:ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var repaymentBindOrder = state.repaymentDetailDTO?.repaymentBindOrderList![index];
                            return Container(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10.w),
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10.w),
                                child:  Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Text(
                                            (repaymentBindOrder?.creditType == OrderType.CREDIT.value)
                                                ? repaymentBindOrder?.creatorName ?? ''
                                                : TextUtil.listToStr(repaymentBindOrder?.productNameList),
                                            style: TextStyle(
                                              color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                        Text(
                                            DateUtil.formatDefaultDate2(repaymentBindOrder?.gmtCreate),
                                            style: TextStyle(
                                              color: Colours.text_ccc,
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 16.w,),
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                            child: Row(
                                              children: [
                                                Text('本单还款：',
                                                        style: TextStyle(
                                                          color: Colours.text_ccc,
                                                          fontSize: 30.sp,
                                                          fontWeight: FontWeight.w400,
                                                        )),
                                                Expanded(
                                                  child: Text(
                                                      DecimalUtil.formatAmount(repaymentBindOrder?.repaymentAmount),
                                                      style: TextStyle(
                                                        color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
                                                        fontSize: 30.sp,
                                                        fontWeight: FontWeight.w500,
                                                      )),)
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child:  InkWell(
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
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ))),
                                              Visibility(
                                                visible: repaymentBindOrder
                                                    ?.creditType !=
                                                    OrderType.CREDIT.value,
                                                child:    Padding(
                                                  padding: EdgeInsets.only(left: 8.w),
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
                        )),
                        Visibility(
                            visible: state.repaymentDetailDTO?.remark?.isNotEmpty??false,
                            child:
                            Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(
                                left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(28.w)),
                            ),
                            child:Container(
                              padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 40.w),
                            child:LimitedBox(
                            maxHeight: 200.0, // 设置容器的最大高度
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '备注',
                                    style: TextStyle(
                                      color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_666,
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
                                        color: state.repaymentDetailDTO?.invalid == IsDeleted.DELETED.value ? Colours.text_ccc :Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                              ],
                            ))))),
                        SizedBox(height: 24.w,)
                      ],
                    );
                  }),

        ],
      )),
    );
  }
}

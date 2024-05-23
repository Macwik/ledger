import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';

import 'choose_repayment_order_controller.dart';

class ChooseRepaymentOrderView extends StatelessWidget {
  ChooseRepaymentOrderView({super.key});

  final controller = Get.find<ChooseRepaymentOrderController>();
  final state = Get.find<ChooseRepaymentOrderController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: '选择欠款单'.tr,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  GetBuilder<ChooseRepaymentOrderController>(
                      id: 'name',
                      builder: (_) {
                        return Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 30, bottom: 10),
                          child: InkWell(
                            child: Row(
                              children: [
                                Text(state.customDTO?.customName ?? '',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Expanded(child:
                                Text(
                                    '¥${state.customDTO?.creditAmount??''}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colours.primary,
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w700,
                                    ))),
                              ],
                            ),
                          ),
                        );
                      }),
                   GetBuilder<ChooseRepaymentOrderController>(
                          id: 'date_range',
                          builder: (_)=> InkWell(
                            onTap: () => controller
                                .pickerSalesProductDateRange(context),
                            child:Column(
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
                           ,))
                ],
              )),
        GetBuilder<ChooseRepaymentOrderController>(
                  id: 'repayment_bill',
                  builder: (_) {
                    return Expanded(
                        child:state.items.isEmpty
                        ? EmptyLayout(hintText: '什么都没有')
                        :ListView.separated(
                          itemBuilder: (context, index) {
                            var customCreditDTO = state.items[index];
                            return Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    right: 20, top: 10, bottom: 10),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Center(
                                      child: Container(
                                        child: Checkbox(
                                          value: controller.judgeIsSelect(customCreditDTO.id!),
                                          onChanged: (bool? selected) {
                                            controller.addToSelected(
                                                selected, customCreditDTO);
                                          },
                                          activeColor: Colours.primary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(bottom: 16.w),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                DateUtil.formatDefaultDate2(
                                                    customCreditDTO.gmtCreate),
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 26.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Text('本次还款：',
                                                  style: TextStyle(
                                                    color: Colours.primary,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .editRepaymentAmount(
                                                              customCreditDTO);},
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 120.w,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text((customCreditDTO.repaymentAmount ?? Decimal.zero).toString(),
                                                                    style: TextStyle(
                                                                      color: Colours.text_333,
                                                                      fontSize: 30.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                    )),
                                                              ),
                                                              Container(
                                                                color: Colours
                                                                    .text_ccc,
                                                                height: 1,
                                                                width: 120.w,
                                                              )
                                                            ],
                                                          ),
                                                          LoadAssetImage(
                                                            'edit',
                                                            width: 30.w,
                                                            height: 30.w,
                                                            color: Colors.blue,
                                                          ),
                                                        ])),
                                              ),
                                              Expanded(
                                                child: Text(customCreditDTO.creditType == OrderType.SALE.value ?
                                              TextUtil.listToStr(customCreditDTO.productNameList):customCreditDTO.creatorName??'',
                                                  textAlign:TextAlign.right,
                                                  style: TextStyle(
                                                    color: Colours.text_999,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )), )
                                            ],
                                          ),
                                          SizedBox(height: 16.w,),
                                          InkWell(
                                            onTap: () => controller.toOrderDetail(customCreditDTO),
                                            child:   Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(children: [
                                                  Text('待还：',
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                        FontWeight.w300,
                                                      )),
                                                  Expanded(child:
                                                  Text(
                                                      DecimalUtil.subtract(
                                                          customCreditDTO
                                                              .creditAmount,
                                                          customCreditDTO
                                                              .repaymentAmount),
                                                      style: TextStyle(
                                                        color: Colours.text_333,
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ))),
                                                ],)),
                                                Expanded(child: InkWell(
                                                        onTap: () => controller.toOrderDetail(customCreditDTO),
                                                        child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(child:
                                                  Text( controller.creditType(customCreditDTO.creditType),
                                                      textAlign:TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ))),
                                                  Visibility(
                                                      visible: customCreditDTO.creditType != OrderType.CREDIT.value,
                                                      child: Icon(
                                                        Icons.keyboard_arrow_right,
                                                        color: Colours.text_ccc,
                                                      ) ),
                                                ],)))

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) => Container(
                            height: 2.w,
                            color: Colours.divider,
                            width: double.infinity,
                          ),
                          itemCount: state.items.length,
                        ));
                  }),
          Container(
            height: 100.w,
          ),
        ],
      ),

      //底部按钮
      floatingActionButton: GetBuilder<ChooseRepaymentOrderController>(
          id: 'choose_repayment_btn',
          builder: (_) {
            return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colours.primary,
                ),
                height: 100.w,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: Container(
                            color: Colors.white,
                            height: 100.w,
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.selectAll,
                                  onChanged: (value) =>
                                      controller.selectAll(value),
                                  activeColor: Colours.primary,
                                ),
                                Expanded(child:Text(state.selectAll ? '全不选': '全选',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w500,
                                    )), ),
                                Expanded(
                                    flex: 2,
                                    child:
                                Text(
                                    DecimalUtil.formatAmount(state.totalAmount),
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w600,
                                    ))),
                              ],
                            ))),
                    Expanded(
                        child: InkWell(
                      onTap: () => Get.back(result: state.selected),
                      child: Center(
                        child: Text('选好了',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    )),
                  ],
                ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

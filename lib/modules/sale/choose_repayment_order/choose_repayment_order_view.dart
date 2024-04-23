import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/picker_date_utils.dart';

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
                  Center(
                    child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10.w),
                        color: Colors.grey[100],
                        width: double.infinity,
                        child: GetBuilder<ChooseRepaymentOrderController>(
                          id: 'date_range',
                          builder: (_)=>Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
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
                                  onPressed: () {
                                    PickerDateUtils.pickerDate(context,
                                            (result) {
                                          if (null != result) {
                                            if (result.compareTo(controller.state.endDate) >
                                                0) {
                                              Toast.show('起始时间需要小于结束时间');
                                              return;
                                            }
                                            controller.state.startDate = result;
                                            controller.update(['date_range']);
                                          }
                                        });
                                  },
                                  child: Text(
                                    ' ${DateUtil.formatDefaultDate(controller.state.startDate)}',
                                    style: TextStyle(
                                      color: Colours.button_text,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                ' 至',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: TextButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.white), // 背景色
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                35.0), // 圆角
                                            side: BorderSide(
                                              width: 1.0, // 边框宽度
                                              color: Colours.primary, // 边框颜色
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        PickerDateUtils.pickerDate(context,
                                                (result) {
                                              if (null != result) {
                                                if (result.compareTo(
                                                    controller.state.startDate) <
                                                    0) {
                                                  Toast.show('结束时间需要大于起始时间');
                                                  return;
                                                }
                                                controller.state.endDate = result;
                                                controller.update(['date_range']);
                                              }
                                            });
                                      },
                                      child: Text(
                                        ' ${DateUtil.formatDefaultDate(controller.state.endDate)}',
                                        style: TextStyle(
                                          color: Colours.button_text,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))),
                              SizedBox(width: 10.w,),
                              TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(horizontal: 12)),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
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
                                  onPressed: ()=> controller.changeDate(),
                                  child: Text('查询',
                                    style: TextStyle(color: Colours.primary),))
                            ]),)),
                  )
                ],
              )),
        GetBuilder<ChooseRepaymentOrderController>(
                  id: 'repayment_bill',
                  builder: (_) {
                    return Expanded(
                        child:state.items?.isEmpty ?? true
                        ? EmptyLayout(hintText: '什么都没有')
                        :ListView.separated(
                          itemBuilder: (context, index) {
                            var customCreditDTO = state.items![index];
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
                          itemCount: state.items?.length ?? 0,
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

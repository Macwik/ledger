import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'repayment_bill_controller.dart';

class RepaymentBillView extends StatelessWidget {
  RepaymentBillView({super.key});

  final controller = Get.find<RepaymentBillController>();
  final state = Get.find<RepaymentBillController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        backPressed: () => controller.repayBillGetBack(),
        title: '还款开单'.tr,
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.repayBillGetBack();
            return true;
          },
          child: FormBuilder(
              key: state.formKey,
              onChanged: controller.onFormChange,
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 40.w, right: 40.w, top: 20.w, bottom: 20.w),
                        child: Column(
                          children: [
                            PermissionOwnerWidget(
                                widgetType: LedgerWidgetType.Disable,
                                child: Row(
                                  children: [
                                    Text(
                                      '* ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                      '日期',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () =>
                                          controller.pickerDate(context),
                                      child:
                                          GetBuilder<RepaymentBillController>(
                                              id: 'bill_date',
                                              builder: (_) {
                                                return Text(
                                                  DateUtil.formatDefaultDate(
                                                      state.date),
                                                  style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                );
                                              }),
                                    )
                                  ],
                                )),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
                              width: double.infinity,
                            ),
                            Row(
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
                                const Spacer(),
                                InkWell(
                                    onTap: () => controller.selectCustom(),
                                    child: GetBuilder<RepaymentBillController>(
                                        id: 'repayment_custom',
                                        builder: (_) {
                                          return Row(
                                            children: [
                                              Text(
                                                state.customDTO?.customName ??
                                                    '请选择还款人',
                                                style: TextStyle(
                                                  color: state.customDTO
                                                              ?.customName !=
                                                          null
                                                      ? Colours.text_333
                                                      : Colours.text_ccc,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: LoadAssetImage(
                                                  'common/arrow_right',
                                                  width: 25.w,
                                                  color: Colours.text_999,
                                                ),
                                              ),
                                            ],
                                          );
                                        }))
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 30.w, bottom: 10.w),
                              width: double.infinity,
                            ),
                            GetBuilder<RepaymentBillController>(
                                id: 'is_selected',
                                builder: (_) {
                                  return Row(
                                    children: [
                                      Text(
                                        '是否按单还款',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Checkbox(
                                          value: state.isSelect ==
                                              IsSelectType.TRUE,
                                          activeColor: Colours.primary,
                                          onChanged: (value) =>
                                              controller.judgeIsSelect(value))
                                    ],
                                  );
                                }),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              width: double.infinity,
                            ),
                            GetBuilder<RepaymentBillController>(
                                id: 'repayment_credit_bill',
                                builder: (_) {
                                  return Visibility(
                                    visible:
                                        state.isSelect == IsSelectType.TRUE,
                                    maintainSize: false, // 不保留空间
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 30.w, bottom: 30.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              '* ',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              '选择收款单据',
                                              style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () => controller.selectOrderBill(),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '￥${state.customCreditDTO != null ? state.repaymentTotalAmount : '请选择'}',
                                                      style: TextStyle(
                                                        color:
                                                            state.customCreditDTO !=
                                                                    null
                                                                ? Colours
                                                                    .text_333
                                                                : Colours
                                                                    .text_ccc,
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: LoadAssetImage(
                                                        'common/arrow_right',
                                                        width: 25.w,
                                                        color: Colours.text_999,
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        )),
                                  );
                                }),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only( bottom: 30.w),
                              width: double.infinity,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '* ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        '收款金额 (元)',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '* ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        '收款账户',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                      onTap: () {
                                          controller.repaymentAmountUpdate();

                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder.none,
                                        hintText: '请填写',
                                      ),
                                      style: TextStyle(
                                          fontSize: 32.sp
                                      ),
                                      controller: state.repaymentController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      validator: (value) {
                                        var text =
                                            state.repaymentController.text;
                                        if ((text.isEmpty)) {
                                          return '收款金额不能为空';
                                        }
                                        if (state.isSelect ==
                                            IsSelectType.TRUE) {
                                          if (state.customCreditDTO?.isEmpty ??
                                              true) {
                                            Toast.show('请选择收款单据');
                                          }
                                          if (Decimal.parse(text) >
                                              state.repaymentTotalAmount) {
                                            return '收款金额需小于应收金额';
                                          }
                                        }
                                        return null; // 如果验证成功，返回null
                                      }),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: GetBuilder<RepaymentBillController>(
                                        id: 'repayment_way',
                                        builder: (_) {
                                          return InkWell(
                                              onTap: () => controller
                                                  .selectPaymentMethod(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  Expanded(child:
                                                  Text(
                                                    textAlign:TextAlign.center,
                                                    state.paymentMethodDTO
                                                            ?.name ??
                                                        '请选择',
                                                    style: TextStyle(
                                                        color: state.paymentMethodDTO
                                                                        ?.name != null
                                                                ? Colours.text_333
                                                                : Colours.text_ccc,
                                                    fontSize: 32.sp),
                                                  )),
                                                  LoadAssetImage(
                                                    'common/arrow_right',
                                                    width: 25.w,
                                                    color: Colours.text_999,
                                                  ),
                                                ],
                                              ));
                                        }))
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              width: double.infinity,
                            ),
                            GetBuilder<RepaymentBillController>(
                                id: 'repayment_discount_amount',
                                builder: (_){
                                  return   Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '抹零金额 (元)',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            onTap: () => controller.discountAmountUpdate(),
                                            controller: state.discountController,
                                            decoration: InputDecoration(
                                                hintText: '抹零会平摊到还款货物中',
                                                counterText: '',
                                                border: InputBorder.none),
                                            style: TextStyle(fontSize: 32.sp),
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            maxLength: 10,
                                            validator: (value) {
                                              if ((null == value) || value.isEmpty) {
                                                return null; // 非必填项目为空时不进行验证
                                              }
                                              String text = state.discountController.text;
                                              var repaymentAmount =
                                              Decimal.tryParse(text);
                                              if (null == repaymentAmount) {
                                                return '还款金额请输入数字';
                                              } else if (repaymentAmount < Decimal.zero) {
                                                return '还款金额不能小于0';
                                              }
                                              return null;
                                            },
                                          ))
                                    ],
                                  );
                                }),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only( bottom: 40.w),
                              width: double.infinity,
                            ),
                            Row(
                              children: [
                                Text(
                                  '目前欠款',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                GetBuilder<RepaymentBillController>(
                                    id: 'repayment_bill_credit_amount',
                                    builder: (_) {
                                      return Text(
                                        '￥${state.customDTO?.creditAmount ?? ''}',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    })
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              height: 1.w,
                              margin: EdgeInsets.only(top: 30.w, bottom: 10.w),
                              width: double.infinity,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  '备注',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: state.remarkController,
                                      textAlign: TextAlign.right,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder.none,
                                        hintText: '请填写',
                                      ),
                                      style: TextStyle(
                                          fontSize: 32.sp
                                      ),
                                      maxLength: 32,
                                      keyboardType: TextInputType.name,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: GetBuilder<RepaymentBillController>(
                        id: 'repayment_bill_btn',
                        builder: (_) {
                          return Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                  child: Visibility(
                                      replacement: ElevatedBtn(
                                        //margin: EdgeInsets.only(top: 80.w),
                                        size: Size(double.infinity, 90.w),
                                        onPressed: () =>
                                            controller.repayBillGetBack(),
                                        radius: 15.w,
                                        backgroundColor: Colors.white,
                                        text: '取消',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      visible:
                                          state.isSelect == IsSelectType.TRUE,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 20.w),
                                          height: 90.w,
                                          //  margin: EdgeInsets.only(top: 80.w),
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text('应收款：',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              Text(
                                                  '￥${state.repaymentTotalAmount}',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          )))),
                              Expanded(
                                child: ElevatedBtn(
                                  size: Size(double.infinity, 90.w),
                                  onPressed: () => controller.addRepayment(),
                                  radius: 15.w,
                                  backgroundColor: Colours.primary,
                                  text: '收款',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ))
                ],
              ))),
    );
  }
}

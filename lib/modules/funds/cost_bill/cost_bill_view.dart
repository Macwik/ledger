import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:decimal/decimal.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'cost_bill_controller.dart';

class CostBillView extends StatelessWidget {
  CostBillView({super.key});

  final controller = Get.find<CostBillController>();
  final state = Get.find<CostBillController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title: state.costOrderType == CostOrderType.COST ? '费用开单' : '收入开单',
          backPressed:() => controller.costBillGetBack() ,
        ),
        body: MyWillPop(
            onWillPop: () async {
              controller.costBillGetBack();
              return true;
            },
            child: FormBuilder(
              key: state.formKey,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(40.w),
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () =>
                                          controller.toSelectCostType(),
                                      child: GetBuilder<CostBillController>(
                                          id: 'costType',
                                          builder: (_) {
                                            return Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Text(
                                                  '*',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 30.sp,
                                                  ),
                                                ),
                                                Text(
                                                  state.costOrderType ==
                                                          CostOrderType.COST
                                                      ? '费用类别'
                                                      : '收入类别',
                                                  style: TextStyle(
                                                    color: Colours.text_666,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      state.costLabel
                                                              ?.labelName ??
                                                          '请选择',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: state.costLabel
                                                                    ?.labelName !=
                                                                null
                                                            ? Colours.text_333
                                                            : Colours.text_ccc,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: LoadAssetImage(
                                                    'common/arrow_right',
                                                    width: 25.w,
                                                    color: Colours.text_999,
                                                  ),
                                                )
                                              ],
                                            );
                                          })),
                                  Container(
                                    color: Colours.divider,
                                    margin: EdgeInsets.only(top: 32.w),
                                    height: 1.w,
                                    width: double.infinity,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                      Text(
                                        state.costOrderType ==
                                                CostOrderType.COST
                                            ? '费用名称'
                                            : '收入名称',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                              onTap: () {
                                                if (state.textEditingController
                                                    .text.isEmpty) {
                                                  state.textEditingController
                                                      .text = state.costLabel
                                                          ?.labelName ??
                                                      '';
                                                }
                                              },
                                              controller:
                                                  state.textEditingController,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 30.sp),
                                              decoration: InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none,
                                                hintText: '请填写',
                                              ),
                                              maxLength: 18,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                var text = state
                                                    .textEditingController.text;
                                                if (text.isEmpty) {
                                                  return '名称不能为空';
                                                }
                                                // 进行其他验证逻辑
                                                return null; // 如果验证成功，返回null
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(
                                  bottom: 10.w,
                                ),
                                width: double.infinity,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '金额',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                        controller: state.amountController,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                          hintText: '请填写',
                                        ),
                                        style: TextStyle(
                                            fontSize: 30.sp
                                        ),
                                    maxLength: 9,
                                    keyboardType: TextInputType.number,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: '金额不能为空'),
                                      (value) {
                                        var repaymentAmount =
                                            Decimal.tryParse(value!);
                                        if (null == repaymentAmount) {
                                          return '请正确输入费用收入金额！';
                                        } else if (repaymentAmount <=
                                            Decimal.zero) {
                                          return '费用收入金额不能小于等于0';
                                        } else if (value.startsWith('0')) {
                                          return '费用收入金额的首个数字不能为零';
                                        }
                                        return null;
                                      },
                                    ]),
                                  )),
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(bottom: 32.w),
                                width: double.infinity,
                              ),
                              InkWell(
                                  onTap: () => controller.toCheckPayWay(),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                      Text(
                                        '支付方式',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                          child: GetBuilder<CostBillController>(
                                              id: 'paymentWay',
                                              builder: (_) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        state.bankDTO?.name ??
                                                            '请选择',
                                                        style: TextStyle(
                                                          color: state.bankDTO
                                                                      ?.name !=
                                                                  null
                                                              ? Colours.text_333
                                                              : Colours
                                                                  .text_ccc,
                                                        )),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.w),
                                                      child: LoadAssetImage(
                                                        'common/arrow_right',
                                                        width: 25.w,
                                                        color: Colours.text_999,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          height: 16.w,
                          width: double.infinity,
                        ),
                        //第三部分结算情况
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(40.w),
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
                                    margin: EdgeInsets.only(left: 16.w),
                                    child: Text(
                                      '结算详情',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '哪里支付',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                  InkWell(
                                      onTap: () => controller.explainPayment(),
                                      child: LoadAssetImage(
                                        'ic_home_question',
                                        color: Colors.black45,
                                        width: 24.w,
                                        height: 24.w,
                                      )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GetBuilder<CostBillController>(
                                      id: 'cost_bill_select_product_position',
                                      builder: (_) {
                                        return DropdownButton2<int>(
                                          alignment: Alignment.centerRight,
                                          value: state.selectedOption,
                                          hint: Text('销售地支付', style: TextStyle(color: Colours.text_333),),
                                          underline: Container(
                                            height: 0.w,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colours.text_ccc,
                                            ),
                                            iconSize: 24,
                                          ),
                                          style: TextStyle(
                                              color: Colours.text_333),
                                          onChanged: (value) {
                                            state.selectedOption = value;
                                            controller.update([
                                              'cost_bill_select_product_position'
                                            ]);
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: 1,
                                              child: Text('销售地支付'),
                                            ),
                                            DropdownMenuItem(
                                              value: 0,
                                              child: Text('产地支付'),
                                            ),
                                          ],
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(bottom: 32.w),
                                width: double.infinity,
                              ),
                              GetBuilder<CostBillController>(
                                  id: 'bindingPurchaseBill',
                                  builder: (_) {
                                    return InkWell(
                                      onTap: () =>
                                          controller.toBindingPurchaseBill(),
                                      child: Row(
                                        children: [
                                          Text(
                                            '绑定采购单',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Expanded(
                                              child: Text(
                                                  state.orderDTO?.batchNo ??
                                                      '请选择',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color:
                                                        state.orderDTO != null
                                                            ? Colours.text_333
                                                            : Colours.text_ccc,
                                                  ))),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
                                            child: LoadAssetImage(
                                              'common/arrow_right',
                                              width: 25.w,
                                              color: Colours.text_999,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.symmetric(vertical: 32.w),
                                width: double.infinity,
                              ),
                              GetBuilder<CostBillController>(
                                  id: 'bindingPurchaseBill',
                                  builder: (_) {
                                    return InkWell(
                                        onTap: () {
                                          controller.bindingProduct(context);
                                        },
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            Text(
                                              '绑定货物',
                                              style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    controller.getBindingProductNames(),
                                                    style: TextStyle(
                                                      color: (state.bindingProduct?.isEmpty ?? true)
                                                          ? Colours.text_ccc
                                                          : Colours.text_333,
                                                    )),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: LoadAssetImage(
                                                    'common/arrow_right',
                                                    width: 25.w,
                                                    color: Colours.text_999,
                                                  ),
                                                )
                                              ],
                                            ))
                                          ],
                                        ));
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          height: 15.w,
                          width: double.infinity,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(40.w),
                          margin: EdgeInsets.only(bottom: 100.w),
                          child: Column(
                            children: [
                              PermissionOwnerWidget(
                                  widgetType: LedgerWidgetType.Disable,
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '日期',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () =>
                                            controller.pickerDate(context),
                                        child: GetBuilder<CostBillController>(
                                            id: 'bill_date',
                                            builder: (_) {
                                              return Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  DateUtil.formatDefaultDate(
                                                      state.date),
                                                  style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }),
                                      )),
                                    ],
                                  )),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(
                                  top: 32.w,
                                ),
                                width: double.infinity,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child: Text(
                                    '备注',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
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
                                            fontSize: 30.sp
                                        ),
                                        maxLength: 32,
                                        keyboardType:
                                            TextInputType.name,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: GetBuilder<CostBillController>(
                            id: 'costBillBtn',
                            builder: (logic) {
                              return Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: ElevatedBtn(
                                      onPressed: () =>
                                          controller.costBillGetBack(),
                                      size: Size(double.infinity, 100.w),
                                      radius: 15.w,
                                      backgroundColor: Colors.white,
                                      child: Text('取消 ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedBtn(
                                      size: Size(double.infinity, 100.w),
                                      onPressed: () {
                                        (state.formKey.currentState
                                                    ?.saveAndValidate() ??
                                                false)
                                            ? controller.addCost()
                                            : null;
                                      },
                                      radius: 15.w,
                                      backgroundColor: Colours.primary,
                                      text: '保存',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

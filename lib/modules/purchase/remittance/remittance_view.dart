import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'remittance_controller.dart';

class RemittanceView extends StatelessWidget {
  final controller = Get.find<RemittanceController>();
  final state = Get.find<RemittanceController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        backPressed: ()=> controller.remittanceGetBack(),
        title:'新增汇款'.tr,),
      body: MyWillPop(
          onWillPop: () async {
            controller.remittanceGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        //onChanged: controller.onFormChange,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        PermissionWidget(
                            permissionCode: PermissionCode.remittance_bill_time_permission,
                            child:Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              right: 30.w, left: 30.w, top: 32.w, bottom: 20.w),
                          alignment: Alignment.bottomCenter,
                          child:  PermissionOwnerWidget(
                              widgetType: LedgerWidgetType.Disable,
                              child:Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '日期',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => controller.pickerDate(context),
                                child: GetBuilder<RemittanceController>(
                                    id: 'date',
                                    builder: (_) {
                                      return Text(
                                        DateUtil.formatDefaultDate(state.date),
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: LoadAssetImage(
                                  'common/arrow_right',
                                  width: 25.w,
                                  color: Colours.text_999,
                                ),
                              ),
                            ],
                          )),
                        )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                            right: 30.w,
                            left: 30.w,),
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(
                                child:
                                 Row(
                                    children: [
                                      Text(
                                         '* ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                         '收款人姓名',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,),
                                      ),
                                    ],
                                  ),
                                ),
                              Expanded(
                                child: TextFormField(
                                  controller: state.receiverController,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    hintText: '请填写',
                                  ),
                                  style: TextStyle(
                                      fontSize: 32.sp
                                  ),
                                  maxLength: 10,
                                  validator: FormBuilderValidators.required(
                                      errorText: '收款人不能为空'.tr),
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                          color: Colors.white,
                          padding:
                          EdgeInsets.only(right: 30.w, left: 30.w, top: 20.w),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                   Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                 '* ',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                              Text(
                                                 '汇款金额',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w400,),
                                              ),
                                            ],
                                          ),
                                    Container(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: state.amountController,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            hintText: '请填写',
                                          ),
                                          style: TextStyle(
                                              fontSize: 32.sp
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          validator: FormBuilderValidators.compose([
                                            FormBuilderValidators.required(
                                                errorText: '汇款金额不能为空'),
                                                (value) {
                                              var repaymentAmount = Decimal.tryParse(value!);
                                              if (null == repaymentAmount) {
                                                return '汇款金额请输入数字';
                                              } else if (repaymentAmount <= Decimal.zero) {
                                                return '汇款金额不能小于等于0';
                                              } else if (value.startsWith('0')) {
                                                return '汇款金额的首个数字不能为零';
                                              }
                                              return null;
                                            },
                                          ]),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colours.divider,
                                width: 2.w,
                                height: 100.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                     Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                 '* ',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                              Text(
                                                '汇款账户',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w400,),
                                              ),
                                            ],
                                          ),
                                    GetBuilder<RemittanceController>(
                                        id: 'repayment_way',
                                        builder: (_) {
                                          return Container(
                                              padding: EdgeInsets.only(bottom: 30.w,top: 20.w),
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                  onTap: () =>
                                                      controller.selectBank(),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                          state.paymentMethodDTO
                                                              ?.name ??
                                                              '请选择',
                                                          style: TextStyle(fontSize: 32.sp,
                                                            color:
                                                            state.paymentMethodDTO
                                                                ?.name !=
                                                                null
                                                                ? Colors.black87
                                                                : Colors
                                                                .black26,
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: LoadAssetImage(
                                                          'common/arrow_right',
                                                          width: 25.w,
                                                          color: Colours.text_999,
                                                        ),
                                                      ),
                                                    ],
                                                  )));
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          color: Colors.white10,
                          height: 32.w,
                          width: double.infinity,
                        ),
                        GetBuilder<RemittanceController>(
                            id: 'productName',
                            builder: (_) {
                              return InkWell(
                                onTap: () => controller.toStockList(),
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(30.w,),
                                  width: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    children: [
                                      Text(
                                        '采购品种',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(state.productDTO?.productName ?? '请选择',
                                          style: TextStyle(
                                              fontSize: 32.sp,
                                            color: state.productDTO?.productName !=
                                                null
                                                ? Colors.black87
                                                : Colors.black26,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: LoadAssetImage(
                                          'common/arrow_right',
                                          width: 25.w,
                                          color: Colours.text_999,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 30.w, left: 30.w),
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(
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
                                child: TextFormField(
                                  controller: state.remarkController,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    hintText: '请填写',
                                  ),
                                  style: TextStyle(
                                      fontSize: 32.sp
                                  ),
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.name,
                                  maxLength: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                   child: GetBuilder<RemittanceController>(
                       id: 'remittance_btn',
                       builder: (_) {
                         return Row(
                           children: [
                             Expanded(
                               child: ElevatedBtn(
                                 margin: EdgeInsets.only(top: 80.w),
                                 size: Size(double.infinity, 90.w),
                                 onPressed: ()=> controller.remittanceGetBack(),
                                 radius: 15.w,
                                 backgroundColor: Colors.white,
                                 text: '取消',
                                 style: TextStyle(
                                   color: Colors.black54,
                                   fontSize: 30.sp,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             ),
                             Expanded(
                               child: ElevatedBtn(
                                 onPressed: (){(state.formKey.currentState?.saveAndValidate() ?? false)
                                     ? controller.addRemittance()
                                     : null;},
                                 margin: EdgeInsets.only(top: 80.w),
                                 size: Size(double.infinity, 90.w),
                                 radius: 15.w,
                                 backgroundColor: Colours.primary,
                                 text: '保存',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 30.sp,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             )
                           ],
                         );
                       }))
            ],
          ),
        ),
      )),
    );
  }
}


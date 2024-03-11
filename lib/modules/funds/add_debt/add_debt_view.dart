import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_debt_controller.dart';

class AddDebtView extends StatelessWidget {
  final controller = Get.find<AddDebtController>();
  final state = Get.find<AddDebtController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text('录入欠款',style: TextStyle(color: Colors.white),),
        leading: BackButton(
          onPressed:()=> controller.addDebtGetBack(),
          color: Colors.white,),),
      body: MyWillPop(
          onWillPop: () async {
            controller.addDebtGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        onChanged: controller.onFormChange,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(children: [
            IntrinsicHeight(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: 20.w, left: 40.w, right: 40.w, bottom: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.w,
                    ),
                PermissionWidget(
                  permissionCode: PermissionCode.add_debt_time_permission,
                  child:
                  PermissionOwnerWidget(
                      widgetType: LedgerWidgetType.Disable,
                      child:
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
                        InkWell(
                          onTap: () => controller.pickerDate(context),
                          child: GetBuilder<AddDebtController>(
                              id: 'bill_date',
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
                        )
                      ],
                    ))),
                    Container(
                      color: Colours.divider,
                      margin: EdgeInsets.only(top: 20.0, bottom: 20),
                      height: 1.w,
                      width: double.infinity,
                    ),
                    GetBuilder<AddDebtController>(
                        id: 'custom',
                        builder: (_) {
                          return InkWell(
                            onTap: () => controller.chooseCustom(),
                            child: Row(
                              children: [
                                 Row(
                                    children: [
                                      Text(
                                         '* ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                         '欠款人',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                const Spacer(),
                                Text(
                                 state.customDTO?.customName??'',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 32.sp,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
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
                      margin: EdgeInsets.only(top: 20.0, bottom: 10),
                      height: 1.w,
                      width: double.infinity,
                    ),
                    GetBuilder<AddDebtController>(
                        id: 'debtNum',
                        builder: (_) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Row(
                                  children: [
                                    Text(
                                       '* ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                       '金额',
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
                                  child: TextFormField(
                                    controller: state.amountController,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: '请填写',
                                    ),
                                    style: TextStyle(
                                        fontSize: 32.sp
                                    ),
                                maxLength: 9,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: '还款金额不能为空！'),
                                  (value) {
                                    var repaymentAmount = Decimal.tryParse(value!);
                                    if (null == repaymentAmount) {
                                      return '请正确输入还款金额！';
                                    } else if (repaymentAmount <= Decimal.zero) {
                                      return '还款金额不能小于等于0';
                                    }else if (value.startsWith('0')) { // 添加此条件来验证首个数字不为零
                                      return '还款金额的首个数字不能为零';
                                    }
                                    return null;
                                  },
                                ]),
                                keyboardType: TextInputType.number,
                              )),
                            ],
                          );
                        }),
                    Container(
                      color: Colours.divider,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10),
                      height: 1.w,
                      width: double.infinity,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          '备注',
                          style: TextStyle(
                            color: Colours.text_666,
                            fontSize: 32.sp,
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
                                  fontSize: 32.sp
                              ),
                                    maxLength: 32,
                                    keyboardType: TextInputType.name,
                               ))
                          ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            GetBuilder<AddDebtController>(
                id: 'Debt_btn',
                builder: (logic) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedBtn(
                          margin: EdgeInsets.only(top: 80.w),
                          size: Size(double.infinity, 90.w),
                          onPressed:()=> controller.addDebtGetBack(),
                          radius: 15.w,
                          backgroundColor: Colors.white,
                          text: '取消',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedBtn(
                          onPressed: () => controller.addDebt(),
                          margin: EdgeInsets.only(top: 80.w),
                          size: Size(double.infinity, 90.w),
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
          ]),
        ),
      )),
    );
  }
}

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/custom_textfield.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_custom_controller.dart';

class AddCustomView extends StatelessWidget {
  final controller = Get.find<AddCustomController>();
  final state = Get.find<AddCustomController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text(state.customType == 0 ? '新增客户' : '新增供应商',
        style: TextStyle(color: Colors.white)),
        leading: BackButton(
          color: Colors.white,
          onPressed: (){controller.addCustomGetBack();},
        ),
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.addCustomGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        onChanged: controller.onFormChange,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(children: [
            Expanded(child:
            ListView(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 20.w, left: 40.w, right: 40.w, bottom: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child:  Row(
                                  children: [
                                    Text(
                                       '* ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                       '姓名',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          Expanded(
                              child: CustomTextField(
                                name: 'customName',
                                textAlign: TextAlign.right,
                                hintText: '请填写',
                                maxLength: 10,
                                keyboardType: TextInputType.emailAddress,
                                validator: FormBuilderValidators.required(
                                    errorText:
                                    state.customType == 0 ? '请输入客户名称' : '请输入供应商名称'),
                              ))
                        ],
                      ),
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
                                '手机号',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.sp,
                                ),
                              )),
                          Expanded(
                              child: CustomTextField(
                                name: 'customPhone',
                                hintText: '请填写',
                                maxLength: 11,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.phone,
                                  validator: FormBuilderValidators.compose([
                                        (value) {
                                      if ((null == value) || value.isEmpty) {
                                        return null; // 非必填项目为空时不进行验证
                                      }
                                      var repaymentAmount = Decimal.tryParse(value);
                                      if (null == repaymentAmount) {
                                        return '手机号请输入数字';
                                      }
                                      return null;
                                    },
                                  ])
                              ))
                        ],
                      ),
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
                                '地址',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.sp,
                                ),
                              )),
                          Expanded(
                            flex: 3,
                              child: CustomTextField(
                                name: 'customAddress',
                                textAlign: TextAlign.right,
                                hintText: '请填写',
                                maxLength: 32,
                                keyboardType: TextInputType.emailAddress,
                              ))
                        ],
                      ),
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
                                  color: Colors.black,
                                  fontSize: 28.sp,
                                ),
                              )),
                          Expanded(
                            flex: 3,
                              child: CustomTextField(
                                name: 'customRemark',
                                textAlign: TextAlign.right,
                                hintText: '请填写',
                                maxLength: 32,
                                keyboardType: TextInputType.emailAddress,
                              ))
                        ],
                      ),
                      Container(
                        color: Colours.divider,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10),
                        height: 1.w,
                        width: double.infinity,
                      ),
                    ],
                  ),
                )
              ],
            )),
           Align(
             alignment: Alignment.bottomCenter,
             child: Container(
               child: GetBuilder<AddCustomController>(
                   id: 'custom_btn',
                   builder: (controller) {
                     return Row(
                       children: [
                         Expanded(
                           child: ElevatedBtn(
                             margin: EdgeInsets.only(top: 80.w),
                             size: Size(double.infinity, 90.w),
                             onPressed: (){controller.addCustomGetBack();},
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
                             margin: EdgeInsets.only(top: 80.w),
                             size: Size(double.infinity, 90.w),
                             onPressed: () =>
                             (state.formKey.currentState?.saveAndValidate() ?? false)
                                 ? controller.addCustom()
                                 : null,
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
          ]),
        ),
      )),
    );
  }
}

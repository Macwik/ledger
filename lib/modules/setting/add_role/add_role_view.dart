import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/custom_textfield.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_role_controller.dart';

class AddRoleView extends StatelessWidget {
  final controller = Get.find<AddRoleController>();
  final state = Get.find<AddRoleController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增岗位',style: TextStyle(color: Colors.white),),
        leading: BackButton(
          onPressed: ()=> controller.addRoleGetBack(),
          color: Colors.white,)
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.addRoleGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        onChanged: controller.onFormChange,
        child: Column(children: [
            GetBuilder<AddRoleController>(
                id: 'add_role',
                builder: (_) {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 20.w, left: 40.w, right: 40.w, bottom: 20.w),
                    child: Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                               '* ',
                              style: TextStyle(color: Colors.red,
                                  fontSize: 28.sp),
                            ),
                            Text(
                              '岗位名称',
                              style: TextStyle(color: Colours.text_666,
                                  fontSize: 32.sp
                              ),
                            ),
                            Expanded(child:  CustomTextField(
                              name: 'roleName',
                              textAlign: TextAlign.right,
                              hintText: '请填写',
                              maxLength: 10,
                              textColor: Colours.text_333,
                              fontSize: 32.sp,
                              keyboardType: TextInputType.emailAddress,
                              validator: FormBuilderValidators.required(
                                  errorText: '请填写岗位名称'.tr),
                            ),),
                          ],
                        ),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              '岗位权利备注',
                              style: TextStyle(
                                color: Colours.text_666,
                                fontSize: 32.sp,
                              ),
                            )),
                            Expanded(
                                child: CustomTextField(
                                name: 'roleDesc',
                                hintText: '请填写',
                                textColor: Colours.text_333,
                                fontSize: 32.sp,
                                textAlign: TextAlign.right,
                                maxLength: 20,
                                keyboardType: TextInputType.emailAddress,
                            ))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            Spacer(
              flex: 1,
            ),
            Container(
              child: GetBuilder<AddRoleController>(
                  id: 'add_role_btn',
                  builder: (logic) {
                    return Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: ElevatedBtn(
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              onPressed: ()=> controller.addRoleGetBack(),
                              radius: 15.w,
                              backgroundColor: Colors.white,
                              text: '取消',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        Expanded(
                              child: ElevatedBtn(
                                margin: EdgeInsets.only(top: 80.w),
                                size: Size(double.infinity, 90.w),
                                onPressed: () => (state.formKey.currentState?.saveAndValidate() ?? false)
                                    ? controller.addRole()
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
            )
          ]),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_account_controller.dart';

class AddAccountView extends StatelessWidget {
  AddAccountView({super.key});

  final controller = Get.find<AddAccountController>();
  final state = Get.find<AddAccountController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建账本',style: TextStyle(color: Colors.white),),
        leading: BackButton(
          onPressed: ()=> controller.addAccountGetBack(),
          color: Colors.white,),),
      body: MyWillPop(
          onWillPop: () async {
            controller.addAccountGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        onChanged: controller.onFormChange,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: 40.w, left: 40.w, right: 40.w, bottom: 40.w),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Text('店铺名'),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(1, 1),
                                        blurRadius: 3,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: state.nameController,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: '请填写店铺名',
                                    ),
                                    style: TextStyle(
                                        fontSize: 32.sp
                                    ),
                                      keyboardType: TextInputType.name,
                                      textAlign: TextAlign.center,
                                      maxLength: 10,
                                    validator: FormBuilderValidators.required(
                                        errorText: '请填写店铺名称'.tr),
                                  ))),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                      Expanded(
                      child:Text('店铺类型')),
                          SizedBox(width: 20),
                          GetBuilder<AddAccountController>(
                              id: 'storeType',
                              builder: (controller) =>  ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                    .isSelectedStoreType(0)
                                                ? Colours.primary
                                                : Colors.white,
                                            foregroundColor: controller
                                                    .isSelectedStoreType(0)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          onPressed: () =>
                                              controller.changeStoreType(0),
                                          child: Text('批发商'),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          onPressed: () =>
                                              controller.changeStoreType(1),
                                          child: Text('货主'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                    .isSelectedStoreType(1)
                                                ? Colours.primary
                                                : Colors.white,
                                            foregroundColor: controller
                                                    .isSelectedStoreType(1)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ],
                      )),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text('经营类型'),
                      )),
                      GetBuilder<AddAccountController>(
                        id: 'businessScope',
                        builder: (controller) => ButtonBar(
                              alignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.isSelectedBusinessScope(0)
                                        ? Colours.primary
                                        : Colors.white,
                                foregroundColor:
                                    controller.isSelectedBusinessScope(0)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              onPressed: () =>
                                  controller.changeBusinessScope(0),
                              child: Text('水果'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  controller.changeBusinessScope(1),
                              child: Text('蔬菜'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.isSelectedBusinessScope(1)
                                        ? Colours.primary
                                        : Colors.white,
                                foregroundColor:
                                    controller.isSelectedBusinessScope(1)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  controller.changeBusinessScope(2),
                              child: Text('粮油'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.isSelectedBusinessScope(2)
                                        ? Colours.primary
                                        : Colors.white,
                                foregroundColor:
                                    controller.isSelectedBusinessScope(2)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder<AddAccountController>(
                  id: 'saveBtn',
                  builder: (controller) {
                    return ElevatedBtn(
                      size: Size(double.infinity, 90.w),
                      onPressed: () =>
                          (state.formKey.currentState?.saveAndValidate() ??
                                  false)
                              ? controller.addAccount()
                              : null,
                      radius: 15.w,
                      backgroundColor: Colours.primary,
                      text: '保存',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
            )
          ]),
        ),
      )),
    );
  }
}

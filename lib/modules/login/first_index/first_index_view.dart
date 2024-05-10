import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'first_index_controller.dart';

class FirstIndexView extends StatelessWidget {
  FirstIndexView({super.key});

  final controller = Get.find<FirstIndexController>();
  final state = Get.find<FirstIndexController>().state;

  @override
  Widget build(BuildContext context) {
    return  FormBuilder(
        key: state.formKey,
        onChanged: controller.onFormChange,
        child:Container(
      color: Colors.white,
      child: Column(
        children: [
          InkWell(
            onTap: ()=>Get.back(),
            child:Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 120.w,right: 100.w),
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: LoadAssetImage(
                'get_back',
                width: 40.w,
                height: 40.w,
                color: Colors.black87,
              ),
            ) ,
          ),
          Expanded(child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 80.w,),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: 100.w,
                    height: 3.w,
                    color: Colours.divider,
                  ),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.divider,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: 100.w,
                    height: 3.w,
                    color: Colours.divider,
                  ),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.divider,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 80.w,left: 80.w),
                child: Text('基本信息填写',
                  style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600
                  ),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 80.w,left: 80.w,right: 80.w),
                child: Row(children: [
                  Text('昵称'),
                  Expanded(child:
                  TextFormField(
                    controller: state.nameController,
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
                      FormBuilderValidators.required(errorText: '昵称不能为空')
                    ]),
                    keyboardType: TextInputType.number,
                  ))
                ],
                ),
              ),
              Container(
                height: 1.w,
                color: Colours.divider,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16.w,left: 80.w,right: 80.w),
                child: Row(children: [
                  Text('密码'),
                  Expanded(child:
                  TextFormField(
                    controller: state.passwordController,
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
                      FormBuilderValidators.required(errorText: '密码不能为空')
                    ]),
                    keyboardType: TextInputType.number,
                  ))
                ],
                ),
              ),
              Container(
                height: 1.w,
                margin: EdgeInsets.only(top: 16.w,),
                color: Colours.divider,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16.w,left: 80.w,right: 80.w),
                child: Row(children: [
                  Text('确认密码'),
                  Expanded(child:
                  TextFormField(
                    controller: state.verifyPasswordController,
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
                    validator: (value) {
                      if (controller.state.passwordController.text == value) {
                        return null;
                      }
                      return '两次输入密码不一致';
                    },
                    keyboardType: TextInputType.number,
                  ))
                ],
                ),
              ),
              Container(
                height: 1.w,
                margin: EdgeInsets.only(top: 16.w,),
                color: Colours.divider,
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: GetBuilder<FirstIndexController>(
                id: 'first_index_btn',
                builder: (_){
              return  ElevatedBtn(
              margin: EdgeInsets.all( 80.w),
              size: Size(double.infinity, 90.w),
              radius: 20.w,
              backgroundColor: Colours.primary,
              onPressed: ()=>
              (state.formKey.currentState?.saveAndValidate() ??
                  false)
                  ? Get.toNamed(RouteConfig.addAccount,arguments: {'firstIndex':true})
                  : null,
              text: '下一步',
              style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
                      ),
                    );
                  })),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/will_pop.dart';

import 'account_manage_controller.dart';

class AccountManageView extends StatelessWidget {
  final controller = Get.find<AccountManageController>();
  final state = Get
      .find<AccountManageController>()
      .state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text('账本详情',style: TextStyle(color: Colors.white),),
        leading: BackButton(
          color: Colors.white,
          onPressed: ()=>controller.accountManageGetBack(),
        ),
        actions: [Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: InkWell(
              child: GetBuilder<AccountManageController>(
                  id: 'account_edit',
                  builder: (_) {
                    return Visibility(
                      visible: !state.isEdit,
                      child: Row(
                        children: [
                          LoadAssetImage(
                            'edit',
                            width: 40.w,
                            height: 40.w,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.onEdit(),
                            child: Text(
                              '编辑',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ])],
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.accountManageGetBack();
            return true;
          },
          child:FormBuilder(
        key: state.formKey,
        //onChanged: logic.onFormChange,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(children: [
              GetBuilder<AccountManageController>(
                  id: 'account_detail',
                  builder: (_) {
                    state.nameController = TextEditingController(text: state.ledgerUserRelationDetailDTO?.ledgerName);
                    return
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          top: 40.w, left: 40.w, right: 40.w, bottom: 40.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('店铺名',style: TextStyle(fontSize: 32.sp),),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.5),
                                            offset: Offset(1, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            20.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller:state.nameController,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                          hintText: '请填写店铺名称',
                                        ),
                                        style: TextStyle(
                                            fontSize: 32.sp
                                        ),
                                        keyboardType: TextInputType.name,
                                        maxLength: 15,
                                        readOnly: !state.isEdit,
                                          validator: (value) {
                                            var text = state.nameController.text;
                                            if (text.isEmpty) {
                                              return '店铺名不能为空';
                                            } else {
                                              return null;
                                            }
                                          }
                                      ))),
                            ],
                          ),
                          SizedBox(height: 20.w,),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                    Expanded(
                    child:Text('店铺类型',style: TextStyle(fontSize: 32.sp),)),
                              SizedBox(width: 10),
                              GetBuilder<AccountManageController>(
                                id: 'storeType',
                                builder: (controller) => ButtonBar(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (state.isEdit) {
                                        controller.changeStoreType(0);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.isSelectedStoreType(0)
                                              ? Colours.primary
                                              : Colors.white,
                                      foregroundColor:
                                          controller.isSelectedStoreType(0)
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    child: Text('批发商',style: TextStyle(fontSize: 32.sp),),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (state.isEdit) {
                                        controller.changeStoreType(1);
                                      }
                                    },
                                    child: Text('货主',style: TextStyle(fontSize: 32.sp),),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.isSelectedStoreType(1)
                                              ? Colours.primary
                                              : Colors.white,
                                      foregroundColor:
                                          controller.isSelectedStoreType(1)
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          ),
                          SizedBox(height: 20.w,),
                          Flex(
                            direction: Axis.horizontal,
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text('经营类型',style: TextStyle(fontSize: 32.sp),),
                            )),
                            GetBuilder<AccountManageController>(
                                id: 'businessScope',
                                builder: (controller) =>
                                    ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if(state.isEdit){  controller.changeBusinessScope(0);
                                            }},
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
                                          child: Text('水果',style: TextStyle(fontSize: 32.sp),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if(state.isEdit){  controller.changeBusinessScope(1);
                                            }},
                                          child: Text('蔬菜',style: TextStyle(fontSize: 32.sp),),
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
                                          child: Text('粮油',style: TextStyle(fontSize: 32.sp),),
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
                    );}),
                    Spacer(
                      flex: 1,
                    ),
                    Container(
                      child: GetBuilder<AccountManageController>(
                          id: 'account_btn',
                          builder: (controller) {
                            return  Visibility(
                                visible: state.isEdit,
                                child:ElevatedBtn(
                                  margin: EdgeInsets.only(top: 80.w),
                                  size: Size(double.infinity, 90.w),
                                  onPressed: () => controller.updateAccount(),
                                  radius: 15.w,
                                  backgroundColor: Colours.primary,
                                  text: '保存',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
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

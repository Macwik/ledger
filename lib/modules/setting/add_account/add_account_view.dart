import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_account_controller.dart';

class AddAccountView extends StatelessWidget {
  AddAccountView({super.key});

  final controller = Get.find<AddAccountController>();
  final state = Get.find<AddAccountController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return   MyWillPop(
        onWillPop: () async {
          controller.addAccountGetBack();
          return true;
        },
        child:FormBuilder(
            key: state.formKey,
            onChanged: controller.onFormChange,
            child:Container(
              color: Colors.white,
              child: Column(children: [
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
                Expanded(
                    child: ListView(
                  children: [
                    GetBuilder<AddAccountController>(
                        id:'add_account_form',
                        builder: (_){
                      return Offstage(
                      offstage: !state.firstIndex,
                      child: Row(
                        children: [
                          SizedBox(width: 80.w,),
                          Container(
                              padding: EdgeInsets.all(24.w),
                              decoration: BoxDecoration(
                                color: Colours.divider,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '1',
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
                                color: Colours.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '2',
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
                    );}),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 80.w,left: 80.w),
                      child: Text('新建账本',
                        style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 40.w, left: 80.w, right: 40.w, bottom: 40.w),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 16.w,top: 16.w),
                                child: Row(
                                  children: [
                                    Text('店铺名'),
                                    Expanded(
                                        child:  TextFormField(
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
                                        )),
                                  ],
                                )),
                            Container(
                              height: 1.w,
                              margin: EdgeInsets.only(top: 16.w,),
                              color: Colours.divider,
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 16.w,top: 16.w),
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
                                            child: Text('批发商',style:TextStyle(
                                                fontSize: 30.sp
                                            ) ,),
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
                            Container(
                              height: 1.w,
                              margin: EdgeInsets.only(top: 16.w,),
                              color: Colours.divider,
                            ),
                            // Flex(
                            //   direction: Axis.horizontal,
                            //   children: [
                            //     Expanded(
                            //         child: Container(
                            //           margin: EdgeInsets.only(right: 20),
                            //           child: Text('经营类型'),
                            //         )),
                            //     GetBuilder<AddAccountController>(
                            //       id: 'businessScope',
                            //       builder: (controller) => ButtonBar(
                            //         alignment: MainAxisAlignment.start,
                            //         children: [
                            //           ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor:
                            //               controller.isSelectedBusinessScope(0)
                            //                   ? Colours.primary
                            //                   : Colors.white,
                            //               foregroundColor:
                            //               controller.isSelectedBusinessScope(0)
                            //                   ? Colors.white
                            //                   : Colors.black,
                            //             ),
                            //             onPressed: () =>
                            //                 controller.changeBusinessScope(0),
                            //             child: Text('水果'),
                            //           ),
                            //           ElevatedButton(
                            //             onPressed: () =>
                            //                 controller.changeBusinessScope(1),
                            //             child: Text('蔬菜'),
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor:
                            //               controller.isSelectedBusinessScope(1)
                            //                   ? Colours.primary
                            //                   : Colors.white,
                            //               foregroundColor:
                            //               controller.isSelectedBusinessScope(1)
                            //                   ? Colors.white
                            //                   : Colors.black,
                            //             ),
                            //           ),
                            //           ElevatedButton(
                            //             onPressed: () =>
                            //                 controller.changeBusinessScope(2),
                            //             child: Text('粮油'),
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor:
                            //               controller.isSelectedBusinessScope(2)
                            //                   ? Colours.primary
                            //                   : Colors.white,
                            //               foregroundColor:
                            //               controller.isSelectedBusinessScope(2)
                            //                   ? Colors.white
                            //                   : Colors.black,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<AddAccountController>(
                      id: 'saveBtn',
                      builder: (controller) {
                        return ElevatedBtn(
                          margin: EdgeInsets.all( 80.w),
                          size: Size(double.infinity, 90.w),
                          onPressed: () =>
                          (state.formKey.currentState?.saveAndValidate() ??
                              false)
                              ? controller.addAccount()
                              : null,
                          radius: 15.w,
                          backgroundColor: Colours.primary,
                          text: !state.firstIndex ? '保存':'下一步',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                ),
              ],
              ),
            )
            ));
  }
}

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/modules/sale/custom_detail/custom_detail_controller.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

class CustomDetailView extends StatelessWidget {
  CustomDetailView({super.key});

  final controller = Get.find<CustomDetailController>();
  final state = Get.find<CustomDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          backPressed:() {
            controller.customDetailGetBack();
          },
          title: state.customDTO?.customType == CustomType.CUSTOM.value
              ? '客户资料'
              : '供应商资料',
          actionWidget:
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: InkWell(
                  child: GetBuilder<CustomDetailController>(
                      id: 'custom_edit',
                      builder: (_) {
                        return PermissionWidget(
                            permissionCode: PermissionCode.custom_detail_update_permission,
                            child:Visibility(
                          visible: !state.isEdit,
                          child: Row(
                            children: [
                              LoadAssetImage(
                                'edit',
                                width: 40.w,
                                height: 40.w,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => controller.onEdit(),
                                child: Text(
                                  '编辑',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                      }),
                ),
              ),
            ])
        ),
        body: MyWillPop(
            onWillPop: () async {
              controller.customDetailGetBack();
              return true;
            },
            child: FormBuilder(
              key: state.formKey,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(children: [
                  GetBuilder<CustomDetailController>(
                      id: 'custom_detail',
                      builder: (_) {
                        return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                              top: 20.w,
                              left: 40.w,
                              right: 40.w,
                            ),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text(
                                            '* ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            '姓名',
                                            style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible: state.customDTO?.invalid ==
                                            IsDeleted.DELETED.value,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 2.w,
                                              bottom: 2.w,
                                              left: 4.w,
                                              right: 4.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Text('已停用',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: TextFormField(
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
                                            keyboardType:
                                                TextInputType.name,
                                            maxLength: 10,
                                            readOnly: !state.isEdit,
                                            validator: (value) {
                                              var text =
                                                  state.nameController.text;
                                              if (text.isEmpty) {
                                                return '姓名不能为空';
                                              } else {
                                                return null;
                                              }
                                            }))
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '手机号',
                                        style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                          controller: state.phoneController,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            hintText: '请填写',
                                          ),
                                          style: TextStyle(
                                              fontSize: 32.sp
                                          ),
                                          keyboardType: TextInputType.phone,
                                          maxLength: 20,
                                          readOnly: !state.isEdit,
                                          validator: (value) {
                                            var text =
                                                state.phoneController.text;
                                            if (text.isEmpty) {
                                              return null; // 非必填项目为空时不进行验证
                                            } else {
                                              var repaymentAmount =
                                                  Decimal.tryParse(text);
                                              if (null == repaymentAmount) {
                                                return '手机号请输入数字';
                                              }
                                              return null;
                                            }
                                          }),
                                    )
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '地址',
                                        style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          controller: state.addressController,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            hintText: '请填写',
                                          ),
                                          style: TextStyle(
                                              fontSize: 32.sp
                                          ),
                                          keyboardType:
                                              TextInputType.name,
                                          maxLength: 32,
                                          readOnly: !state.isEdit,
                                        ))
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
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
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400),
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
                                          keyboardType: TextInputType.name,
                                          maxLength: 32,
                                          readOnly: !state.isEdit,
                                        ))
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                              ],
                            ));
                      }),
                  const Spacer(),
                  GetBuilder<CustomDetailController>(
                      id: 'custom_btn',
                      builder: (controller) {
                        return Flex(
                          direction: Axis.horizontal,
                          children: [
                            Visibility(
                                visible: state.isEdit,
                                child: Expanded(
                                  child: ElevatedBtn(
                                    elevation: 5,
                                    margin: EdgeInsets.only(top: 80.w),
                                    size: Size(double.infinity, 90.w),
                                    onPressed: () =>
                                        controller.toInvalidCustom(),
                                    radius: 15.w,
                                    backgroundColor: Colors.white,
                                    text: state.customDTO?.invalid == 0
                                        ? '停用客户'
                                        : '启用此客户',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                            Visibility(
                                visible: state.isEdit,
                                child: Expanded(
                                  child: ElevatedBtn(
                                    margin: EdgeInsets.only(top: 80.w),
                                    size: Size(double.infinity, 90.w),
                                    onPressed: () {
                                      (state.formKey.currentState
                                                  ?.saveAndValidate() ??
                                              false)
                                          ? controller.updateCustom()
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
                                ))
                          ],
                        );
                      }),
                ]),
              ),
            )));
  }
}

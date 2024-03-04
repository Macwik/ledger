import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/will_pop.dart';

import 'employee_controller.dart';

class EmployeeView extends StatelessWidget {
  final controller = Get.find<EmployeeController>();
  final state = Get.find<EmployeeController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '员工详情',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => controller.employeeGetBack(),
        ),
        actions: [
          GetBuilder<EmployeeController>(
              id: 'employee_edit',
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
                      SizedBox(
                        width: 25.w,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.employeeGetBack();
            return true;
          },
          child: FormBuilder(
            key: state.formKey,
            child: Column(children: [
                Expanded(
                    child: ListView(
                  children: [
                    GetBuilder<EmployeeController>(
                        id: 'employee_detail',
                        builder: (_) {
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                top: 30.w,
                                left: 40.w,
                                right: 40.w,
                                bottom: 20.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      state.ledgerUserDetailDTO?.userBaseDTO
                                              ?.username ??
                                          '',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: state.isEdit == true
                                              ? Colours.text_999
                                              : Colours.text_333,
                                          fontSize: 30.sp),
                                    ))
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  margin:
                                      EdgeInsets.only(top: 20.w, bottom: 20.w),
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '手机号',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 32.sp,
                                      ),
                                    )),
                                    Expanded(
                                        child: Text(
                                      state.ledgerUserDetailDTO?.userBaseDTO
                                              ?.phone ??
                                          '',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: state.isEdit == true
                                              ? Colours.text_999
                                              : Colours.text_333,
                                          fontSize: 30.sp),
                                    ))
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  margin:
                                      EdgeInsets.only(bottom: 20.w, top: 20.w),
                                  width: double.infinity,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.select();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        '员工岗位',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(state.roleName ?? '请选择',
                                          style: TextStyle(
                                            fontSize: 32.sp,
                                            color: state.roleName != null
                                                ? Colours.text_333
                                                : Colours.text_ccc,
                                          )),
                                      Visibility(
                                          visible: state.isEdit,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: LoadAssetImage(
                                              'common/arrow_right',
                                              width: 25.w,
                                              color: Colours.text_999,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  margin:
                                      EdgeInsets.only(bottom: 20.w, top: 20.w),
                                  width: double.infinity,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '入职日期',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 32.sp,
                                      ),
                                    )),
                                    Expanded(
                                        child: InkWell(
                                            onTap: () {
                                              if (state.isEdit == true) {
                                                controller.pickerDate(context);
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                state.date == null
                                                    ? ''
                                                    : DateUtil
                                                        .formatDefaultDate(
                                                            state.date!),
                                                style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))),
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  margin: EdgeInsets.only(top: 20.w),
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<EmployeeController>(
                      id: 'employee_btn',
                      builder: (logic) {
                        return Row(
                          children: [
                            Visibility(
                              visible: state.isEdit,
                              child: Expanded(
                                child: ElevatedBtn(
                                  onPressed: () =>
                                      controller.toDeleteEmployee(),
                                  margin: EdgeInsets.only(top: 80.w),
                                  size: Size(double.infinity, 90.w),
                                  radius: 15.w,
                                  backgroundColor: Colors.white,
                                  text: '删除员工',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: state.isEdit,
                                child: Expanded(
                                  child: ElevatedBtn(
                                    onPressed: () =>
                                        controller.updateEmployee(),
                                    margin: EdgeInsets.only(top: 80.w),
                                    size: Size(double.infinity, 90.w),
                                    radius: 15.w,
                                    backgroundColor: Colours.primary,
                                    text: '保存',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      }),
                )
              ]),
          )),
    );
  }
}

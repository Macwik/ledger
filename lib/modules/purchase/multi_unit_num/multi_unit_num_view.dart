import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/purchase/multi_unit_num/option_item.dart';
import 'package:ledger/res/export.dart';
import 'multi_unit_num_controller.dart';

class MultiUnitNumView extends StatelessWidget {
  MultiUnitNumView({super.key});

  final controller = Get.find<MultiUnitNumController>();
  final state = Get.find<MultiUnitNumController>().state;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: state.unitType - 1,
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TitleBar(
            backPressed: ()=>Get.back(),
              bottomWidget: TabBar(
                onTap: (index) => controller.switchTab(index),
                dividerColor: Colours.bg,
                indicatorWeight: 3.w,
                indicatorPadding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(0),
                isScrollable: false,
                indicatorColor: Colours.primary,
                unselectedLabelColor: Colours.text_999,
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelColor: Colours.primary,
                tabs: [
                  Tab(
                      child: Text(
                    '计重单位',
                    style: TextStyle(color: Colours.text_333, fontSize: 30.w),
                  )),
                  Tab(
                      child: Text(
                    '计件单位',
                    style: TextStyle(color: Colours.text_333, fontSize: 30.w),
                  )),
                ],
              )),
          body: TabBarView(
            children: [
              FormBuilder(
                key: state.formKeyWeight,
                onChanged: controller.onFormWeightChange,
                child: GestureDetector(
                  //behavior: HitTestBehavior.translucent,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: 20.w, left: 40.w, right: 40.w, bottom: 20.w),
                        child: Column(
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  '计重单位',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GetBuilder<MultiUnitNumController>(
                                      id: 'select_master_unit',
                                      builder: (_) {
                                        return DropdownButton<OptionItem>(
                                          value: state.selectedMasterOption,
                                          hint: Text(state
                                                  .selectedMasterOption?.name ??
                                              '请选择'),
                                          underline: Container(
                                            height: 0.w,
                                          ),
                                          icon:
                                              Icon(Icons.keyboard_arrow_right),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (value) {
                                            controller.selectMasterUnit(value!);
                                          },
                                          items: state.conversionOptions.map(
                                              (OptionItem conversionOptions) {
                                            return DropdownMenuItem<OptionItem>(
                                              value: conversionOptions,
                                              child: Text(conversionOptions.name ?? ''),
                                            );
                                          }).toList(),
                                        );
                                      }),
                                ))
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              height: 1.w,
                              width: double.infinity,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  '计数单位',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GetBuilder<MultiUnitNumController>(
                                          id: 'select_slave_unit',
                                          builder: (_) {
                                            return DropdownButton<OptionItem>(
                                              alignment: Alignment.centerRight,
                                              value: state.selectedSlaveOption,
                                              hint: Text('请选择'),
                                              underline: Container(
                                                height: 0.w,
                                              ),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (value) {
                                                controller
                                                    .selectSlaveUnit(value!);
                                              },
                                              items: state.options
                                                  .map((OptionItem option) {
                                                return DropdownMenuItem<
                                                    OptionItem>(
                                                  value: option,
                                                  child: Text(
                                                      option.name.toString()),
                                                );
                                              }).toList(),
                                            );
                                          }),
                                    )),
                              ],
                            ),
                            Container(
                              color: Colours.divider,
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              height: 1.w,
                              width: double.infinity,
                            ),
                            GetBuilder<MultiUnitNumController>(
                                id: 'conversion_unit',
                                builder: (_) {
                                  return Row(
                                    children: [
                                      Text(
                                        '换算量',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                      ),
                                      Text(
                                        state.selectedSlaveOption?.name != null
                                            ? '1${state.selectedSlaveOption?.name}='
                                            : '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                      Flexible(
                                          child: TextFormField(
                                            controller: state.conversionWeightController,
                                            decoration: InputDecoration(
                                              counterText: '',
                                              border: InputBorder.none,
                                              hintText: '换算量，如：一箱等于10斤',
                                            ),
                                            style: TextStyle(
                                                fontSize: 28.sp
                                            ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLength: 7,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: '换算量不能为空！'),
                                          (value) {
                                            var num = Decimal.tryParse(value!);
                                            if (null == num) {
                                              return '请正确输入换算值！';
                                            } else if (num <= Decimal.zero) {
                                              return '换算值不能小于等于0';
                                            }
                                            return null;
                                          },
                                        ]),
                                      )),
                                      Text(
                                        state.selectedMasterOption?.name ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            Container(
                              color: Colours.divider,
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              height: 1.w,
                              width: double.infinity,
                            ),
                            Container(
                              height: 120.w,
                              width: double.infinity,
                              child: Text(
                                '如：一箱牛奶有30包；牛奶的主单位就是包，辅助单位就是箱，换算量就是30。',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 24.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        child: GetBuilder<MultiUnitNumController>(
                            id: 'submitBtn',
                            builder: (controller) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: ElevatedBtn(
                                      margin: EdgeInsets.only(top: 80.w),
                                      size: Size(double.infinity, 90.w),
                                      onPressed: () => Get.back(),
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
                                      onPressed: () => (state.formKeyWeight.currentState?.saveAndValidate() ?? false)
                                          ? controller.addUnit()
                                          : null,
                                      radius: 15.w,
                                      backgroundColor: Colours.primary,
                                      text: '选好了',
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
                    ],
                  ),
                ),
              ),
              FormBuilder(
                  key: state.formKeyNum,
                  onChanged: () => controller.onFormNumChange(),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                top: 20.w,
                                left: 40.w,
                                right: 40.w,
                                bottom: 20.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '主单位',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.sp,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: GetBuilder<
                                                  MultiUnitNumController>(
                                              id: 'select_master_unit',
                                              builder: (_) {
                                                return DropdownButton<
                                                    OptionItem>(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  value: state
                                                      .selectedMasterOption,
                                                  hint: Text('请选择'),
                                                  underline: Container(
                                                    height: 0.w,
                                                  ),
                                                  icon: Icon(Icons
                                                      .keyboard_arrow_right),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  onChanged: (value) {
                                                    controller.selectMasterUnit(
                                                        value!);
                                                  },
                                                  items: state.options
                                                      .map((OptionItem option) {
                                                    return DropdownMenuItem<
                                                        OptionItem>(
                                                      value: option,
                                                      child: Text(option.name
                                                          .toString()),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                        )),
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '辅助单位',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.sp,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: GetBuilder<
                                                  MultiUnitNumController>(
                                              id: 'select_slave_unit',
                                              builder: (_) {
                                                return DropdownButton<
                                                    OptionItem>(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  value:
                                                      state.selectedSlaveOption,
                                                  hint: Text('请选择'),
                                                  underline: Container(
                                                    height: 0.w,
                                                  ),
                                                  icon: Icon(Icons
                                                      .keyboard_arrow_right),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  onChanged: (value) {
                                                    controller.selectSlaveUnit(
                                                        value!);
                                                  },
                                                  items: state.options
                                                      .map((OptionItem option) {
                                                    return DropdownMenuItem<
                                                        OptionItem>(
                                                      value: option,
                                                      child: Text(option.name
                                                          .toString()),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                        )),
                                  ],
                                ),
                                Container(
                                  color: Colours.divider,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                GetBuilder<MultiUnitNumController>(
                                    id: 'conversion_unit',
                                    builder: (_) {
                                      return Row(
                                        children: [
                                          Text(
                                            '换算量',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50.w,
                                          ),
                                          Text(
                                            state.selectedSlaveOption?.name !=
                                                    null
                                                ? '1${state.selectedSlaveOption?.name}='
                                                : '',
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 30.sp,
                                            ),
                                          ),
                                          Expanded(
                                              child: TextFormField(
                                                controller: state.conversionNumController,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border: InputBorder.none,
                                                  hintText: '换算量，如：一件等于10袋',
                                                ),
                                                style: TextStyle(
                                                    fontSize: 28.sp
                                                ),
                                            textAlign: TextAlign.center,
                                            maxLength: 7,
                                            keyboardType: TextInputType.number,
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                  errorText: '换算量不能为空！'),
                                              (value) {
                                                var num = Decimal.tryParse(value!);
                                                if (null == num) {
                                                  return '请正确输入换算值！';
                                                } else if (num <= Decimal.zero) {
                                                  return '换算值不能小于等于0';
                                                }
                                                return null;
                                              },
                                            ]),
                                          )),
                                          Text(
                                            state.selectedMasterOption?.name ??
                                                '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.sp,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                Container(
                                  color: Colours.divider,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  height: 1.w,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: 120.w,
                                  width: double.infinity,
                                  child: Text(
                                    '如：一箱牛奶有30包；牛奶的主单位就是包，辅助单位就是箱，换算量就是30。',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          child: GetBuilder<MultiUnitNumController>(
                              id: 'submitBtn',
                              builder: (logic) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedBtn(
                                        margin: EdgeInsets.only(top: 80.w),
                                        size: Size(double.infinity, 90.w),
                                        onPressed: () => Get.back(),
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
                                        onPressed: () =>   (state.formKeyNum.currentState?.saveAndValidate() ?? false)
                                            ? controller.addUnit()
                                            : null,
                                        radius: 15.w,
                                        backgroundColor: Colours.primary,
                                        text: '选好了',
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
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}

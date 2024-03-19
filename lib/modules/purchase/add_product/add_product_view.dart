import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/will_pop.dart';

import 'add_product_controller.dart';

class AddProductView extends StatelessWidget {
  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '添加货物'.tr,
        backPressed: () => controller.addProductGetBack() ,
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.addProductGetBack();
            return true;
          },
          child: FormBuilder(
            key: controller.state.formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(
                child: ListView(
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Text(
                                      '* ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                      '货物名称',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                                Expanded(
                                  child: TextFormField(
                                      controller: controller
                                          .state.textEditingController,
                                      textAlign: TextAlign.right,
                                      maxLength: 10,
                                      style: TextStyle(fontSize: 30.sp),
                                      decoration: InputDecoration(
                                          counterText: '',
                                          hintText: '请填写',
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      validator: (value) {
                                        var text = controller
                                            .state.textEditingController.text;
                                        if (text.isEmpty) {
                                          return '货物名称不能为空';
                                        }
                                        // 进行其他验证逻辑
                                        return null; // 如果验证成功，返回null
                                      }),
                                ),
                              ],
                            )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 30.w),
                            child: InkWell(
                                onTap: () => controller.toProductUnit(),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '* ',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          '单位',
                                          style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GetBuilder<AddProductController>(
                                      id: 'productUnit',
                                      init: controller,
                                      global: false,
                                      builder: (_) {
                                        return Text(
                                            controller.getUnitDisplay() ??
                                                '请选择',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: controller.state
                                                          .unitDetailDTO !=
                                                      null
                                                  ? Colors.black87
                                                  : Colors.black26,
                                            ));
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: LoadAssetImage(
                                        'common/arrow_right',
                                        width: 25.w,
                                        color: Colours.text_999,
                                      ),
                                    ),
                                  ],
                                ))),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Text(
                                  '产地',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )),
                                Expanded(
                                    child: TextFormField(
                                  controller: controller
                                      .state.productPlaceTextEditingController,
                                  textAlign: TextAlign.right,
                                  maxLength: 10,
                                  style: TextStyle(fontSize: 30.sp),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      hintText: '请填写',
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                )),
                              ],
                            )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Text(
                                  '规格',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )),
                                Expanded(
                                    child: TextFormField(
                                  controller: controller
                                      .state.standardTextEditingController,
                                  textAlign: TextAlign.right,
                                  maxLength: 10,
                                  style: TextStyle(fontSize: 30.sp),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      hintText: '请填写',
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                )),
                              ],
                            )),
                        Container(
                          color: Colours.bg,
                          height: 16.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 30.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  '货物分类',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () =>
                                      controller.selectProductClassify(),
                                  child: Row(children: [
                                    GetBuilder<AddProductController>(
                                        id: 'productClassify',
                                        init: controller,
                                        global: false,
                                        builder: (_) => Text(
                                            controller.state.productClassifyDTO
                                                    ?.productClassify ??
                                                '请选择',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: controller
                                                          .state
                                                          .productClassifyDTO
                                                          ?.productClassify !=
                                                      null
                                                  ? Colours.text_333
                                                  : Colours.text_ccc,
                                            ))),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: LoadAssetImage(
                                        'common/arrow_right',
                                        width: 25.w,
                                        color: Colours.text_999,
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            )),
                        Container(
                          color: Colours.bg,
                          height: 16.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Text(
                                  '销售单价',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )),
                                Expanded(
                                    child: TextFormField(
                                  controller: controller
                                      .state.priceTextEditingController,
                                  textAlign: TextAlign.right,
                                  maxLength: 10,
                                  style: TextStyle(fontSize: 30.sp),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      hintText: '请填写',
                                      border: InputBorder.none),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true, signed: true),
                                  validator: (value) {
                                    if ((null == value) || value.isEmpty) {
                                      return null; // 非必填项目为空时不进行验证
                                    }
                                    var repaymentAmount =
                                        Decimal.tryParse(value);
                                    if (null == repaymentAmount) {
                                      return '请正确输入单价';
                                    } else if (repaymentAmount <=
                                        Decimal.zero) {
                                      return '销售单价不能小于等于0';
                                    }
                                    return null;
                                  },
                                )),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text('元')),
                              ],
                            )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 30.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  '供应商',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () => controller.selectCustom(),
                                  child: Row(children: [
                                    GetBuilder<AddProductController>(
                                        id: 'custom',
                                        init: controller,
                                        global: false,
                                        builder: (_) => Text(
                                            controller.state.customDTO
                                                    ?.customName ??
                                                '请选择',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: controller.state.customDTO
                                                          ?.customName !=
                                                      null
                                                  ? Colours.text_333
                                                  : Colours.text_ccc,
                                            ))),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: LoadAssetImage(
                                        'common/arrow_right',
                                        width: 25.w,
                                        color: Colours.text_999,
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '销售类型',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )),
                                GetBuilder<AddProductController>(
                                  id: 'saleType',
                                  init: controller,
                                  global: false,
                                  builder: (controller) => ButtonBar(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            controller.changeSalesChannel(0),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: controller
                                                  .isSelectedSalesChannel(0)
                                              ? Colours.primary
                                              : Colors.white,
                                          foregroundColor: controller
                                                  .isSelectedSalesChannel(0)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        child: Text('自营',
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                            )),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            controller.changeSalesChannel(1),
                                        child: Text('代办',
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                            )),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: controller
                                                  .isSelectedSalesChannel(1)
                                              ? Colours.primary
                                              : Colors.white,
                                          foregroundColor: controller
                                                  .isSelectedSalesChannel(1)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            controller.changeSalesChannel(2),
                                        child: Text('联营',
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                            )),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: controller
                                                  .isSelectedSalesChannel(2)
                                              ? Colours.primary
                                              : Colors.white,
                                          foregroundColor: controller
                                                  .isSelectedSalesChannel(2)
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
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 16.w),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Text(
                                  '备注',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )),
                                Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: controller
                                          .state.remarkTextEditingController,
                                      textAlign: TextAlign.right,
                                      maxLength: 32,
                                      style: TextStyle(fontSize: 30.sp),
                                      decoration: InputDecoration(
                                          counterText: '',
                                          hintText: '请填写',
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                    )),
                              ],
                            )),
                        Container(
                          color: Colours.divider,
                          height: 1.w,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GetBuilder<AddProductController>(
                  id: 'submitBtn',
                  init: controller,
                  global: false,
                  builder: (logic) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedBtn(
                            size: Size(double.infinity, 100.w),
                            onPressed: () => controller.addProductGetBack(),
                            radius: 15.w,
                            backgroundColor: Colors.white,
                            text: '取消',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 6,
                          ),
                        ),
                        Expanded(
                          child: ElevatedBtn(
                            size: Size(double.infinity, 100.w),
                            onPressed: () => controller.addProduct(),
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
          )),
    );
  }
}

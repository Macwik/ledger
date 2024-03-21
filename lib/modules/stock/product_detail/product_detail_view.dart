import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'product_detail_controller.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});

  final controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        backPressed: ()=>controller.productDetailGetBack(),
        title: '货物资料'.tr,
        actionWidget:
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: InkWell(
                  child: GetBuilder<ProductDetailController>(
                      id: 'product_detail_edit',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return PermissionWidget(
                            permissionCode: PermissionCode
                                .product_detail_product_detail_permission,
                            child: Visibility(
                              visible: !controller.state.isEdit,
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
                      })),
            ),
          ])
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.productDetailGetBack();
            return true;
          },
          child: FormBuilder(
            key: controller.state.formKey,
            child: GetBuilder<ProductDetailController>(
              id: 'product_detail_body',
              init: controller,
              global: false,
              builder: (_) {
                return Column(children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 20.w),
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
                                            fontSize: 30.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                      visible: controller.state.productDetailDTO
                                              ?.invalid ==
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
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                        controller: controller.state.nameController,
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
                                        readOnly: !controller.state.isEdit,
                                        validator: (value) {
                                          var text = controller
                                              .state.nameController.text;
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
                                  horizontal: 40.w, vertical: 40.w),
                              child: Flex(
                                direction: Axis.horizontal,
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
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.judgeUnit(
                                        controller.state.productDetailDTO),
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        color: controller.state.isEdit == true
                                            ? Colours.text_999
                                            : Colours.text_333),
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
                                  horizontal: 40.w, vertical: 20.w),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child: Text(
                                    '产地',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                    ),
                                  )),
                                  Expanded(
                                      child: TextFormField(
                                    controller:
                                        controller.state.addressController,
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
                                    maxLength: 10,
                                    readOnly: !controller.state.isEdit,
                                  ))
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
                                  horizontal: 40.w, vertical: 20.w),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child: Text(
                                    '规格',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                    ),
                                  )),
                                  Expanded(
                                      child: TextFormField(
                                    controller:
                                        controller.state.standardController,
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
                                    maxLength: 10,
                                    readOnly: !controller.state.isEdit,
                                  ))
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
                                    onTap: () {
                                      if (controller.state.isEdit) {
                                        controller.selectProductClassify();
                                      }
                                    },
                                    child: Row(children: [
                                      Text(
                                          controller
                                                  .state.productClassifyName ??
                                              '请选择',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: controller.state
                                                        .productClassifyName !=
                                                    null
                                                ? Colours.text_333
                                                : Colours.text_ccc,
                                          )),
                                      Visibility(
                                          visible: controller.state.isEdit,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: LoadAssetImage(
                                              'common/arrow_right',
                                              width: 25.w,
                                              color: Colours.text_999,
                                            ),
                                          )),
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
                                  horizontal: 40.w, vertical: 20.w),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child: Text(
                                    '销售单价',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                    ),
                                  )),
                                  Expanded(
                                      child: TextFormField(
                                    controller:
                                        controller.state.priceController,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                          hintText: '请填写',
                                        ),
                                        style: TextStyle(
                                            fontSize: 32.sp
                                        ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    readOnly: !controller.state.isEdit,
                                  )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(controller.getPriceUnit(
                                          controller.state.productDetailDTO))),
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
                                  horizontal: 40.w, vertical: 40.w),
                              child: InkWell(
                                  onTap: () {
                                    if (controller.state.isEdit) {
                                      controller.selectCustom();
                                    }
                                  },
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '供应商',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                        controller.state.supplier ?? '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 30.sp,
                                        ),
                                      )),
                                      Visibility(
                                        visible: controller.state.isEdit,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: LoadAssetImage(
                                            'common/arrow_right',
                                            width: 25.w,
                                            color: Colours.text_999,
                                          ),
                                        ),
                                      )
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
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '销售类型',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                    ),
                                  )),
                                  ButtonBar(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (controller.state.isEdit) {
                                            controller.changeSalesType(0);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controller.isSelectedSalesType(0)
                                                  ? Colours.primary
                                                  : Colors.white,
                                          foregroundColor:
                                              controller.isSelectedSalesType(0)
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                        child: Text('自营',
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                            )),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (controller.state.isEdit) {
                                            controller.changeSalesType(1);
                                          }
                                        },
                                        child: Text('代办'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controller.isSelectedSalesType(1)
                                                  ? Colours.primary
                                                  : Colors.white,
                                          foregroundColor:
                                              controller.isSelectedSalesType(1)
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (controller.state.isEdit) {
                                            controller.changeSalesType(2);
                                          }
                                        },
                                        child: Text('联营'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controller.isSelectedSalesType(2)
                                                  ? Colours.primary
                                                  : Colors.white,
                                          foregroundColor:
                                              controller.isSelectedSalesType(2)
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ],
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
                                horizontal: 40.w,
                              ),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Container(
                                        child: Text(
                                      '备注',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 30.sp,
                                      ),
                                    )),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        controller:
                                            controller.state.remarkController,
                                        style: TextStyle(fontSize: 30.sp),
                                        maxLines: 8,
                                        minLines: 1,
                                        keyboardType:
                                            TextInputType.name,
                                        textAlign: TextAlign.right,
                                        maxLength: 32,
                                        readOnly: !controller.state.isEdit,
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
                  )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.state.isEdit,
                            child: Expanded(
                              child: ElevatedBtn(
                                size: Size(double.infinity, 90.w),
                                onPressed: () =>
                                    controller.productDetailGetBack(),
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
                          ),
                          Visibility(
                              visible: controller.state.isEdit,
                              child: Expanded(
                                child: ElevatedBtn(
                                  size: Size(double.infinity, 90.w),
                                  onPressed: () => controller.updateProduct(),
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
                      )),
                ]);
              },
            ),
          )),
    );
  }
}

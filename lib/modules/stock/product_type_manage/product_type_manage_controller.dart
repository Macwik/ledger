import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'product_type_manage_state.dart';

class ProductTypeManageController extends GetxController {
  final ProductTypeManageState state = ProductTypeManageState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['isSelect'] != null) {
      state.isSelectType = arguments['isSelect'];
    }
    _queryProductClassifyList();
  }

  Future<void> _queryProductClassifyList() async {
    final result = await Http().network<List<ProductClassifyDTO>>(
        Method.get, ProductApi.product_classify_product_list);
    if (result.success) {
      state.productClassifyList = result.d!;
      update(['product_classify_item']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void showBottomSheet(
      BuildContext context, ProductClassifyDTO? productClassify) {
    List<Widget> actions = [];
    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        toDeleteProduct(productClassify?.id);
      },
      child: Text('删除'),
      isDestructiveAction: true,
    ));

    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        toEditProductClassify(productClassify);
      },
      child: Text('编辑'),
    ));

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
        );
      },
    );
  }

  void toDeleteProduct(int? id) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此分组类型吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          Http().network(Method.delete, ProductApi.product_classify_delete,
              queryParameters: {
                'id': id,
              }).then((result) {
            if (result.success) {
              _queryProductClassifyList();
              Toast.show('删除成功');
              Get.back();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void toEditProductClassify(ProductClassifyDTO? productClassify) {
    Get.dialog(
      AlertDialog(
          title: Text('编辑货物分组',
              style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w600)),
          content: FormBuilder(
              key: state.formKey,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Text('名称',
                          style: TextStyle(
                              fontSize: 34.sp, fontWeight: FontWeight.w500)),
                      Expanded(
                          child: TextFormField(
                              controller: state.productClassifyNameController,
                              maxLength: 8,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: productClassify?.productClassify ??
                                    '货物分组名称',
                                hintStyle: TextStyle(fontSize: 32.sp),
                              ),
                              validator: FormBuilderValidators.required(
                                  errorText: '货物分组名称不能为空'),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text))
                    ],
                  ),
                  Row(
                    children: [
                      Text('备注',
                          style: TextStyle(
                              fontSize: 34.sp, fontWeight: FontWeight.w500)),
                      Expanded(
                          child: TextFormField(
                              controller: state.productClassifyRemarkController,
                              maxLength: 20,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: '货物分组备注',
                                hintStyle: TextStyle(fontSize: 32.sp),
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text))
                    ],
                  )
                ],
              ))),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                  state.productClassifyRemarkController.clear();
                  state.productClassifyNameController.clear();
                },
                child: Text('取消')),
            TextButton(
              child: Text('确定'),
              onPressed: () async {
                (state.formKey.currentState?.saveAndValidate() ?? false)
                    ? editProductType(productClassify)
                    : Null;
                state.productClassifyRemarkController.clear();
                state.productClassifyNameController.clear();
              },
            ),
          ]),
      barrierDismissible: false,
    );
  }

  void addProductClassify(BuildContext context) {
    Get.dialog(
      AlertDialog(
          title: Text('新增货物分组'),
          content: FormBuilder(
              key: state.formKey,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text('名称'),
                      Expanded(
                        child: TextFormField(
                            controller: state.addProductClassifyName,
                            maxLength: 10,
                            decoration: InputDecoration(
                                hintText: '货物分组名称',
                                counterText: '',
                                hintStyle: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500)),
                            validator: FormBuilderValidators.required(
                                errorText: '货物分组名称不能为空'),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text),
                      )
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text('备注'),
                      Expanded(
                        child: TextFormField(
                            controller: state.addProductClassifyRemark,
                            maxLength: 20,
                            decoration: InputDecoration(
                                hintText: '货物分组备注',
                                counterText: '',
                                hintStyle: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500)),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text),
                      )
                    ],
                  )
                ],
              ))),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                state.addProductClassifyRemark.clear();
                state.addProductClassifyName.clear();
              },
              child: Text(
                '取消',
                style: TextStyle(color: Colours.text_666),
              ),
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () async {
                (state.formKey.currentState?.saveAndValidate() ?? false)
                    ? addProductType()
                    : Null;
                state.addProductClassifyRemark.clear();
                state.addProductClassifyName.clear();
              },
            ),
          ]),
      barrierDismissible: false,
    );
  }

  void selectProductClassify(ProductClassifyDTO? productClassify) {
    if (state.isSelectType == IsSelectType.TRUE) {
      Get.back(result: productClassify);
    }
  }

  Future<void> editProductType(ProductClassifyDTO? productClassify) async {
    final result = await Http()
        .network<void>(Method.post, ProductApi.product_classify_edit, data: {
      'id': productClassify?.id,
      'productClassify': state.productClassifyNameController.text,
      'remark': state.productClassifyRemarkController.text,
    });
    if (result.success) {
      Toast.show('保存成功');
      Get.back();
      _queryProductClassifyList();
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> addProductType() async {
    final result = await Http()
        .network<void>(Method.post, ProductApi.product_classify_add, data: {
      'productClassify': state.addProductClassifyName.text,
      'remark': state.addProductClassifyRemark.text,
    });
    if (result.success) {
      Toast.show('保存成功');
      Get.back();
      _queryProductClassifyList();
    } else {
      Toast.show(result.m.toString());
    }
  }

  void updateProductClassify(int oldIndex, int newIndex) {
    state.productClassifyList!
        .insert(newIndex, state.productClassifyList!.removeAt(oldIndex));
    updateProductClassifyOrdinal();
    update(['product_classify_item']);
  }

  updateProductClassifyOrdinal() async {
    final result = await Http().network<void>(
        Method.put, ProductApi.product_classify_ordinal_update,
        data: state.productClassifyList);
    if (!result.success) {
      Toast.showError(result.m.toString());
    }
  }
}

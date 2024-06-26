import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/res/export.dart';

import 'add_product_state.dart';

class AddProductController extends GetxController {
  final AddProductState state = AddProductState();

  Future<void> toProductUnit() async {
    var result = await Get.toNamed(RouteConfig.unit, arguments: {'mode': 1});
    if (result != null) {
      state.unitDetailDTO = result;
      update(['productUnit']);
    }
  }

  void addProduct() {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    String? productName = state.textEditingController.text;
    String? productPlace = state.productPlaceTextEditingController.text;
    String? standard = state.standardTextEditingController.text;
    String? productPrice = state.priceTextEditingController.text;
    String productRemark = state.remarkTextEditingController.text;
    if (null == state.unitDetailDTO?.unitName &&
        null == state.unitDetailDTO?.masterUnitName &&
        null == state.unitDetailDTO?.slaveUnitName) {
      Toast.show('请填写货物单位');
      return;
    }
    if((state.saleChannel == 1)&&((state.supplierDTO?.supplierName?.isEmpty??false)||(state.supplierDTO == null))){
      Toast.show('请选择货主');
      return;
    }
    Loading.showDuration();
    Http().network(Method.post, ProductApi.addProduct, data: {
      'productName': productName,
      'productStandard': standard,
      'productPlace': productPlace,
      'unitType': state.unitDetailDTO?.unitType,
      'unitGroupId': state.unitDetailDTO?.unitGroupId,
      'unitId': state.unitDetailDTO?.unitId,
      'unitName': state.unitDetailDTO?.unitName,
      'selectMasterUnit': state.unitDetailDTO?.selectMasterUnit,
      'price': state.unitDetailDTO?.unitType == UnitType.SINGLE.value
          ? productPrice.isEmpty
              ? null
              : Decimal.tryParse(productPrice)
          : null,
      'masterPrice': state.unitDetailDTO?.unitType != UnitType.SINGLE.value
          ? productPrice.isEmpty
              ? null
              : Decimal.tryParse(productPrice)
          : null,
      'slavePrice': null,
      'remark': productRemark,
      'supplier': state.saleChannel ==1 ?state.supplierDTO?.id:null,
      'salesChannel': state.saleChannel,
      'productClassify': state.productClassifyDTO?.id,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back(result: ProcessStatus.OK);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void changeSalesChannel(int index) {
    state.saleChannel = index;
    update(['saleType','custom']);
  }

  bool isSelectedSalesChannel(int index) {
    return state.saleChannel == index;
  }

  Future<void> selectCustom() async {
    if(state.saleChannel == 1){
      var result = await Get.toNamed(RouteConfig.productOwnerList);
      if (result != null) {
        state.supplierDTO = result;
        update(['custom']);
      }
    }else{
      var result = await Get.toNamed(RouteConfig.chooseCustom,
          arguments: {'customType': CustomType.SUPPLIER.value, 'isSelectCustom': true});
      if (result != null) {
        state.customDTO = result;
        update(['custom']);
      }
    }
  }

  String? getUnitDisplay() {
    var unitDetailDTO = state.unitDetailDTO;
    if (unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return unitDetailDTO?.unitName;
    }
    return unitDetailDTO != null
        ? '${unitDetailDTO.conversion} ${unitDetailDTO.masterUnitName} | ${unitDetailDTO.slaveUnitName}'
        : null;
  }

  void addProductGetBack() {
    String? productName = state.textEditingController.text;
    String? productPlace =
        state.formKey.currentState?.fields['productPlace']?.value;
    String? standard =
        state.formKey.currentState?.fields['productStandard']?.value;
    String? productPrice =
        state.formKey.currentState?.fields['productPrice']?.value;
    String? productRemark =
        state.formKey.currentState?.fields['productRemark']?.value;
    if ((state.unitDetailDTO != null) ||
        (state.customDTO != null) ||
        (productName.isNotEmpty) ||
        (productPlace?.isNotEmpty ?? false) ||
        (standard?.isNotEmpty ?? false) ||
        (productPrice?.isNotEmpty ?? false) ||
        (productRemark?.isNotEmpty ?? false)) {
      Get.dialog(AlertDialog(
          title: Text('是否确认退出'),
          content: Text('退出后将无法恢复'),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
                child: Text('确定'),
                onPressed: () {
                  Get.back();
                  Get.back();
                }),
          ]));
    } else {
      Get.back();
    }
  }

  Future<void> selectProductClassify() async {
    var result = await Get.toNamed(RouteConfig.productTypeManage,
        arguments: {'isSelect': IsSelectType.TRUE});
    if (result != null) {
      state.productClassifyDTO = result;
      update(['productClassify']);
    }
  }

}

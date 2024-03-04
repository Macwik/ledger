import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/product/product_detail_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'product_detail_state.dart';

class ProductDetailController extends GetxController {
  final ProductDetailState state = ProductDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['id'] != null) {
      state.id = arguments['id'];
    }
    _queryData();
  }

  _queryData() {
    Http().network<ProductDetailDTO>(Method.get, ProductApi.productDetail,
        queryParameters: {'id': state.id}).then((result) {
      if (result.success) {
        state.productDetailDTO = result.d;
        state.productType = result.d?.productType;
        state.productTypeDesc = result.d?.productTypeDesc;
        state.supplier = result.d?.supplierName;
        state.supplierId = result.d?.supplier;
        state.nameController.text = result.d?.productName ?? '';
        state.productClassifyName = result.d?.productClassifyName;
        state.productClassifyId = result.d?.productClassify;
        state.selectedSalesType = result.d?.salesChannel;
        state.addressController.text = result.d?.productPlace ?? '';
        state.standardController.text = result.d?.productStandard ?? '';
        if (state.productDetailDTO?.unitDetailDTO?.unitType ==
            UnitType.SINGLE.value) {
          state.priceController.text =
              DecimalUtil.formatDecimalNumber(result.d?.unitDetailDTO?.price);
        } else {
          state.priceController.text = DecimalUtil.formatDecimalNumber(
              result.d?.unitDetailDTO?.masterPrice);
        }
        state.remarkController.text = result.d?.remark ?? '';
        update([
          'product_detail_body',
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  bool isSelectedSalesType(int index) {
    return state.selectedSalesType == index;
  }

  void onEdit() {
    state.isEdit = !state.isEdit;
    update([
      'product_detail_body',
      'product_detail_edit',
    ]);
  }

  void changeSalesType(int index) {
    state.selectedSalesType = index;
    update(['product_detail_body']);
  }


  Future<void> selectCustom() async {
    await Get.toNamed(RouteConfig.customRecord,
        arguments: {'initialIndex': 1, 'isSelectCustom': true})?.then((value) {
      CustomDTO? result = value as CustomDTO?;
      if (result != null) {
        state.supplierId = result.id;
        state.supplier = result.customName;
        update(['product_detail_body']);
      }
    });
  }

  String judgeUnit(ProductDetailDTO? productDetailDTO) {
    if (null == productDetailDTO) {
      return '-';
    }
    if (productDetailDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${productDetailDTO.unitDetailDTO?.unitName}';
    } else {
      return '${productDetailDTO.unitDetailDTO?.conversion} ${productDetailDTO.unitDetailDTO?.masterUnitName} | ${productDetailDTO.unitDetailDTO?.slaveUnitName}';
    }
  }

  String judgePrice(ProductDetailDTO? productDetailDTO) {
    if (null == productDetailDTO) {
      return '-';
    }
    if (productDetailDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return DecimalUtil.formatDecimal(productDetailDTO.unitDetailDTO?.price,
          scale: 2);
    } else {
      return DecimalUtil.formatDecimal(
          productDetailDTO.unitDetailDTO?.masterPrice,
          scale: 2);
    }
  }

  void updateProduct() {
    Http().network(Method.put, ProductApi.product_detail_update, data: {
      'id': state.productDetailDTO?.id,
      'productType': state.productType,
      'productName': state.nameController.text,
      'productStandard': state.standardController.text,
      'productPlace': state.addressController.text,
      'price': state.productDetailDTO?.unitDetailDTO?.unitType ==
              UnitType.SINGLE.value
          ? Decimal.tryParse(state.priceController.text)
          : null,
      'masterPrice': state.productDetailDTO?.unitDetailDTO?.unitType ==
              UnitType.SINGLE.value
          ? null
          : Decimal.tryParse(state.priceController.text),
      'remark': state.remarkController.text,
      'supplier': state.supplierId,
      'salesChannel': state.selectedSalesType,
      'productClassify': state.productClassifyId,
    }).then((result) {
      if (result.success) {
        state.isEdit = !state.isEdit;
        _queryData();
        update([
          'product_detail_edit',
        ]);
      } else {
        Toast.show('保存失败');
      }
    });
  }

  String getPriceUnit(ProductDetailDTO? productDetailDTO) {
    if (null == productDetailDTO) {
      return '-';
    }
    if (productDetailDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '元/${productDetailDTO.unitDetailDTO?.unitName}';
    } else {
      return '元/${productDetailDTO.unitDetailDTO?.masterUnitName}';
    }
  }

  void productDetailGetBack() {
    if (state.isEdit) {
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
                  Get.back(result: ProcessStatus.OK);
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
      state.productClassifyName = state.productClassifyDTO?.productClassify;
      state.productClassifyId = state.productClassifyDTO?.id;
      update(['product_detail_body']);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/page_to_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/res/export.dart';

import 'stock_change_bill_state.dart';

class StockChangeBillController extends GetxController {
  final StockChangeBillState state = StockChangeBillState();

  Future<void> addStockChange() async {
    var result = await Get.toNamed(RouteConfig.shoppingCar, arguments:{'pageType': PageToType.ADJUST});
    addAdjust(result);
    update(['sale_bill_product_list']);
  }

  void toSubmitOrder() {
    Loading.showDuration();
    Http().network(Method.post, ProductApi.addStockChange, data: {
      'productStockAdjustRequest':state.productStockAdjustRequest
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.offNamed(RouteConfig.stockChangeRecord);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  String judgeUnit(ProductStockAdjustRequest? stockChange) {
    if (null == stockChange) {
      return '-';
    }
    if (stockChange.unitType == UnitType.SINGLE.value) {
      return '${stockChange.stock??'0'} ${stockChange.unitName}';
    } else {
      return '${stockChange.masterStock??'0'} ${stockChange
          .masterUnitName}  |  '
          ' ${stockChange.slaveStock??'0'} ${stockChange.slaveUnitName}';
    }
  }


  void addAdjust(ProductStockAdjustRequest? request) {
    if (null == request) {
      state.visible = false;
      return;
    }
    var result = state.productStockAdjustRequest.firstWhereOrNull((
        element) => element.productId == request.productId);//取出第一个ID和他相同的
    if(null == result) {
      state.visible = true;
      state.productStockAdjustRequest.add(request);
    }else{
      state.visible = true;
      state.productStockAdjustRequest.remove(result);
      state.productStockAdjustRequest.add(request);
    }
    update(['stock_change_product_title']);
  }

  void stockChangeGetBack() {
    if(state.productStockAdjustRequest.isNotEmpty){
      Get.dialog(
        AlertDialog(
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
              },
            ),
          ]));
    }else{
      Get.back();
    }
  }


  void toDeleteOrder(ProductStockAdjustRequest stockAdjust) {
    Get.dialog(
      Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此条吗？',
          onCancel: () {},
          onConfirm: () {
            state.productStockAdjustRequest.remove(stockAdjust);
            update(['sale_bill_product_list', 'sale_bill_btn']);
            Toast.show('删除成功');
          }),
    );
  }


}

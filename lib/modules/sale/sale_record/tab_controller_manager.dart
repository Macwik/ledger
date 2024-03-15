import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/sale/sale_record/sale_record_state.dart';

class TabControllerManager extends GetxController with SingleGetTickerProviderMixin implements DisposableInterface {
  late TabController tabController;
  final SaleRecordState state = SaleRecordState();

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index ==index;
      update(['sale_record_add_bill']);
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose(); // 清理操作
    super.onClose();
  }
}
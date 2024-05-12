import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_cost_detail_state.dart';

class ProductCostDetailController extends GetxController  with GetSingleTickerProviderStateMixin implements DisposableInterface{
  final ProductCostDetailState state = ProductCostDetailState();

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
update(['product_cost_detail']);
    });
    super.onInit();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerManager extends GetxController with SingleGetTickerProviderMixin implements DisposableInterface {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      switch(index){

      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose(); // 清理操作
    super.onClose();
  }
}
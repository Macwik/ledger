import 'package:flutter/animation.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/home/home_binding.dart';
import 'package:ledger/modules/home/home_controller.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_binding.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_controller.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_binding.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_controller.dart';
import 'package:ledger/modules/setting/mine/mine_binding.dart';
import 'package:ledger/modules/setting/mine/mine_controller.dart';
import 'package:ledger/store/store_controller.dart';

import 'main_state.dart';

class MainController extends GetxController {
  final MainState state = MainState();

  int getSelectIndex() => state.selectedIndex.value;

  @override
  void onInit() {
    FlutterBugly.init(
      androidAppId: '8441e68dc5',
      iOSAppId: 'e3ec751bd3',
    );
    FlutterBugly.setAppChannel('Android');
    FlutterBugly.setUserId(StoreController.to.getUser()?.toString() ?? '');
    FlutterBugly.putUserData(
        key: 'user', value: StoreController.to.getUser()?.toString() ?? '');
    super.onInit();
  }

  void selectTab(int currentIndex) async {
    state.selectedIndex.value = currentIndex;
    state.pageController
        .animateToPage(currentIndex,
            duration: Duration(milliseconds: 300), // 动画持续时间
            curve: Curves.ease)
        .then((value) {
      updatePage();
    }); // 动画曲线，例如 Curves.easeInOut);
    update(['bottomBar']);
  }

  void updatePage() {
    StoreController.to.updatePermissionCode();
    switch (getSelectIndex()) {
      case 0:
        HomeBinding().dependencies();
        var homeController = Get.find<HomeController>();
        homeController.initState();
        break;
      case 1:
        CustomRecordBinding().dependencies();
        var customRecordController = Get.find<CustomRecordController>();
        customRecordController.initState();
        break;
      case 2:
        StockListBinding().dependencies();
        var stockListController = Get.find<StockListController>();
        stockListController.initState();
        break;
      case 3:
        MineBinding().dependencies();
        var mineController = Get.find<MineController>();
        mineController.initState();
        break;
    }
  }
}

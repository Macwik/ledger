import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/home/home_binding.dart';
import 'package:ledger/modules/home/home_view.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_binding.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_view.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_binding.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_view.dart';
import 'package:ledger/modules/setting/mine/mine_binding.dart';
import 'package:ledger/modules/setting/mine/mine_view.dart';
import 'package:ledger/widget/keep_alive_page.dart';
import 'package:ledger/widget/my_bottom_bar.dart';

class MainState {
  final pageController = PageController();
  late RxInt selectedIndex;
  late List<Widget> tabPage;
  late List<BottomBarItem> tabBar;

  MainState() {
    HomeBinding().dependencies();
    CustomRecordBinding().dependencies();
    StockListBinding().dependencies();
    MineBinding().dependencies();
    selectedIndex = 0.obs;
    tabPage = [
      keepAlivePage(HomeView()),
      keepAlivePage(CustomRecordView()),
      keepAlivePage(StockListView()),
      keepAlivePage(MineView()),
    ];
    tabBar = [
      BottomBarItem('home', 'home_s', '首页'.tr),
      BottomBarItem('custom', 'customer_s', '客户'.tr),
      BottomBarItem('goods', 'goods_s', '货物'.tr),
      BottomBarItem('mine', 'mine_s', '我的'.tr),
    ];
  }
}

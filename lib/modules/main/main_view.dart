import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/double_tap_exit.dart';
import 'package:ledger/widget/my_bottom_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'main_controller.dart';

class MainView extends StatelessWidget {
  final controller = Get.find<MainController>();
  final state = Get.find<MainController>().state;

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: VisibilityDetector(
          key: Key('StockListVisibilityKey'),
          onVisibilityChanged: (VisibilityInfo visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0.2) {
              controller.updatePage();
            }
          },
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: state.pageController,
            itemCount: state.tabPage.length,
            itemBuilder: (context, index) => state.tabPage[index],
          ),
        ),
        bottomNavigationBar: GetBuilder<MainController>(
            id: 'bottomBar',
            builder: (controller) {
              return MyBottomBar(
                items: state.tabBar,
                iconSize: 48.w,
                textFontSize: 20.sp,
                currentIndex: state.selectedIndex.value,
                textFocusColor: Colours.primary,
                textUnfocusedColor: Colours.text_999,
                onTap: (int index) => controller.selectTab(index),
              );
            }),
      ),
      controller: controller,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {

  RouteAuthMiddleware({required super.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (StoreController.to.isLogin() ||
        route == RouteConfig.loginVerify ||
        route == RouteConfig.login ||
        route == RouteConfig.register) {
      return null;
    } else {
      Future.delayed(
          Duration(seconds: 1), () => Get.snackbar('提示', '登录过期,请重新登录'));
      return RouteSettings(name: RouteConfig.loginVerify);
    }
  }
}

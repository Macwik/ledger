import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/app_update_api.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ledger/entity/user/user_detail_dto.dart';
import 'package:ledger/enum/change_status.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/update_dialog/app_update_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'mine_state.dart';

class MineController extends GetxController {
  final MineState state = MineState();

  Future<void> initState() async {
    Http()
        .network<UserDetailDTO>(Method.get, UserApi.user_detail)
        .then((result) {
      if (result.success) {
        state.userDetailDTO = result.d;
        update(['user_detail_name']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void toMineDetail() {
    Get.toNamed(RouteConfig.mineDetail)?.then((value) {
      if (ChangeStatus.CHANGE == value) {
        initState();
      }
    });
  }

  ///检测当前app版本
  _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  ///版本校验
  checkUpdate(BuildContext context) async {
    /// 获得服务器版本
    var version = await _getCurrentVersion();
    Http().network<AppCheckDTO>(Method.get, AppUpdateApi.app_update_check,
        queryParameters: {'releaseLevel': version}).then((result) {
      if (!result.success) {
        Toast.show('当前版本已经是最新版');
        return;
      }
      AppCheckDTO appCheckDTO = result.d!;
      if (appCheckDTO.latest ?? true) {
        Toast.show('当前版本已经是最新版');
        return;
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => AppUpdateDialog(
                  force: appCheckDTO.forceUpdate ?? false,
                  appCheckDTO: result.d!,
                ));
      }
    });
  }

  toMyAccount() {
    Get.toNamed(RouteConfig.myAccount,
        arguments: {'isSelect': IsSelectType.FALSE.value})?.then((result) {
      update(['mine_active_ledger_name']);
    });
  }
}

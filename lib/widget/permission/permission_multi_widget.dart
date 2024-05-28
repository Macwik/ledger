import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/store/store_controller.dart';

import 'ledger_widget_type.dart';

class PermissionMultiWidget extends StatelessWidget {
  final List<String> permissionCodes;
  final LedgerWidgetType widgetType;
  final Widget child;
  final RxBool hasPermission = RxBool(false);

  PermissionMultiWidget({
    super.key,
    required this.permissionCodes,
    required this.child,
    this.widgetType = LedgerWidgetType.Offstage,
  }) {
    permissionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return widgetType == LedgerWidgetType.Visibility
        ? Visibility(
            visible: hasPermission.value,
            child: child,
          )
        : Offstage(
            offstage: !hasPermission.value,
            child: child,
          );
  }

  permissionCheck() {
    if (permissionCodes.isEmpty) {
      hasPermission.value = false;
    }
    if (permissionCodes.contains(PermissionCode.common_permission)) {
      hasPermission.value = true;
    }

    StoreController.to.getPermissionCodeAsync().then((permissionCodeList) {
      if (permissionCodeList.isEmpty) {
        hasPermission.value = false;
      }
      hasPermission.value =
          permissionCodes.any((element) => permissionCodeList.contains(element));
    });
  }
}

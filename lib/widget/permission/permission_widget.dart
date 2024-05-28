import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/store/store_controller.dart';

import 'ledger_widget_type.dart';

class PermissionWidget extends StatelessWidget {
  final String permissionCode;
  final LedgerWidgetType widgetType;
  final Widget child;
  final RxBool hasPermission = RxBool(false);

  PermissionWidget({
    super.key,
    required this.permissionCode,
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
            offstage: hasPermission.value,
            child: child,
          );
  }

  permissionCheck() {
    if (PermissionCode.common_permission == permissionCode) {
      hasPermission.value = true;
    }
    StoreController.to.getPermissionCodeAsync().then((permissionCodeList) {
      if (permissionCodeList.isEmpty) {
        hasPermission.value = false;
      }
      hasPermission.value = permissionCodeList.contains(permissionCode);
    });
  }
}

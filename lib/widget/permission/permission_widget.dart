import 'package:flutter/material.dart';
import 'package:ledger/store/store_controller.dart';

import 'ledger_widget_type.dart';

class PermissionWidget extends StatelessWidget {
  final String permissionCode;
  final LedgerWidgetType widgetType;
  final Widget child;

  const PermissionWidget({
    super.key,
    required this.permissionCode,
    required this.child,
    this.widgetType = LedgerWidgetType.Offstage,
  });

  @override
  Widget build(BuildContext context) {
    return widgetType == LedgerWidgetType.Visibility
        ? Visibility(
            visible: permissionCheck(),
            child: child,
          )
        : Offstage(
            offstage: !permissionCheck(),
            child: child,
          );
  }

  bool permissionCheck() {
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if(permissionList.isEmpty){
      return false;
    }
    return permissionList.contains(permissionCode);
  }
}



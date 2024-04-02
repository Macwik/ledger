import 'package:flutter/material.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/store/store_controller.dart';

import 'ledger_widget_type.dart';

class PermissionMultiWidget extends StatelessWidget {
  final List<String> permissionCodes;
  final LedgerWidgetType widgetType;
  final Widget child;

  const PermissionMultiWidget({
    super.key,
    required this.permissionCodes,
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
    if(permissionCodes.isEmpty){
      return false;
    }
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if(permissionList.isEmpty){
      return false;
    }
    return permissionCodes.any((element) => permissionList.contains(element));
  }
}



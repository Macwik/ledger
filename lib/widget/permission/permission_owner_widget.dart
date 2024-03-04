import 'package:flutter/material.dart';
import 'package:ledger/store/store_controller.dart';

import 'ledger_widget_type.dart';

class PermissionOwnerWidget extends StatelessWidget {
  final LedgerWidgetType widgetType;
  final Widget child;

  const PermissionOwnerWidget({
    super.key,
    required this.child,
    this.widgetType = LedgerWidgetType.Offstage,
  });

  @override
  Widget build(BuildContext context) {
    switch (widgetType) {
      case LedgerWidgetType.Visibility:
        return Visibility(
          visible: permissionCheck(),
          child: child,
        );
      case LedgerWidgetType.Offstage:
        return Offstage(
          offstage: !permissionCheck(),
          child: child,
        );
      case LedgerWidgetType.Disable:
        return AbsorbPointer(
          absorbing: !permissionCheck(),
          child: child,
        );
      default:
        return child;
    }
  }

  bool permissionCheck() {
    return StoreController.to.isCurrentLedgerOwner() ?? false;
  }
}

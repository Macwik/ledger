import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/warning.dart';

import 'custom_record_state.dart';

class CustomRecordController extends GetxController {
  final CustomRecordState state = CustomRecordState();

  Future<void> initState() async {
    //新增货物选择供应商
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['initialIndex'] != null) {
      state.initialIndex = arguments['initialIndex'];
    } else {
      state.initialIndex = 0;
    }
    if ((arguments != null) && arguments['isSelectCustom'] != null) {
      state.isSelectCustom = arguments['isSelectCustom'];
    } else {
      state.isSelectCustom = false;
    }
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    queryCustom();
  }

  //拉数据
  Future<void> queryCustom() async {
    await Http().network<List<CustomDTO>>(Method.post, CustomApi.getCustomList,
        queryParameters: {
          'customType': state.initialIndex,
          'name': state.customName,
          'debtStatus': state.debtStatus,
          'invalid': state.isSelectCustom == true ? 0 : state.invalid,
        }).then((result) {
      if (result.success) {
        state.customList = result.d;
        if ((state.customList?.isNotEmpty ?? false)) {
          state.totalCreditAmount = state.customList
              ?.map((e) => e.creditAmount ?? Decimal.zero)
              .reduce((value, element) => value + element);
          state.totalCreditCustom = state.customList
              ?.where((e) => (e.creditAmount ?? Decimal.zero) > Decimal.zero)
              .length;
        }
        if ((state.isSelectCustom == true) &&
            ((state.orderType == OrderType.SALE) ||
                (state.orderType == OrderType.PURCHASE))) {
          if (state.initialIndex == 0) {
            state.customList?.insert(
                0,
                CustomDTO(
                    customName: '默认客户',
                    used: 1,
                    creditAmount: Decimal.zero,
                    tradeAmount: Decimal.zero,
                    invalid: 0));
          } else {
            state.customList?.insert(
                0,
                CustomDTO(
                    customName: '默认供应商',
                    used: 1,
                    creditAmount: Decimal.zero,
                    tradeAmount: Decimal.zero,
                    invalid: 0));
          }
        }
        update(['custom_list', 'custom_custom_header']);
      }
    });
  }

  void searchCustom(String searchValue) {
    state.customName = searchValue;
    queryCustom();
  }

  void onClick(CustomDTO customDTO) {
    if (!state.isSelectCustom) {
      //正常客户列表
      Get.toNamed(RouteConfig.supplierDetail,
          arguments: {'customDTO': customDTO})?.then((value) {
        initState();
      });
    } else {
      //选择客户
      Get.back(result: customDTO);
    }
  }

//按钮选项
  bool isSelectedStoreType(int index) {
    return state.selectedStore == index;
  }

  void showBottomSheet(BuildContext context, CustomDTO? customDTO) {
    List<Widget> actions = [];
    if (customDTO?.used == 0) {
      actions.add(CupertinoActionSheetAction(
        onPressed: () {
          toDeleteCustom(customDTO?.id);
        },
        child: Text('删除客户'),
        isDestructiveAction: true,
      ));
    }

    if (customDTO?.invalid == 0) {
      actions.add(PermissionWidget(
        permissionCode: PermissionCode.funds_add_debt_permission,
        child: CupertinoActionSheetAction(
            onPressed: () {
              Get.offNamed(RouteConfig.addDebt,
                  arguments: {'customDTO': customDTO});
            },
            child: Text('录入欠款')),
      ));
    }

    if (customDTO?.invalid == 0) {
      actions.add(PermissionWidget(
        permissionCode:
            PermissionCode.supplier_detail_repayment_order_permission,
        child: CupertinoActionSheetAction(
            onPressed: () {
              Get.offNamed(RouteConfig.repaymentBill,
                  arguments: {'customDTO': customDTO});
            },
            child: Text('还款')),
      ));
    }

    actions.add(PermissionWidget(
        permissionCode: PermissionCode.custom_record_invalid_permission,
        child: CupertinoActionSheetAction(
          onPressed: () {
            toInvalidCustom(customDTO);
          },
          child: Text(customDTO?.invalid == 1 ? '启用客户' : '停用客户'),
        )));

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
        );
      },
    );
  }

  void toDeleteCustom(int? id) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此客户吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          Http()
              .network(Method.delete, CustomApi.deleteCustom, queryParameters: {
            'id': id,
          }).then((result) {
            if (result.success) {
              queryCustom();
              Toast.show('删除成功');
              Get.back();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  //停用客户
  void toInvalidCustom(CustomDTO? customDTO) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: customDTO?.invalid == 0 ? '确认停用此客户吗？' : '确定启用此客户吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          if (customDTO?.invalid == 0) {
            Http()
                .network(Method.put, CustomApi.customInvalid, queryParameters: {
              'id': customDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功停用');
                queryCustom();
                Get.back();
              } else {
                Toast.show(result.m.toString());
              }
            });
          } else {
            Http()
                .network(Method.put, CustomApi.customEnable, queryParameters: {
              'id': customDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功启用');
                queryCustom();
                Get.back();
              } else {
                Toast.show(result.m.toString());
              }
            });
          }
        },
      ),
      barrierDismissible: false,
    );
  }

  //筛选里欠款情况
  bool checkOrderStatus(int? orderStatus) {
    return state.debtStatus == orderStatus;
  }

  //筛选里清空条件
  void clearCondition() {
    state.debtStatus = null;
    state.invalid = 0;
    update(['switch', 'custom_status']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    queryCustom();
    Get.back();
  }

  void toAddCustom(BuildContext context) {
    List<Widget> actions = [];
    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
      },
      child: Text('通讯录导入'),
    ));

    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        Get.toNamed(RouteConfig.myAccount,arguments: {'isSelect': IsSelectType.TRUE.value});
      },
      child: Text('其他账本导入'),
    ));

    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        Get.toNamed(RouteConfig.addCustom, arguments: {'customType': state.initialIndex})?.then((value) {
          if (ProcessStatus.OK == value) {
            queryCustom();
          }
        });
      },
      child: Text('手动输入'),
    ));

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
        );
      },
    );

  }

  void customRecordGetBack() {
    clearCondition();
    Get.back();
  }
}

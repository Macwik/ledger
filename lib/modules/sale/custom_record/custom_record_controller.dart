import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';
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
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    } else {
      state.customType = 0;
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
          'customType': state.customType,
          'name': state.customName,
          'debtStatus': state.debtStatus,
          'invalid': state.isSelectCustom == true ? 0 : state.invalid,
        }).then((result) {
      if (result.success) {
        state.customList.clear();
        state.customList.addAll(result.d!);
        //
        // for (var element in state.customList) {
        //   String pinyin = PinyinHelper.getPinyinE(element.customName!);
        //   String tag = pinyin.substring(0, 1).toUpperCase();
        //   element.namePinyin = pinyin;
        //   if (RegExp('[A-Z]').hasMatch(tag)) {
        //     element.tagIndex = tag;
        //   } else {
        //     element.tagIndex = '#';
        //   }
        // }
        //
        // if ((state.customList.isNotEmpty)) {
        //   state.totalCreditAmount = state.customList
        //       .map((e) => e.creditAmount ?? Decimal.zero)
        //       .reduce((value, element) => value + element);
        //   state.totalCreditCustom = state.customList
        //       .where((e) => (e.creditAmount ?? Decimal.zero) > Decimal.zero)
        //       .length;
        // }
        // // 根据A-Z排序
        // SuspensionUtil.sortListBySuspensionTag(state.customList);
        //
        // // show sus tag.
        // SuspensionUtil.setShowSuspensionStatus(state.customList);
        //
        // // add header.
        // state.customList
        //     .insert(0, CustomDTO(customName: 'header', tagIndex: '🔍'));
        //
        // state.contactsCount = '${state.customList.length} 位朋友及联系人';
        update(['custom_list',]);
      }
    });
  }

  void searchCustom(String searchValue) {
    state.customName = searchValue;
    queryCustom();
  }


  void onClickDefaultCustom() {
      //选择客户
      Get.back(
          result:CustomDTO(
          customName: state.customType == CustomType.CUSTOM.value?'默认客户':'默认供应商',
          used: 1,
          creditAmount: Decimal.zero,
          tradeAmount: Decimal.zero,
          invalid: 0));
  }

  void onClick(CustomDTO customDTO) {
    if (!state.isSelectCustom) {
      //正常客户列表
      Get.toNamed(RouteConfig.supplierDetail, arguments: {
        'customDTO': customDTO,
        'customType': state.customType
      })?.then((value) {
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
        child: Text( state.customType == CustomType.CUSTOM.value ?'删除客户':'删除供应商'),
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
        permissionCode: state.customType == CustomType.CUSTOM.value
            ?PermissionCode.supplier_detail_repayment_order_permission
            :PermissionCode.supplier_repayment_order_permission,
        child: CupertinoActionSheetAction(
            onPressed: () {
              Get.offNamed(RouteConfig.repaymentBill,
                  arguments: {'customType': customDTO?.customType,'customId':customDTO?.id});
            },
            child: Text('还款')),
      ));
    }

    actions.add(PermissionWidget(
        permissionCode:state.customType == CustomType.CUSTOM.value
            ? PermissionCode.custom_record_invalid_permission
            :PermissionCode.supplier_custom_record_invalid_permission,
        child: CupertinoActionSheetAction(
          onPressed: () {
            toInvalidCustom(customDTO);
          },
          child: Text(customDTO?.invalid == 1
              ? state.customType == CustomType.CUSTOM.value ? '启用客户' :'启用供应商'
              : state.customType == CustomType.CUSTOM.value ? '停用客户' : '停用供应商'),
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
        content:  state.customType == CustomType.CUSTOM.value ?'确认删除此客户吗？':'确定删除此供应商吗？',
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
        content: customDTO?.invalid == 0
            ?  state.customType == CustomType.CUSTOM.value ?'确认停用此客户吗？' :'确定停用此供应商吗？'
            :  state.customType == CustomType.CUSTOM.value ?'确定启用此客户吗？':'确定启用此供应商吗？',
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
        Get.toNamed(RouteConfig.customList,
                arguments: {'isAddressList': IsSelectType.TRUE.value,'customType':state.customType==CustomType.CUSTOM.value? CustomType.CUSTOM: CustomType.SUPPLIER})
            ?.then((value) {
            queryCustom();
        });
      },
      child: Text('通讯录导入'),
    ));

    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        Get.toNamed(RouteConfig.myAccount,
            arguments: {'isSelect': IsSelectType.TRUE.value, 'customType': state.customType==CustomType.CUSTOM.value? CustomType.CUSTOM: CustomType.SUPPLIER})
        ?.then((value) => queryCustom());
      },
      child: Text('其他账本导入'),
    ));

    actions.add(CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        Get.toNamed(RouteConfig.addCustom,
            arguments: {'customType': state.customType})?.then((value) {
            queryCustom();
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

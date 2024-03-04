import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/ledger/ledger_user_detail_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'employee_state.dart';

class EmployeeController extends GetxController {
  final EmployeeState state = EmployeeState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['userId'] != null) {
      state.id = arguments['userId'];
    }
    _queryData();
  }

  _queryData() {
    Http().network<LedgerUserDetailDTO>(Method.get, AuthApi.employee_detail,
        queryParameters: {'userId': state.id}).then((result) {
      if (result.success) {
        state.ledgerUserDetailDTO = result.d;
        state.roleName = state.ledgerUserDetailDTO?.roleDTO?.roleName;
        state.roleId = state.ledgerUserDetailDTO?.roleDTO?.id;
        state.date = result.d?.entryDate;
        update(['employee_detail']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void onEdit() {
    state.isEdit = !state.isEdit;
    update(['employee_detail', 'employee_btn', 'employee_edit']);
  }

  void toDeleteEmployee() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此员工吗？',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.delete, AuthApi.employee_delete,
              queryParameters: {
                'userId': state.ledgerUserDetailDTO?.userBaseDTO?.id,
              }).then((result) {
            if (result.success) {
              Toast.show('删除成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void updateEmployee() {
    if (null == state.ledgerUserDetailDTO?.roleDTO?.roleName) {
      Toast.show('请选择员工岗位');
      return;
    }
    Http().network(Method.put, AuthApi.employee_upDate, data: {
      'userId': state.id,
      'roleId': state.roleId,
      'entryDate':
          state.date == null ? null : DateUtil.formatDefaultDate(state.date!),
    }).then((result) {
      if (result.success) {
        Toast.show('修改成功');
        Get.back();
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // 设置初始日期
        firstDate: DateTime(2000),
        // 设置日期范围的开始日期
        lastDate: DateTime.now(),
        // 设置日期范围的结束日期
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              highlightColor: Theme.of(context).primaryColor, // 使用主题色作为高亮色
              colorScheme: ThemeData.light().colorScheme.copyWith(
                    primary: Theme.of(context).primaryColor, // 使用主题色作为主要颜色
                    onPrimary: Colors.white, // 设置主要颜色的文本颜色
                  ),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      state.date = picked;
      update(['employee_detail']);
    }
  }

  Future<void> select() async {
    if (state.isEdit) {
      await Get.toNamed(RouteConfig.permissionManage,
              arguments: {'IsSelectType': IsSelectType.TRUE})
          ?.then((value) {
        RoleDTO? result = value as RoleDTO?;
        state.roleName = result?.roleName;
        state.roleId = result?.id;
        update(['employee_detail']);
      });
    }
  }

  void employeeGetBack() {
    if (state.isEdit) {
      Get.dialog(AlertDialog(
          title: Text('是否确认退出'),
          content: Text('退出后将无法恢复'),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
          ]));
    } else {
      Get.back();
    }
  }
}

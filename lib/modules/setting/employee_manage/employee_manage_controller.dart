import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'employee_manage_state.dart';

class EmployeeManageController extends GetxController {
  final EmployeeManageState state = EmployeeManageState();

  Future<void> initState() async {
    queryLedgerUserList();
  }

  Future<void> queryLedgerUserList() async {
    final result = await Http()
        .network<List<UserBaseDTO>>(Method.get, LedgerApi.ledger_user_list);
    if (result.success) {
      state.items = result.d;
      update(['employee_manage_employee_list']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void toInviteEmployee() {
    Get.toNamed(RouteConfig.inviteEmployee)?.then((value) {
      queryLedgerUserList();
    });
  }

  void toPermissionManage() {
    Get.toNamed(RouteConfig.permissionManage,
        arguments: {'IsSelectType': IsSelectType.FALSE});
  }

  void employeeDetail(UserBaseDTO? user) {
    Get.toNamed(RouteConfig.employee, arguments: {'userId': user?.id})
        ?.then((result) {
      if (ProcessStatus.OK == result) {
        queryLedgerUserList();
      }
    });
  }
}

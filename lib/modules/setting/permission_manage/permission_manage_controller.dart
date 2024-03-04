import 'package:get/get.dart';
import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'permission_manage_state.dart';

class PermissionManageController extends GetxController {
  final PermissionManageState state = PermissionManageState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['IsSelectType']  != null) {
      state.isSelect = arguments['IsSelectType'];
    }
    Http().network<List<RoleDTO>>(
      Method.get,
      AuthApi.ledger_role_list,
    ).then((result) {
      if (result.success) {
        state.roleList = result.d;
        update(['permission_manage_list']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void toAddRole() {
    Get.toNamed(RouteConfig.addRole)?.then((value) {
      if (ProcessStatus.OK == value) {
        initState();
      }
    });
  }

  void toRoleAuth(RoleDTO roleDTO) {
    if(state.isSelect == IsSelectType.TRUE){
      Get.back(result: roleDTO);
    }else{
      Get.toNamed(RouteConfig.authUpdate, arguments: {'role': roleDTO});
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/dialog/single_input_dialog.dart';

import 'invite_employee_state.dart';

class InviteEmployeeController extends GetxController {
  final InviteEmployeeState state = InviteEmployeeState();

Future<void> initState() async {

    queryLedgerRoleList();
  }

  Future<void> queryLedgerRoleList() async {
  Loading.showDuration();
    final result = await Http()
        .network<List<RoleDTO>>(Method.get, AuthApi.ledger_role_list);
    Loading.dismiss();
    if (result.success) {
      state.roleList = result.d;
      update();
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> inviteEmployee(int index) async {
    var roleDTO = state.roleList![index];
    SingleInputDialog().singleInputDialog(
      title: roleDTO.roleName ?? '',
      hintText: '请输入员工手机号',
      keyboardType: TextInputType.phone,
      validator: FormBuilderValidators.required(errorText: '手机号不能为空'.tr),
      onOkPressed: (value) async {
        final result = await Http()
            .network<void>(Method.post, LedgerApi.ledger_invite, data: {
          'phone': value,
          'userRole': roleDTO.id,
        });
        if (result.success) {
          Toast.show('邀请成功');
          Get.back(result: ProcessStatus.OK);
          return true;
        } else {
          Toast.show(result.m.toString());
          return false;
        }
      },
    );
  }
}

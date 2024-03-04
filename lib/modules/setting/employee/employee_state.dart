import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/ledger/ledger_user_detail_dto.dart';

class EmployeeState {
  EmployeeState() {
    ///Initialize variables
  }
  final formKey = GlobalKey<FormBuilderState>();

  bool isEdit = false;

  RoleDTO? roleDTO;

  String? roleName;

  int? roleId;

  LedgerUserDetailDTO? ledgerUserDetailDTO;

  //选择日期
  DateTime? date;

 int? id ;
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';

class AccountManageState {
  var selectedBusinessScope = 0;
  var selectedStore = 0;

  AccountManageState() {
    ///Initialize variables
  }

  LedgerUserRelationDetailDTO? ledgerUserRelationDetailDTO;

  bool isEdit = false;

  final formKey = GlobalKey<FormBuilderState>();

 int? ledgerId;

  TextEditingController nameController = TextEditingController();
}

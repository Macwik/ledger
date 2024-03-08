import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';

class MyAccountState {
  final refreshController = EasyRefreshController();
  UserLedgerDTO? userLedger;

  LedgerUserRelationDetailDTO ? ledgerUserRelationDetailDTO;

  final formKey = GlobalKey<FormBuilderState>();

  int ? isSelect ;

  MyAccountState();

}

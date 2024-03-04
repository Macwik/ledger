import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';

class AddDebtState {
  AddDebtState() {
    ///Initialize variables
  }
  final formKey = GlobalKey<FormBuilderState>();

  DateTime date = DateTime.now();

  CustomDTO ? customDTO;

}

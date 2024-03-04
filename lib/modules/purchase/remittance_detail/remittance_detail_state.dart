import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/remittance/remittance_detail_dto.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';

class RemittanceDetailState {
  final formKey = GlobalKey<FormBuilderState>();

  RemittanceDetailDTO ? remittanceDetailDTO;

  RemittanceDTO ? remittanceDTO;

  RemittanceDetailState() {
    ///Initialize variables
  }
}

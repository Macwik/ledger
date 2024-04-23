import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';

class CostTypeState {
  List<CostIncomeLabelTypeDTO>? costLabelTypeDTO;
  List<CostIncomeLabelTypeDTO>? dailyLabelTypeDTO;

  CostOrderType? costOrderType;

  CostTypeState() {
    ///Initialize variables
  }
  final formKey = GlobalKey<FormBuilderState>();

  TextEditingController incomeNameController = TextEditingController();

  TextEditingController costNameController = TextEditingController();

}

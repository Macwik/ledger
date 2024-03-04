import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';

class CustomDetailState {
  final formKey = GlobalKey<FormBuilderState>();

  CustomDTO? customDTO;

  int? customType;

  int? customId;

  bool isEdit = false;

  TextEditingController nameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController remarkController= TextEditingController();

  CustomDetailState() {
    ///Initialize variables
  }
}

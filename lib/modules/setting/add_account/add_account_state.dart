import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddAccountState {
  AddAccountState() {
    ///Initialize variables
  }
  var selectedStore = 0;
  var selectedBusinessScope = 0;

  final formKey = GlobalKey<FormBuilderState>();

  TextEditingController nameController = TextEditingController();

  bool firstIndex = false;
}

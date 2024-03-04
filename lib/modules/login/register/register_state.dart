import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RegisterState {
  RegisterState() {
    ///Initialize variables
  }

  var countdown = 0.obs;
  Timer? timer;

  String? password;

  bool privacyAgreement = false;

  final formKey = GlobalKey<FormBuilderState>();

}

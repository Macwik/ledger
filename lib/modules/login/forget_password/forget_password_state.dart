import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ForgetPasswordState {
  ForgetPasswordState() {
    ///Initialize variables
  }

  int? type;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordVerifyController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController verifyCodeController = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginVerifyState {
  LoginVerifyState() {
    ///Initialize variables
  }

  bool privacyAgreement = false;

  LoginVerifyType loginVerifyType = LoginVerifyType.VERIFY_CODE;


  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
}

enum LoginVerifyType {
  ///PASSWORD
  PASSWORD,

  ///Register
  VERIFY_CODE,
}

extension LoginVerifyTypeExtension on LoginVerifyType {
  int get value {
    switch (this) {
      case LoginVerifyType.PASSWORD:
        return 0;
      case LoginVerifyType.VERIFY_CODE:
        return 1;
      default:
        throw Exception('无此登录类型');
    }
  }
}

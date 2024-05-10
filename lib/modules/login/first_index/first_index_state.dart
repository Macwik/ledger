import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FirstIndexState {
  FirstIndexState() {
    ///Initialize variables
  }

  final formKey = GlobalKey<FormBuilderState>();

  String? password;

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController verifyPasswordController = TextEditingController();
}

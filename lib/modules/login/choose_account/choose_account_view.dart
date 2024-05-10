import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_account_controller.dart';

class ChooseAccountView extends StatelessWidget {
  ChooseAccountView({Key? key}) : super(key: key);

  final controller = Get.find<ChooseAccountController>();
  final state = Get.find<ChooseAccountController>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

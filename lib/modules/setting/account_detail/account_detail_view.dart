import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_detail_controller.dart';

class AccountDetailView extends StatelessWidget {
  AccountDetailView({super.key});

  final controller = Get.find<AccountDetailController>();
  final state = Get.find<AccountDetailController>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

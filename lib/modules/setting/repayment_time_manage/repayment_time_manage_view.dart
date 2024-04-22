import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'repayment_time_manage_controller.dart';

class RepaymentTimeManageView extends StatelessWidget {
  RepaymentTimeManageView({super.key});

  final controller = Get.find<RepaymentTimeManageController>();
  final state = Get.find<RepaymentTimeManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '还款时间设置',),
        body: ElevatedButton(
          onPressed: () {
            controller.showTimeRange(context);
          }, child: Text('设置时间'),
        ));
  }
}

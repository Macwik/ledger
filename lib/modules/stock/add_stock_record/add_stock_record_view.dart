import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_stock_record_controller.dart';

class AddStockRecordView extends StatelessWidget {
  AddStockRecordView({super.key});

  final controller = Get.find<AddStockRecordController>();
  final state = Get.find<AddStockRecordController>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

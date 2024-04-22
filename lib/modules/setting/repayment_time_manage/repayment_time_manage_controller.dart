import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/setting_api.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'repayment_time_manage_state.dart';

class RepaymentTimeManageController extends GetxController {
  final RepaymentTimeManageState state = RepaymentTimeManageState();

  Future<void> initState() async {
    _querySalesLineConfig();
  }

  Future<void> _querySalesLineConfig() async {
    final result = await Http().network<SalesLineDTO>(Method.get, SettingApi.GET_REPAYMENT_TIME);
    if (result.success) {
      state.salesLineDTO = result.d!;
      update(['']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> _setSalesLineConfig(TimeOfDay startTime, TimeOfDay endTime) async {
    final result =
        await Http().network(Method.post, SettingApi.ADD_REPAYMENT_TIME, data: {
      'startTime': DateUtil.formatDefaultTime(startTime),
      'endTime': DateUtil.formatDefaultTime(endTime),
    });
    if (result.success) {
      Toast.showSuccess('设置成功');
    } else {
      Toast.show(result.m.toString());
    }
  }

  showTimeRange(BuildContext context) async {
    TimeRange result = await showTimeRangePicker(
      start: DateUtil.ofTimeOfDay(state.salesLineDTO?.startTime),
      end: DateUtil.ofTimeOfDay(state.salesLineDTO?.endTime),
      context: context,
    );
    _setSalesLineConfig(result.startTime, result.endTime);
  }
}

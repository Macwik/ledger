import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/setting_api.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';

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
      update(['repayment_time_manage']);
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
      _querySalesLineConfig();
      Toast.showSuccess('设置成功');
    } else {
      Toast.show(result.m.toString());
    }
  }

  showTimeRange(BuildContext context) async {
    Get.dialog(TimePicker(
        initTime: PickedTime(h: 0, m: 0),
        endTime: PickedTime(h: 8, m: 0),
        onSelectionChange: (start, end, isDisableRange) =>
            print(
                'onSelectionChange => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}, isDisableRangeRange: $isDisableRange'),
        onSelectionEnd: (start, end, isDisableRange) =>
            _setSalesLineConfig(TimeOfDay(hour: start.h, minute: start.m), TimeOfDay(hour: end.h, minute: end.m))
    ));

    // TimeRange result = await showTimeRangePicker(
    //   start: DateUtil.ofTimeOfDay(state.salesLineDTO?.startTime),
    //   end: DateUtil.ofTimeOfDay(state.salesLineDTO?.endTime),
    //   context: context,
    // );
    // _setSalesLineConfig(result.startTime, result.endTime);
  }
}

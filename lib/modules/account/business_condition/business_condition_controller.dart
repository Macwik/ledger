import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';

import 'business_condition_state.dart';

class BusinessConditionController extends GetxController {
  final BusinessConditionState state = BusinessConditionState();

  Future<void> selectDateRange(BuildContext context) async {
    await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange: DateTimeRange(
        start: state.startDate,
        end: state.endDate,
      ),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      locale: const Locale('zh', 'CN'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colours.primary, // 设置确定按钮的颜色
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        state.startDate = value.start;
        state.endDate = value.end;
        update(['date_range']);
      }
    });
  }

}

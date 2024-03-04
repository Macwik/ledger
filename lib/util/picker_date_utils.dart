import 'package:flutter/material.dart';
import 'package:ledger/res/colors.dart';

class PickerDateUtils {
  ///筛选日期  -- 单日期
  static Future<void> pickerDate(
      BuildContext context, Function(DateTime? result) onClick,
      {initialDate, firstDate, lastDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        // 设置初始日期
        firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 365)),
        // 设置日期范围的开始日期
        lastDate: lastDate ?? DateTime.now(),
        // 设置日期范围的结束日期
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              highlightColor: Theme.of(context).primaryColor, // 使用主题色作为高亮色
              colorScheme: ThemeData.light().colorScheme.copyWith(
                    primary: Theme.of(context).primaryColor, // 使用主题色作为主要颜色
                    onPrimary: Colors.white, // 设置主要颜色的文本颜色
                  ),
            ),
            child: child!,
          );
        });
    onClick(picked);
  }

  //时间区间
  Future<void> pickerDateRange(
    BuildContext context,
    Function(DateTimeRange? result) onClick, {
    startDate,
    endDate,
    firstDate,
    lastDate,
  }) async {
    await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange: DateTimeRange(
        start: startDate ?? DateTime.now().subtract(Duration(days: 7)),
        end: endDate ?? DateTime.now(),
      ),
      firstDate: firstDate ?? DateTime(DateTime.now().year - 1),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
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
      onClick(value);
    });
  }
}

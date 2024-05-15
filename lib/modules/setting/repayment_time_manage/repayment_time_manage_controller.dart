import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/setting_api.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';

import 'repayment_time_manage_state.dart';

import 'package:intl/intl.dart' as intl;

class RepaymentTimeManageController extends GetxController {
  final RepaymentTimeManageState state = RepaymentTimeManageState();

  Future<void> initState() async {
    _querySalesLineConfig();
  }

  Future<void> _querySalesLineConfig() async {
    final result = await Http()
        .network<SalesLineDTO>(Method.get, SettingApi.GET_REPAYMENT_TIME);
    if (result.success) {
      state.salesLineDTO = result.d!;
      update(['repayment_time_manage']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> _setSalesLineConfig(PickedTime start, PickedTime end) async {
    final result =
        await Http().network(Method.post, SettingApi.ADD_REPAYMENT_TIME, data: {
      'startTime': DateUtil.formatDefaultTime(start),
      'endTime': DateUtil.formatDefaultTime(end),
    });
    if (result.success) {
      _querySalesLineConfig();
      Toast.showSuccess('设置成功');
    } else {
      Toast.show(result.m.toString());
    }
    Get.back();
  }

  final ClockIncrementTimeFormat _clockIncrementTimeFormat = ClockIncrementTimeFormat.fiveMin;
  ///Start时间轮代码
  final ClockTimeFormat _clockTimeFormat = ClockTimeFormat.twentyFourHours;

  ///初始值
  late TimeOfDay startTime = DateUtil.ofTimeOfDay(state.salesLineDTO?.startTime);
  late TimeOfDay endTime = DateUtil.ofTimeOfDay(state.salesLineDTO?.endTime);
  late PickedTime _startTime = PickedTime(h: startTime.hour, m: startTime.minute);
  late PickedTime _endTime = PickedTime(h: endTime.hour, m: endTime.minute);

  showTimeRange(BuildContext context) async {

    Get.dialog(
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '还款时间段设置',
              style: TextStyle(
                color:Colours.primary,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.w,),
            GetBuilder<RepaymentTimeManageController>(
                id: 'repayment_time_picker',
                builder: (_){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _timeWidget(
                        '开始时间',
                        _startTime,
                        Icon(
                          Icons.not_started_outlined ,
                          size: 20.0,
                          color:Colours.primary,
                        ),
                      ),
                      _timeWidget(
                        '结束时间',
                        _endTime,
                        Icon(
                          Icons.power_settings_new_outlined,
                          size: 20.0,
                          color:Colours.primary,
                        ),
                      ),
                    ],
                  );
                }),
            TimePicker(
              initTime:_startTime ,
              endTime: _endTime,
              height: 260,
              width: 260,
              onSelectionChange: _updateLabels,
              onSelectionEnd: (start, end, isDisableRange) => print(
                  'onSelectionEnd => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}'),
              primarySectors: _clockTimeFormat.value,
              secondarySectors: _clockTimeFormat.value * 2,
              decoration: TimePickerDecoration(
                baseColor: Color(0xFF1F2633),
                pickerBaseCirclePadding: 15.0,
                sweepDecoration: TimePickerSweepDecoration(
                  pickerStrokeWidth: 30.0,
                  pickerColor: Colours.primary,
                  showConnector: true,
                ),
                initHandlerDecoration: TimePickerHandlerDecoration(
                  color: Color(0xFF141925),
                  shape: BoxShape.circle,
                  radius: 12.0,
                  icon: Icon(
                    Icons.not_started_outlined,
                    size: 20.0,
                    color:Colours.primary,
                  ),
                ),
                endHandlerDecoration: TimePickerHandlerDecoration(
                  color: Color(0xFF141925),
                  shape: BoxShape.circle,
                  radius: 12.0,
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    size: 20.0,
                    color:Colours.primary,
                  ),
                ),
                primarySectorsDecoration: TimePickerSectorDecoration(
                  color:  Color(0xFF1F2633),
                  width: 1.0,
                  size: 4.0,
                  radiusPadding: 25.0,
                ),
                secondarySectorsDecoration: TimePickerSectorDecoration(
                  color:Colours.primary,
                  width: 1.0,
                  size: 2.0,
                  radiusPadding: 25.0,
                ),
                clockNumberDecoration: TimePickerClockNumberDecoration(
                  defaultTextColor:  Color(0xFF1F2633),
                  defaultFontSize: 12.0,
                  scaleFactor: 2.0,
                  showNumberIndicators: true,
                  clockTimeFormat: _clockTimeFormat,
                  clockIncrementTimeFormat: _clockIncrementTimeFormat,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedBtn(
                    elevation: 2,
                    margin: EdgeInsets.only(top: 80.w),
                    size: Size(double.infinity, 110.w),
                    onPressed: () => Get.back(),
                    radius: 15.w,
                    backgroundColor: Colors.white,
                    text: '取消',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: ElevatedBtn(
                    onPressed: () => _setSalesLineConfig(_startTime,_endTime),
                    elevation: 2,
                    margin: EdgeInsets.only(top: 80.w),
                    size: Size(double.infinity, 110.w),
                    radius: 15.w,
                    backgroundColor: Colours.primary,
                    text: '确定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

    //   TimeRange result = await showTimeRangePicker(
    //     start: DateUtil.ofTimeOfDay(state.salesLineDTO?.startTime),
    //     end: DateUtil.ofTimeOfDay(state.salesLineDTO?.endTime),
    //     context: context,
    //   );
    //   _setSalesLineConfig(result.startTime, result.endTime);
    // }
  }

  Widget _timeWidget(String title, PickedTime time, Icon icon) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Color(0xFF1F2633),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat('00').format(time.m)}',
              style: TextStyle(
                color:Colours.primary,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                color:Colours.primary,
                fontSize: 40.sp,
              ),
            ),
            SizedBox(height: 15),
            icon,
          ],
        ),
      ),
    );
  }

  void _updateLabels(PickedTime init, PickedTime end, bool? isDisableRange) {
    _startTime = init;
    _endTime = end;
    update(['repayment_time_picker']);
  }

}

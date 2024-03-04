import 'package:get/get.dart';
import 'package:ledger/config/api/calculate_scale_api.dart';
import 'package:ledger/entity/calculate/calculate_scale_dto.dart';
import 'package:ledger/enum/calculate_scale.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';

import 'account_setting_state.dart';

class AccountSettingController extends GetxController {
  final AccountSettingState state = AccountSettingState();

  Future<void> initState() async {
    _queryData();
  }

  _queryData() {
    Http().network<CalculateScaleDTO>(Method.get, CalculateScaleApi.get_calculate_scale,
    ).then((result) {
      if (result.success) {
        state.calculateType = result.d?.scale;
        update(['account_setting_calculate']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  String getOrderTypeDesc() {
    var list = CalculateScale.values;
    for (var value in list) {
      if (value.value == state.calculateType) {
        return value.desc;
      }
    }
    return '';
  }

  toDecimalSetting() {
    Get.toNamed(RouteConfig.decimalSetting)?.then((value) {
      if (ProcessStatus.OK == value) {
        _queryData();
      }
    });
  }
}

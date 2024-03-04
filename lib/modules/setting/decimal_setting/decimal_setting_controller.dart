import 'package:get/get.dart';
import 'package:ledger/config/api/calculate_scale_api.dart';
import 'package:ledger/entity/calculate/calculate_scale_dto.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'decimal_setting_state.dart';

class DecimalSettingController extends GetxController {
  final DecimalSettingState state = DecimalSettingState();

  Future<void> initState() async {
    _queryData();
  }

  _queryData() {
    Http().network<CalculateScaleDTO>(Method.get, CalculateScaleApi.get_calculate_scale,
    ).then((result) {
      if (result.success) {
        state.calculateScale = result.d;
        update(['decimal_setting_calculate_change']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  changeCalculate(int? type) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认切换精确度吗',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.post, CalculateScaleApi.add_calculate_scale, data: {
            'id':state.calculateScale?.id,
            'scale': type,
          }).then((result) {
            if (result.success) {
              Toast.show('精确度切换成功');
              _queryData();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }


}

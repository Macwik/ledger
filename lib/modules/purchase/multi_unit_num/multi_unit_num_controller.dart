import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/unit_api.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/modules/purchase/multi_unit_num/option_item.dart';
import 'package:ledger/res/export.dart';

import 'multi_unit_num_state.dart';

class MultiUnitNumController extends GetxController {
  final MultiUnitNumState state = MultiUnitNumState();


  void onFormWeightChange() {
    state.formKeyWeight.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['multi_unit_btn']);
  }

  void onFormNumChange() {
    state.formKeyNum.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['multi_unit_btn']);
  }

  void addUnit() {
    String? conversion;
    if (state.unitType == 1) {
      conversion = state.formKeyWeight.currentState!.fields['conversion']?.value;
    } else {
      conversion = state.formKeyNum.currentState!.fields['conversion']?.value;
    }
    Loading.showDuration();
    Http().network<UnitDetailDTO>(Method.post, UnitApi.add_multi_unit, data: {
      'masterUnitId': state.selectedMasterOption?.id,
      'slaveUnitId': state.selectedSlaveOption?.id,
      'conversion': Decimal.parse(conversion!),
      'unitType': state.unitType,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back(result: result.d);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void selectMasterUnit(OptionItem optionItem) {
    state.selectedMasterOption = optionItem;
    update(['select_master_unit', 'conversion_unit']);
  }

  void selectSlaveUnit(OptionItem optionItem) {
    state.selectedSlaveOption = optionItem;
    update(['select_slave_unit', 'conversion_unit',]);
  }

  switchTab(int index) {
    state.unitType = index + 1;
    state.selectedMasterOption = null;
    state.selectedSlaveOption = null;
    update(['select_master_unit', 'select_slave_unit', 'conversion_unit']);
  }
}

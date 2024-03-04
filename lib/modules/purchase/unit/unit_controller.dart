import 'package:get/get.dart';
import 'package:ledger/config/api/unit_api.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/entity/unit/unit_dto.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';

import 'unit_state.dart';

class UnitController extends GetxController {
  final UnitState state = UnitState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['mode'] != null) {
      state.pageMode = arguments['mode'];
    }
    _queryUnitList();
  }

  Future<void> _queryUnitList() async {
    final result =
        await Http().network<List<UnitDTO>>(Method.get, UnitApi.unit_list);
    if (result.success) {
      state.unitList = result.d!;
      update(['unitList']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void selectUnit(UnitDTO unitDTO) {
    if (state.pageMode == 1) {
      state.unitDetailDTO = UnitDetailDTO(
          unitId: unitDTO.id, unitName: unitDTO.unitName, unitType: 0);
      update(['unitList']);
      Future.delayed(const Duration(milliseconds: 500));
      Get.back(result: state.unitDetailDTO);
    }
  }

  Future<void> toMultiUnit() async {
    var result = await Get.toNamed(RouteConfig.multiUnitNum);
    Get.back(result: result);
  }
}
